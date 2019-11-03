//
//  RequestWorker.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

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
    private let session: URLSession
    private let isDebugEnabled: Bool
        
    public private(set) var state: State = .pending
    public private(set) var isCancelled: Bool = false
    
    private var task: URLSessionDataTask?
    
    internal init(request: Request,
                  builder: RequestBuilder,
                  session: URLSession,
                  isDebugEnabled: Bool) {
        
        self.request = request
        self.builder = builder
        self.session = session
        self.isDebugEnabled = isDebugEnabled
        
    }
            
    public func data(_ completion: @escaping (Response<Data>)->()) {
        
        guard !self.isCancelled else {
            
            self.state = .cancelled
            self.request.state = .cancelled
            
//            return completion(Response<Data>(
//                request: self.request,
//                response: nil,
//                data: nil,
//                error: SpiderError.cancelled
//            ))
            
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
            
//            // Error catchers
//
//            let response = Response<Data>(
//                request: self.request,
//                response: res,
//                data: data,
//                value: data
//            )
//
//            for catcher in self.errorCatchers {
//
//                if let responseError = catcher.catch(response) {
//
//                    return completion(Response<Data>(
//                        request: self.request,
//                        response: res,
//                        data: data,
//                        error: responseError
//                    ))
//
//                }
//
//            }
            
            // Done
            
            return completion(Response<Data>(
                request: self.request,
                response: res,
                data: data,
                value: data
            ))
            
        }
        
        self.task!.resume()
        
    }
    
    public func dataValue(_ completion: @escaping (Data?, Error?)->()) {

        data { response in
            
            completion(
                response.value,
                response.error
            )
            
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
