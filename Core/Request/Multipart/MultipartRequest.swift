//
//  MultipartRequest.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/24/18.
//

import Foundation

/**
 `MultipartRequest` represents a configurable HTTP multipart request.
 */
public class MultipartRequest<T: Serializable>: Request<T> {
    
    /**
     A `UUID` string boundary used to separate multipart file data.
     */
    public let boundary = UUID().uuidString
    
    private(set) var files: [MultipartFile]
    
    /**
     Initializes a new `MultipartRequest` with a method, path, parameters, authorization type, & files.
     - Parameter method: The HTTP method to use for the request
     - Parameter path: The request's endpoint path to append to it's base URL **or** a fully qualified URL (if no global/request base URL is provided).
     ```
     "/users/12345"
     "http://base.url/v1/users/12345"
     ```
     - Parameter parameters: An optional parameter object to be passed along in the request body.
     - Parameter files: An array of files to be sent with the request.
     - Parameter auth: An optional authorization type to use for this request.
     Setting this will _override_ Spider's global authorization type.
     */
    public init(method: HTTPMethod, path: String, parameters: JSON?, files: [MultipartFile], auth: RequestAuth? = nil) {
        
        self.files = files
        
        super.init(method: method, path: path, parameters: parameters, auth: auth)
        
        self.header.contentType = .multipart
        
        if let _body = self.multipartBody() {
            self.body = _body // Replaces existing body
        }
        
    }
    
    internal func multipartBody() -> Request<T>.Body? {
        
        guard let contentType = self.header.contentType, case .multipart = contentType else { return nil }
        
        var data = Data()
        let boundaryPrefix = "--\(boundary)\r\n"
        
        if let parameters = parameters {
            
            for (key, value) in parameters {
                
                data.append(string: boundaryPrefix)
                data.append(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                data.append(string: "\(value)\r\n")
                
            }
            
        }
        
        files.forEach { (file) in
            
            let mime = MultipartFile.string(for: file.mimeType)
            data.append(string: boundaryPrefix)
            data.append(string: "Content-Disposition: form-data; name=\"\(file.key)\"; filename=\"\(file.name)\"\r\n")
            data.append(string: "Content-Type: \(mime)\r\n\r\n")
            data.append(file.data)
            data.append(string: "\r\n")
            
        }
        
        data.append(string: "--\(boundary)--\r\n")
        return Request.Body(data: data)
        
    }
    
}
