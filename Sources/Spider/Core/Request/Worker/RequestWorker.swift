//
//  RequestWorker.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Espresso

/// Worker class that manages the execution and serialization of HTTP requests & responses.
public class RequestWorker: Cancellable {
    
    /// Representation of the various states of a request worker.
    public enum State {
        
        /// State representing a worker that has not started yet.
        case pending
        
        /// State representing a worker that has errored before executing.
        case aborted
        
        /// State representing a worker that has cancelled execution.
        case cancelled
        
        /// State representing a worker that is currently executing.
        case working
        
        /// State representing a worker that has finished executing.
        case finished
        
    }
    
    private let request: Request
    private let builder: RequestBuilder
    private let middlewares: [Middleware]
    private let session: URLSession
    private let isDebugEnabled: Bool
        
    /// The worker's state.
    public private(set) var state: State = .pending
    
    public private(set) var isCancelled: Bool = false
    
    private var passthroughs = [(Response<Data>)->()]()
    
    private var task: URLSessionDataTask?
    
    internal init(request: Request,
                  builder: RequestBuilder,
                  middlewares: [Middleware],
                  session: URLSession,
                  isDebugEnabled: Bool) {
        
        self.request = request
        self.builder = builder
        self.middlewares = middlewares
        self.session = session
        self.isDebugEnabled = isDebugEnabled
        
    }
    
    /// Starts the worker & serializes a `Data` response.
    /// - parameter completion: The worker's completion closure.
    public func dataResponse(_ completion: @escaping (Response<Data>)->()) {
        
        guard !self.isCancelled else {
            
            // If cancelled then no need to call completion
            
            self.state = .cancelled
            self.request.state = .cancelled
            return
            
        }
        
        guard let urlRequest = self.builder.urlRequest(for: self.request) else {
            
            self.state = .aborted
            self.request.state = .aborted
            
            return completion(Response<Data>(
                request: self.request,
                response: nil,
                data: nil,
                error: Request.Error.badUrl
            ))
            
        }
                
        self.state = .working
        self.request.state = .working
        self.request.startDate = Date()
        
        _debugLogRequest()
        
        self.task = self.session.dataTask(with: urlRequest) { (data, res, err) in
            
            guard !self.isCancelled else { return }
            
            self.state = .finished
            self.request.state = .finished
            self.request.endDate = Date()
            
            // HTTP error?
            
            if let err = err {

                return completion(Response<Data>(
                    request: self.request,
                    response: res,
                    data: data,
                    error: HTTPError(
                        description: err.localizedDescription,
                        statusCode: HTTPStatusCode.from(response: res),
                        path: self.request.path
                    )))
                
            }
            
            // Response data?
            
            guard let data = data else {
                
                return completion(Response<Data>(
                    request: self.request,
                    response: res,
                    data: nil,
                    error: Response<Data>.Error.badData
                ))
                
            }
            
            // Middlewares
            
            var response = Response<Data>(
                request: self.request,
                response: res,
                data: data,
                value: data
            )
            
            let middlewares = !self.request.ignoreSharedMiddlewares ?
                (self.request.middlewares ?? []) + self.middlewares :
                self.middlewares
            
            for middleware in middlewares {

                do {
                    response = try middleware.next(response)
                }
                catch {

                    return completion(Response<Data>(
                        request: self.request,
                        response: res,
                        data: data,
                        error: error
                    ))

                }

            }
            
            // Passthroughs
            
            self.passthroughs
                .forEach { $0(response) }
            
            // Done
            
            return completion(response)
            
        }
        
        self.task!.resume()
        
    }
    
    /// Starts the worker & serializes a `Data` value.
    /// - parameter completion: The worker's completion closure.
    public func data(_ completion: @escaping (Data?, Error?)->()) {

        dataResponse { response in
            
            completion(
                response.value,
                response.error
            )
            
        }

    }
    
    /// Adds a data-response passthrough to the worker.
    /// - parameter block: The passthrough closure.
    /// - returns: This `RequestWorker`.
    public func dataResponsePassthrough(_ block: @escaping (Response<Data>)->()) -> Self {
        
        self.passthroughs
            .append(block)
        
        return self
        
    }
    
    /// Adds a data passthrough to the worker.
    /// - parameter block: The passthrough closure.
    /// - returns: This `RequestWorker`.
    public func dataPassthrough(_ block: @escaping (Data?)->()) -> Self {
        
        return dataResponsePassthrough { res in
            block(res.value)
        }
        
    }
    
    public func cancel() {
        
        self.isCancelled = true
        self.state = .cancelled
        self.request.state = .cancelled
        self.task?.cancel()
        
    }
    
    // MARK: Private
        
    private func _debugLogRequest() {
        
        guard self.isDebugEnabled else { return }
        
        var string = "[\(self.request.method.value)] \(self.request.path)"
        if let params = self.request.parameters {
            string += ", parameters: \(params.formattedJSONString ?? "some")"
        }
        
        print("🌎 <Spider>: \(string)")
        
    }
        
}
