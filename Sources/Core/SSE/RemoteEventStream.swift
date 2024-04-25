//
//  RemoteEventStream.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/6/20.
//

import Foundation

/// A remote event stream class used to manage
/// connection & observation of server-side-events.
public class RemoteEventStream: NSObject {
    
    /// A stream event listener.
    public typealias StreamEventListener = (StreamEvent)->()
    
    /// Representation of the various event stream events.
    public enum StreamEvent {
        
        /// A stream connection event.
        case connected
        
        /// A stream disconnection event.
        case disconnected(DisconnectInfo)
        
        /// A received stream event.
        case event(RemoteEvent)

        public var name: String {
            
            switch self {
            case .connected: return "connected"
            case .disconnected: return "disconnected"
            case .event(let event): return event.type.name
            }
            
        }
        
    }
    
    /// Representation of the various event stream states.
    public enum State: Int {
        
        /// A connecting state.
        case connecting
        
        /// An connected state.
        case connected
        
        /// A disconnected state.
        case disconnected
        
    }
    
    /// Representation of the various event stream errors.
    public enum StreamError: Error {
        
        case invalidUrl
        
    }
    
    /// Type that provides information around the conditions
    /// of an event stream disconnection.
    public struct DisconnectInfo {
        
        public let error: Error?
        public let statusCode: Int?
        public let reconnect: Bool
        
    }
    
    /// The default retry interval for stream events.
    public static let defaultEventRetryInterval: Int = 3000
        
    /// The event stream's stream url.
    public let url: URL
    
    /// The event stream's connection request headers.
    public var headers = [String: String]()
    
    /// Flag indicating if debug logging is enabled.
    public var isDebugLoggingEnabled: Bool = false
    
    /// The event stream's current state.
    public private(set) var state: State = .disconnected

    /// The last received stream event's ID.
    public private(set) var lastEventId: String?
    
    /// The last received stream event's retry interval.
    public private(set) var lastEventRetryInterval: Int?
    
    private var urlSession: URLSession?
    private var queue: OperationQueue
    private var parser = EventParser()
    private var listeners = [StreamEventListener]()

    /// Initializes an event stream with a given url.
    /// - parameter url: The stream url.
    ///
    /// This throws if the stream url is invalid.
    public init(url: URLRepresentable) throws {
        
        guard let url = url.asUrl() else { throw StreamError.invalidUrl }
        
        self.url = url
        
        self.queue = OperationQueue()
        self.queue.maxConcurrentOperationCount = 1
        
    }
    
    /// Connects the stream.
    /// - parameter lastEventId: The last event id to use while connecting.
    /// If this is set, it will be passed along while connecting. This can be
    /// used to "replay" past events from the stream.
    public func connect(lastEventId: String? = nil) {
                        
        guard self.state != .connected else { return }
        
        self.state = .connecting
        
        log("connecting to \(self.url.absoluteString)")
        
        self.urlSession = URLSession(
            configuration: urlSessionConfiguration(lastEventId: lastEventId),
            delegate: self,
            delegateQueue: self.queue
        )
        
        self.urlSession!
            .dataTask(with: self.url)
            .resume()
        
    }
    
    /// Disconnects the stream.
    public func disconnect() {
        
        guard self.state != .disconnected else { return }
        
        self.state = .disconnected
        
        log("disconnecting")
        
        self.urlSession?.invalidateAndCancel()
        self.urlSession = nil
        
    }
    
    /// Adds an event listener to the stream.
    /// - parameter listener: The event listening closure.
    /// - returns: This event stream.
    ///
    /// Subsequent calls to `receive` will add additional listeners.
    @discardableResult
    public func receive(_ listener: @escaping StreamEventListener) -> Self {
        
        self.listeners
            .append(listener)
        
        return self
        
    }
    
    /// Manually sends a stream event to listeners.
    /// - parameter event: The stream event.
    public func send(_ event: RemoteEvent) {
        
        log("sending event \"\(event.type.name)\"")
        dispatch(.event(event))
        
    }

