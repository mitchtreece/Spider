//
//  EventSource.swift
//  Spider-Web
//
//  Created by Mitch Treece on 7/25/20.
//

import Foundation

public class EventSource: NSObject {
    
//    static let DefaultRetryTime = 3000

    
    public enum State {
        
        case idle
        case connecting
        case connected
        case disconnected
        
    }
    
    public let url: URLRepresentable
    
    public var authorization: RequestAuth?
    
    public var headers: Headers
    public private(set) var state: State = .idle
    
    private var onConnecting: (()->())?
    private var onConnected: (()->())?
    private var onDisconnected: ((_ reconnect: Bool)->())?
    private var onMessage: ((Event)->())?
    private var eventMap = [String: (Event)->()]()
    
    private var queue: OperationQueue
    private var streamParser: EventStreamParser?
    private var session: URLSession?
    
    private var lastEventId: String?
    
    public init(url: URLRepresentable) {
        
        self.url = url
        
        self.headers = Headers()
        self.headers.acceptTypes = [.text_event_stream]
        self.headers.set(value: "no-cache", forField: "Cache-Control")
        
        self.queue = OperationQueue()
        self.queue.maxConcurrentOperationCount = 1
                
    }
    
    public func connect(lastEventId: String? = nil) {
        
        guard let url = self.url.url else {
            // todo: error
            return
        }
        
        self.streamParser = EventStreamParser()
        self.state = .connecting
        
        self.session = urlSession(lastEventId: lastEventId)
        self.session?
            .dataTask(with: url)
            .resume()
        
    }
    
    public func disconnect() {
        
        self.state = .disconnected
        self.session?.invalidateAndCancel()
        
    }
    
    public func connecting(_ body: @escaping ()->()) {
        self.onConnecting = body
    }
    
    public func connected(_ body: @escaping ()->()) {
        self.onConnected = body
    }
    
    public func disconnected(_ body: @escaping (_ reconnect: Bool)->()) {
        self.onDisconnected = body
    }
    
    public func message(_ body: @escaping (Event)->()) {
        self.onMessage = body
    }
    
    public func event(_ name: String, _ body: @escaping (Event)->()) {
        self.eventMap[name] = body
    }
    
    public func remove(event: String) {
        self.eventMap[event] = nil
    }
    
    public func removeAllEvents() {
        self.eventMap.removeAll()
    }
    
    // MARK: Private
    
    private func urlSession(lastEventId: String?) -> URLSession {
                
        if let eventId = lastEventId {
            self.headers.set(value: eventId, forField: "Last-Event-Id")
        }
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = TimeInterval(INT_MAX)
        config.timeoutIntervalForResource = TimeInterval(INT_MAX)
        config.httpAdditionalHeaders = self.headers.prepare(for: self)
        
        return URLSession(
            configuration: config,
            delegate: self,
            delegateQueue: self.queue
        )
        
    }
    
    private func receivedEvents(_ events: [Event]) {
        
        for e in events {
            
            self.lastEventId = e.id
            // retryTime = event.retryTime ?? EventSource.DefaultRetryTime
            
//            if event.onlyRetryEvent == true {
//                continue
//            }
            
            if e.name == nil || e.name == "message" {
                
                DispatchQueue.main.async { [weak self] in
                    
                    self?.onMessage?(Event(
                        id: e.id,
                        name: "message",
                        data: e.data
                    ))
                    
                }
                
            }
            else if let name = e.name,
                let handler = self.eventMap[name] {
                
                DispatchQueue.main.async {
                    handler(e)
                }
                
            }
            
        }
        
    }

    // "5 Processing model"
    // https://www.w3.org/TR/2009/WD-eventsource-20090421/#handler-eventsource-onerror
    private func shouldReconnect(statusCode: Int) -> Bool {
        
        switch statusCode {
        case 200: return false
        case _ where (statusCode > 200 && statusCode < 300): return true
        default: return false
        }
        
    }
    
}

extension EventSource: URLSessionDataDelegate {
    
    public func urlSession(_ session: URLSession,
                           dataTask: URLSessionDataTask,
                           didReceive response: URLResponse,
                           completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        completionHandler(URLSession.ResponseDisposition.allow)
        
        self.state = .connected
        
        DispatchQueue.main.async { [weak self] in
            self?.onConnected?()
        }
                
    }
    
    public func urlSession(_ session: URLSession,
                           dataTask: URLSessionDataTask,
                           didReceive data: Data) {
        
        guard self.state == .connected else { return }
        let events = self.streamParser?.append(data: data) ?? []
        receivedEvents(events)

    }

    public func urlSession(_ session: URLSession,
                           task: URLSessionTask,
                           willPerformHTTPRedirection response: HTTPURLResponse,
                           newRequest request: URLRequest,
                           completionHandler: @escaping (URLRequest?) -> Void) {
        
        var newRequest = request
        
        self.headers
            .prepare(for: self)
            .forEach { newRequest.setValue($1, forHTTPHeaderField: $0) }
        
        completionHandler(newRequest)
        
    }
    
    public func urlSession(_ session: URLSession,
                           task: URLSessionTask,
                           didCompleteWithError error: Error?) {
        
        guard let statusCode = (task.response as? HTTPURLResponse)?.statusCode else {
            
            DispatchQueue.main.async { [weak self] in
                self?.onDisconnected?(false)
            }
            
            return
            
        }
        
        let reconnect = shouldReconnect(statusCode: statusCode)
        
        DispatchQueue.main.async { [weak self] in
            self?.onDisconnected?(reconnect)
        }
        
    }
    
}
