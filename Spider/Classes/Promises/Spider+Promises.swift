//
//  Spider+Promises.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import PromiseKit

extension Spider {
    
    /**
     Performs a `SpiderRequest`.
     - Parameter request: The `SpiderRequest` to perform.
     - Returns: A guarantee over `SpiderResponse`.
     */
    public func perform(_ request: SpiderRequest) -> Guarantee<SpiderResponse> {

        return Guarantee<SpiderResponse> { (seal) in
            self.perform(request) { (response) in
                seal(response)
            }
        }
        
    }
    
    /**
     Performs a GET request with various configuration options.
     - Parameter path: The endpoint path to append to the global base URL **or** a fully qualified URL (if no global base URL is specified).
     ```
     "/users/12345"
     "http://base.url/v1/users/12345"
     ```
     - Parameter parameters: An optional param object to be passed along with the request.
     - Parameter auth: An optional authorization type to use for this request. This will _override_ Spider's global authorization type. If no authorization type is provided, the request will fallback to Spider's global authorization type.
     - Returns: A guarantee over `SpiderResponse`.
     */
    public func get(_ path: String,
                    parameters: JSON? = nil,
                    auth: SpiderAuth? = nil) -> Guarantee<SpiderResponse> {
        
        let request = SpiderRequest(method: "GET", path: path, parameters: parameters, auth: auth)
        
        return Guarantee<SpiderResponse> { (seal) in
            self.perform(request).done { (response) in
                seal(response)
            }
        }
        
    }
    
    /**
     Performs a POST request with various configuration options.
     - Parameter path: The endpoint path to append to the global base URL **or** a fully qualified URL (if no global base URL is specified).
     ```
     "/users/12345"
     "http://base.url/v1/users/12345"
     ```
     - Parameter parameters: An optional param object to be passed along with the request.
     - Parameter auth: An optional authorization type to use for this request. This will _override_ Spider's global authorization type. If no authorization type is provided, the request will fallback to Spider's global authorization type.
     - Returns: A guarantee over `SpiderResponse`.
     */
    public func post(_ path: String,
                     parameters: JSON? = nil,
                     auth: SpiderAuth? = nil) -> Guarantee<SpiderResponse> {
        
        let request = SpiderRequest(method: "POST", path: path, parameters: parameters, auth: auth)
        
        return Guarantee<SpiderResponse> { (seal) in
            self.perform(request).done { (response) in
                seal(response)
            }
        }
        
    }
    
    /**
     Performs a PUT request with various configuration options.
     - Parameter path: The endpoint path to append to the global base URL **or** a fully qualified URL (if no global base URL is specified).
     ```
     "/users/12345"
     "http://base.url/v1/users/12345"
     ```
     - Parameter parameters: An optional param object to be passed along with the request.
     - Parameter auth: An optional authorization type to use for this request. This will _override_ Spider's global authorization type. If no authorization type is provided, the request will fallback to Spider's global authorization type.
     - Returns: A guarantee over `SpiderResponse`.
     */
    public func put(_ path: String,
                    parameters: JSON? = nil,
                    auth: SpiderAuth? = nil) -> Guarantee<SpiderResponse> {
        
        let request = SpiderRequest(method: "PUT", path: path, parameters: parameters, auth: auth)
        
        return Guarantee<SpiderResponse> { (seal) in
            self.perform(request).done { (response) in
                seal(response)
            }
        }
        
    }
    
    /**
     Performs a PATCH request with various configuration options.
     - Parameter path: The endpoint path to append to the global base URL **or** a fully qualified URL (if no global base URL is specified).
     ```
     "/users/12345"
     "http://base.url/v1/users/12345"
     ```
     - Parameter parameters: An optional param object to be passed along with the request.
     - Parameter auth: An optional authorization type to use for this request. This will _override_ Spider's global authorization type. If no authorization type is provided, the request will fallback to Spider's global authorization type.
     - Returns: A guarantee over `SpiderResponse`.
     */
    public func patch(_ path: String,
                      parameters: JSON? = nil,
                      auth: SpiderAuth? = nil) -> Guarantee<SpiderResponse> {
        
        let request = SpiderRequest(method: "PATCH", path: path, parameters: parameters, auth: auth)
        
        return Guarantee<SpiderResponse> { (seal) in
            self.perform(request).done { (response) in
                seal(response)
            }
        }
        
    }
    
    /**
     Performs a DELETE request with various configuration options.
     - Parameter path: The endpoint path to append to the global base URL **or** a fully qualified URL (if no global base URL is specified).
     ```
     "/users/12345"
     "http://base.url/v1/users/12345"
     ```
     - Parameter parameters: An optional param object to be passed along with the request.
     - Parameter auth: An optional authorization type to use for this request. This will _override_ Spider's global authorization type. If no authorization type is provided, the request will fallback to Spider's global authorization type.
     - Returns: A guarantee over `SpiderResponse`.
     */
    public func delete(_ path: String,
                       parameters: JSON? = nil,
                       auth: SpiderAuth? = nil) -> Guarantee<SpiderResponse> {
        
        let request = SpiderRequest(method: "DELETE", path: path, parameters: parameters, auth: auth)
        
        return Guarantee<SpiderResponse> { (seal) in
            self.perform(request).done { (response) in
                seal(response)
            }
        }
        
    }
    
    /**
     Performs a request with a method & various configuration options.
     - Parameter method: The HTTP request method to use. ("GET", "POST", "PUT", etc..).
     - Parameter path: The endpoint path to append to the global base URL **or** a fully qualified URL (if no global base URL is specified).
     ```
     "/users/12345"
     "http://base.url/v1/users/12345"
     ```
     - Parameter parameters: An optional param object to be passed along with the request.
     - Parameter auth: An optional authorization type to use for this request. This will _override_ Spider's global authorization type. If no authorization type is provided, the request will fallback to Spider's global authorization type.
     - Returns: A guarantee over `SpiderResponse`.
     */
    public func requestWithMethod(_ method: HTTPRequestMethodConvertible,
                                  path: String,
                                  parameters: JSON? = nil,
                                  auth: SpiderAuth? = nil) -> Guarantee<SpiderResponse> {
        
        let request = SpiderRequest(method: method.httpRequestMethod, path: path, parameters: parameters, auth: auth)
        
        return Guarantee<SpiderResponse> { (seal) in
            self.perform(request).done { (response) in
                seal(response)
            }
        }
        
    }
    
    /**
     Performs a multipart request with a method & various configuration options.
     - Parameter method: The HTTP request method to use. ("GET", "POST", "PUT", etc..).
     - Parameter path: The endpoint path to append to the global base URL **or** a fully qualified URL (if no global base URL is specified).
     ```
     "/users/12345"
     "http://base.url/v1/users/12345"
     ```
     - Parameter parameters: An optional param object to be passed along with the request.
     - Parameter files: An array of files to be sent with the request.
     - Parameter auth: An optional authorization type to use for this request. This will _override_ Spider's global authorization type. If no authorization type is provided, the request will fallback to Spider's global authorization type.
     - Returns: A guarantee over `SpiderResponse`.
     */
    public func multipart(method: HTTPRequestMethodConvertible,
                          path: String,
                          parameters: JSON? = nil,
                          files: [MultipartFile],
                          auth: SpiderAuth? = nil) -> Guarantee<SpiderResponse> {
        
        let request = SpiderMultipartRequest(method: method, path: path, parameters: parameters, files: files, auth: auth)
        
        return Guarantee<SpiderResponse> { (seal) in
            self.perform(request).done { (response) in
                seal(response)
            }
        }
        
    }
    
}