    // MARK: Private
    
    private func urlSessionConfiguration(lastEventId: String?) -> URLSessionConfiguration {
        
        var _headers = self.headers
        
        if let lastEventId = lastEventId {
            _headers["Last-Event-Id"] = lastEventId
        }

        _headers["Accept"] = "text/event-stream"
        _headers["Cache-Control"] = "no-cache"

        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = TimeInterval(INT_MAX)
        config.timeoutIntervalForResource = TimeInterval(INT_MAX)
        config.httpAdditionalHeaders = _headers

        return config
        
    }
    
    private func receivedRemoteEvents(_ events: [RemoteEvent]) {
        
        guard !events.isEmpty else { return }
                
        for event in events {
            
            self.lastEventId = event.id
            self.lastEventRetryInterval = event.retry ?? RemoteEventStream.defaultEventRetryInterval
            
            guard !event.isRetry else {
                
                log("received retry event")
                continue
                
            }
            
            dispatch(.event(event))
            
        }
        
    }
    
    private func dispatch(_ event: StreamEvent) {
                
        var message = "received event \"\(event.name)\""
        
        switch event {
        case .connected,
             .disconnected:
            
            break
            
        case .event(let e):
            
            message += " {\n"
            message += "  id: \((e.id != nil) ? "\"\(e.id!)\"" : "none")\n"
            message += "  type: \((e.rawType != nil) ? "\"\(e.rawType!)\"" : "none")\n"
            message += "  data: \((e.data != nil) ? "\"\(e.data!)\"" : "none")\n"
            message += "  retry: \((e.retry != nil) ? "\(e.retry!)" : "none")\n"
            message += "}"
            
        }
        
        log(message)
        
        self.listeners
            .forEach { $0(event) }
        
    }
    
    private func shouldReconnect(statusCode: Int?) -> Bool {
        
        // https://www.w3.org/TR/2009/WD-eventsource-20090421/#handler-eventsource-onerror
        
        guard let statusCode else { return false }
        
        switch statusCode {
        case 200: return false
        case _ where statusCode > 200 && statusCode < 300: return true
        default: return false
        }
        
    }
    
    private func log(_ message: String) {
        
        guard self.isDebugLoggingEnabled else { return }
        print("🌎 <Spider>: [SSE] \(message)")
        
    }
    
}

extension RemoteEventStream: URLSessionDataDelegate {
    
    public func urlSession(_ session: URLSession,
                           task: URLSessionTask,
                           willPerformHTTPRedirection response: HTTPURLResponse,
                           newRequest request: URLRequest,
                           completionHandler: @escaping (URLRequest?) -> Void) {
        
        var newRequest = request
        self.headers.forEach { newRequest.setValue($1, forHTTPHeaderField: $0) }
        completionHandler(newRequest)
        
    }
    
    public func urlSession(_ session: URLSession,
                           dataTask: URLSessionDataTask,
                           didReceive response: URLResponse,
                           completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        self.state = .connected
        
        completionHandler(URLSession.ResponseDisposition.allow)

        DispatchQueue.main.async { [weak self] in
            self?.dispatch(.connected)
        }
        
    }
    
    public func urlSession(_ session: URLSession,
                           dataTask: URLSessionDataTask,
                           didReceive data: Data) {
        
        guard self.state == .connected else { return }
        
        let events = self.parser
            .parse(data: data)
        
        receivedRemoteEvents(events)
                
    }
    
    public func urlSession(_ session: URLSession,
                           task: URLSessionTask,
                           didCompleteWithError error: Error?) {
                
        self.state = .disconnected
        
        DispatchQueue.main.async { [weak self] in
                        
            let statusCode = (task.response as? HTTPURLResponse)?.statusCode
            
            self?.dispatch(.disconnected(.init(
                error: error,
                statusCode: statusCode,
                reconnect: self?.shouldReconnect(statusCode: statusCode) ?? false
            )))
            
        }
                
    }
    
}
