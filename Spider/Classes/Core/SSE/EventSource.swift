//
//  EventSource.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/6/20.
//

import Foundation

public typealias EventListener = (Event)->()

/// An event source class used to manage connection & observation of server-side-events.
public class EventSource: NSObject {
    
    /// Representation of the various event source ready states.
    public enum State: Int {
        
        /// A connecting state.
        case connecting
        
        /// An open state.
        case open
        
        /// A closed state.
        case closed
        
    }
    
    /// Object used to describe an event source's closure parameters.
    public struct Closure {
        
        public let error: Error?
        public let statusCode: Int?
        public let reconnect: Bool
        
    }
    
    /// Representation of the various event source errors.
    public enum EventSourceError: Error {
        
        case invalidUrl
        
    }
    
    private static var defaultRetryTime: Int = 3000
    
    /// The event source's stream url.
    public let url: URL
    
    /// The event source's connection request headers.
    public var headers = [String: String]()
    
    /// The event source's connection retry interval; _defaults to 3000_.
    public private(set) var retryTime: Int = EventSource.defaultRetryTime
    
    /// The event source's current state.
    public private(set) var state: State = .closed

    private var urlSession: URLSession?
    private var queue: OperationQueue
    private var parser = EventParser()
    
    private var onOpened: (()->())?
    private var onClosed: ((Closure)->())?
    private var onMessageEvent: ((MessageEvent)->())?
    private var onAnyEvent: ((EventProtocol)->())?
    
    private var lastEventId: String?
    private var listeners = [String: EventListener]()

    /// Initializes an event source with a given url.
    /// - parameter url: The stream url.
    ///
    /// This initializer throws if the stream url is invalid.
    public init(url: URLRepresentable) throws {
        
        guard let url = url.url else { throw EventSourceError.invalidUrl }
        
        self.url = url
        
        self.queue = OperationQueue()
        self.queue.maxConcurrentOperationCount = 1
        
    }
    
    /// Connects the event source to the stream.
    /// - parameter lastEventId: The last event id to use while connecting; _defaults to nil_.
    ///
    /// If the `lastEventId` parameter is set, it will be passed along while connecting. This
    /// can be used to "replay" past events in the stream.
    public func connect(lastEventId: String? = nil) {
        
        self.state = .connecting
                
        self.urlSession = URLSession(
            configuration: urlSessionConfiguration(lastEventId: lastEventId),
            delegate: self,
            delegateQueue: self.queue
        )
        
        self.urlSession!
            .dataTask(with: self.url)
            .resume()
        
    }
    
    /// Disconnects the event source from the stream.
    public func disconnect() {
        
        self.state = .closed
        
        self.urlSession?.invalidateAndCancel()
        self.urlSession = nil
        
    }
    
    /// Sets the event source's stream opened listener.
    /// - parameter block: The listener block.
    /// - returns: The event stream instance.
    @discardableResult
    public func opened(_ block: @escaping ()->()) -> Self {
        
        self.onOpened = block
        return self
        
    }
    
    /// Sets the event source's stream closed listener.
    /// - parameter block: The listener block.
    /// - returns: The event stream instance.
    @discardableResult
    public func closed(_ block: @escaping (Closure)->()) -> Self {
        
        self.onClosed = block
        return self
        
    }
    
    /// Adds an event listener.
    /// - parameter type: The event type.
    /// - parameter listener: The event listener block.
    /// - returns: The event stream instance.
    @discardableResult
    public func event(_ type: String, _ listener: @escaping EventListener) -> Self {
        
        self.listeners[type] = listener
        return self
        
    }
    
    /// Adds a message event listener.
    /// - parameter block: The message event listener block.
    /// - returns: The event stream instance.
    @discardableResult
    public func message(_ block: @escaping (MessageEvent)->()) -> Self {
        
        self.onMessageEvent = block
        return self
        
    }
    
    /// Sets the event source's any event listener.
    /// - parameter block: The listener block.
    /// - returns: The event stream instance.
    ///
    /// This will always be called _after_ any typed event listeners.
    @discardableResult
    public func anyEvent(_ block: @escaping (EventProtocol)->()) -> Self {
        
        self.onAnyEvent = block
        return self
        
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
    
    private func received(events: [Event]) {
        
        guard !events.isEmpty else { return }
                
        for event in events {
            
            self.lastEventId = event.id
            self.retryTime = event.retryTime ?? EventSource.defaultRetryTime
            
            guard !event.isRetry else { continue }
            
            if event.type == nil || event.type == "message" {
                
                DispatchQueue.main.async { [weak self] in
                    self?.onMessageEvent?(event.messageEvent())
                }
                
            }
            else if let listener = self.listeners[event.type!] {
                
                DispatchQueue.main.async {
                    listener(event)
                }
                
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.onAnyEvent?(event)
            }
            
        }
        
    }
    
    private func shouldReconnect(statusCode: Int) -> Bool {
        
        // https://www.w3.org/TR/2009/WD-eventsource-20090421/#handler-eventsource-onerror
        
        switch statusCode {
        case 200: return false
        case _ where statusCode > 200 && statusCode < 300: return true
        default: return false
        }
        
    }
    
}

extension EventSource: URLSessionDataDelegate {
    
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
        
        self.state = .open
        
        completionHandler(URLSession.ResponseDisposition.allow)

        DispatchQueue.main.async { [weak self] in
            self?.onOpened?()
        }
        
    }
    
    public func urlSession(_ session: URLSession,
                           dataTask: URLSessionDataTask,
                           didReceive data: Data) {
        
        guard self.state == .open else { return }
        
        let events = self.parser.parse(data: data)
        received(events: events)
        
    }
    
    public func urlSession(_ session: URLSession,
                           task: URLSessionTask,
                           didCompleteWithError error: Error?) {
                
        guard let statusCode = (task.response as? HTTPURLResponse)?.statusCode else {

            DispatchQueue.main.async { [weak self] in
                
                self?.onClosed?(Closure(
                    error: error,
                    statusCode: nil,
                    reconnect: false
                ))
                
            }

            return

        }
        
        DispatchQueue.main.async { [weak self] in
            
            self?.onClosed?(Closure(
                error: error,
                statusCode: statusCode,
                reconnect: self?.shouldReconnect(statusCode: statusCode) ?? false
            ))
            
        }
                
    }
    
}
