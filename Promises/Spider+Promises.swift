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
     Performs a `Request`.
     - Parameter request: The `Request` to perform.
     - Returns: A promise over `Response`.
     */
    public func perform<T: Serializable>(_ request: Request<T>) -> Promise<T> {

        return Promise<T> { (seal) in
            
            self.perform(request) { (value, error) in
                
                guard error == nil else { return seal.reject(error!) }
                guard let value = value else { return seal.reject(SpiderError.badResponseData) }
                seal.fulfill(value)
                
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
     - Returns: A promise over `Response`.
     */
    public func get<T: Serializable>(_ path: String,
                                     parameters: JSON? = nil,
                                     serializedTo type: T.Type,
                                     auth: RequestAuth? = nil) -> Promise<T> {
        
        let request = Request<T>(method: .get, path: path, parameters: parameters, auth: auth)
        
        return Promise<T> { (seal) in
            
            self.perform(request).done { (value) in
                seal.fulfill(value)
            }.catch { (error) in
                seal.reject(error)
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
     - Returns: A promise over `Response`.
     */
    public func post<T: Serializable>(_ path: String,
                                      parameters: JSON? = nil,
                                      serializedTo type: T.Type,
                                      auth: RequestAuth? = nil) -> Promise<T> {
        
        let request = Request<T>(method: .post, path: path, parameters: parameters, auth: auth)
        
        return Promise<T> { (seal) in
            
            self.perform(request).done { (value) in
                seal.fulfill(value)
            }.catch { (error) in
                seal.reject(error)
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
     - Returns: A promise over `Response`.
     */
    public func put<T: Serializable>(_ path: String,
                                     parameters: JSON? = nil,
                                     serializedTo type: T.Type,
                                     auth: RequestAuth? = nil) -> Promise<T> {
        
        let request = Request<T>(method: .put, path: path, parameters: parameters, auth: auth)
        
        return Promise<T> { (seal) in
            
            self.perform(request).done { (value) in
                seal.fulfill(value)
            }.catch { (error) in
                seal.reject(error)
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
     - Returns: A promise over `Response`.
     */
    public func patch<T: Serializable>(_ path: String,
                                       parameters: JSON? = nil,
                                       serializedTo type: T.Type,
                                       auth: RequestAuth? = nil) -> Promise<T> {
        
        let request = Request<T>(method: .patch, path: path, parameters: parameters, auth: auth)
        
        return Promise<T> { (seal) in
            
            self.perform(request).done { (value) in
                seal.fulfill(value)
            }.catch { (error) in
                seal.reject(error)
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
     - Returns: A promise over `Response`.
     */
    public func delete<T: Serializable>(_ path: String,
                                        parameters: JSON? = nil,
                                        serializedTo type: T.Type,
                                        auth: RequestAuth? = nil) -> Promise<T> {
        
        let request = Request<T>(method: .delete, path: path, parameters: parameters, auth: auth)
        
        return Promise<T> { (seal) in
            
            self.perform(request).done { (value) in
                seal.fulfill(value)
            }.catch { (error) in
                seal.reject(error)
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
     - Returns: A promise over `Response`.
     */
    public func requestWithMethod<T: Serializable>(_ method: HTTPMethod,
                                                   path: String,
                                                   parameters: JSON? = nil,
                                                   serializedTo type: T.Type,
                                                   auth: RequestAuth? = nil) -> Promise<T> {
        
        let request = Request<T>(method: method, path: path, parameters: parameters, auth: auth)
        
        return Promise<T> { (seal) in
            
            self.perform(request).done { (value) in
                seal.fulfill(value)
            }.catch { (error) in
                seal.reject(error)
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
     - Returns: A promise over `Response`.
     */
    public func multipart<T: Serializable>(method: HTTPMethod,
                                           path: String,
                                           parameters: JSON? = nil,
                                           files: [MultipartFile],
                                           serializedTo type: T.Type,
                                           auth: RequestAuth? = nil) -> Promise<T> {
        
        let request = MultipartRequest<T>(method: method, path: path, parameters: parameters, files: files, auth: auth)
        
        return Promise<T> { (seal) in
            
            self.perform(request).done { (value) in
                seal.fulfill(value)
            }.catch { (error) in
                seal.reject(error)
            }
            
        }
        
    }
    
}
