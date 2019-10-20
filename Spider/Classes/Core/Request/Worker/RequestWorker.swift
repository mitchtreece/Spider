//
//  RequestWorker.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public class RequestWorker {
        
    private let request: Request!
    private let builder: RequestBuilder!
    private let session: URLSession!
    private let debugEnabled: Bool!
    
    private let error: Error?
    
    internal init(request: Request,
                  builder: RequestBuilder,
                  session: URLSession,
                  debugEnabled: Bool) {
        
        self.request = request
        self.builder = builder
        self.session = session
        self.debugEnabled = debugEnabled
        self.error = nil
        
    }
    
    internal init(error: Error) {
        
        self.error = error
        self.request = nil
        self.builder = nil
        self.session = nil
        self.debugEnabled = nil
        
    }
            
    public func data(_ completion: @escaping (Response<Data>)->()) {
        
        if let error = self.error {
            
            return completion(Response<Data>(
                request: self.request,
                response: nil,
                error: error
            ))
            
        }
        
        guard let urlRequest = self.builder.urlRequest(for: request) else {
            
            return completion(Response<Data>(
                request: self.request,
                response: nil,
                error: SpiderError.badUrl
            ))
            
        }
        
        _debugLogRequest()
        
        self.request.state = .working
        
        self.session.dataTask(with: urlRequest) { (data, res, err) in
            
            self.request.state = .finished
            
            if let err = err {

                return completion(Response<Data>(
                    request: self.request,
                    response: res,
                    error: HTTPError(
                        description: err.localizedDescription,
                        statusCode: HTTPStatusCode.from(response: res),
                        path: self.request.path
                    )))
                
            }
            
            guard let data = data else {
                
                return completion(Response<Data>(
                    request: self.request,
                    response: res,
                    error: SpiderError.badResponseData
                ))
                
            }
            
            return completion(Response<Data>(
                request: self.request,
                response: res,
                value: data
            ))
            
        }.resume()
        
    }
    
    public func dataValue(_ completion: @escaping (Data?, Error?)->()) {

        data { response in
            
            completion(
                response.value,
                response.error
            )
            
        }

    }
        
    private func _debugLogRequest() {
        
        guard self.debugEnabled else { return }
        
        var string = "[\(self.request.method.value)] \(self.request.path)"
        if let params = self.request.parameters {
            string += ", parameters: \(params.jsonString() ?? "some")"
        }
        
        print("🌎 <Spider>: \(string)")
        
    }
        
}
