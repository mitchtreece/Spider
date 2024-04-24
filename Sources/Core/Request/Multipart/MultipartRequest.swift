//
//  MultipartRequest.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/24/18.
//

import Foundation
import typealias Espresso.JSON

/// A configurable multipart HTTP request.
public class MultipartRequest: Request {
    
    /// Representation of the various multipart HTTP methods.
    public enum Method {
        
        /// A POST HTTP method.
        case post
        
        /// A PUT HTTP method.
        case put
        
        internal var httpMethod: HTTPMethod {
            
            switch self {
            case .post: return .post
            case .put: return .put
            }
            
        }
        
    }
    
    /// A `UUID` string boundary used to separate multipart file data.
    public let boundary = UUID().uuidString
    
    private(set) var files: [MultipartFile]

    /// Initializes a multipart request.
    /// - Parameter method: The multipart HTTP request method.
    /// - Parameter path: The request's resource path to append to any shared base URL **or** a fully qualified URL path.
    ///     ```
    ///     "/users/12345"
    ///     "http://base.url/v1/users/12345"
    ///     ```
    /// - Parameter parameters: An optional parameter object to be passed along in the request body.
    /// - Parameter files: An array of files to be sent with the request.
    /// - Parameter authorization: Optional authorization to use for this request.
    /// Setting this will _override_ any shared authorization.
    public init(method: Method,
                path: String,
                parameters: JSON?,
                files: [MultipartFile],
                authorization: RequestAuth? = nil) {
        
        self.files = files
        
        super.init(
            method: method.httpMethod,
            path: path,
            parameters: parameters,
            authorization: authorization
        )
        
        createRequestBody()
        
    }
    
    override func createRequestBody() {
        
        guard let multipartBody = self.multipartBody() else {
            self.body = nil
            return
        }
        
        self.body = multipartBody
        
    }
    
    private func multipartBody() -> Body? {
        
        var data = Data()
        let boundaryPrefix = "--\(self.boundary)\r\n"
        
        if let parameters = self.parameters {
            
            for (key, value) in parameters {
                
                data.append(string: boundaryPrefix)
                data.append(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                data.append(string: "\(value)\r\n")
                
            }
            
        }
        
        self.files.forEach { file in
            
            let mime = file.mimeType.value
            data.append(string: boundaryPrefix)
            data.append(string: "Content-Disposition: form-data; name=\"\(file.key)\"; filename=\"\(file.name)\"\r\n")
            data.append(string: "Content-Type: \(mime)\r\n\r\n")
            data.append(file.data)
            data.append(string: "\r\n")
            
        }
        
        data.append(string: "--\(self.boundary)--\r\n")
        return Body(data: data)
        
    }
    
}
