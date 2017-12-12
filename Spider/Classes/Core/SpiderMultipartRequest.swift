//
//  SpiderMultipartRequest.swift
//  Spider-Web
//
//  Created by Mitch Treece on 11/10/17.
//

import Foundation

/**
 `MultipartFile` is a wrapper over common properties of HTTP multipart files.
 */
public struct MultipartFile {
    
    public var data: Data
    public var key: String
    public var name: String
    public var type: SpiderMultipartRequest.MIMEType
    
    public init(data: Data, key: String, name: String, type: SpiderMultipartRequest.MIMEType) {
        
        self.data = data
        self.key = key
        self.name = name
        self.type = type
        
    }
    
}

/**
 `SpiderMultipartRequest` represents a configurable HTTP multipart request.
 */
public class SpiderMultipartRequest: SpiderRequest {
    
    /**
     Representation of the various common MIME (media) types.
     */
    public enum MIMEType {
        
        case image_png
        case image_jpg
        case image_gif
        case audio_mp3
        case audio_aac
        case video_mp4
        case custom(String)
        
    }
    
    internal func string(for mimeType: MIMEType) -> String {
        
        switch mimeType {
        case .image_png: return "image/png"
        case .image_jpg: return "image/jpeg"
        case .image_gif: return "image/gif"
        case .audio_mp3: return "audio/mpeg3"
        case .audio_aac: return "audio/aac"
        case .video_mp4: return "video/mp4"
        case .custom(let _type): return _type
        }
        
    }
    
    /**
     A `UUID` string boundary used to separate multipart file data.
     */
    public let boundary = UUID().uuidString
    
    private(set) var files: [MultipartFile]
    
    /**
     Initializes a new `SpiderMultipartRequest` with a method, path, parameters, authorization type, & files.
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
    public init(method: HTTPRequestMethodConvertible, path: String, parameters: JSON?, files: [MultipartFile], auth: SpiderAuth? = nil) {
        
        self.files = files
        
        super.init(method: method, path: path, parameters: parameters, auth: auth)
        
        self.header.content = .multipart
        
        if let body = multipartBody() {
            self.body = body
        }
        
    }
    
    internal func multipartBody() -> SpiderRequest.Body? {
        
        guard let content = self.header.content, case .multipart = content else { return nil }

        var data = Data()
        let boundaryPrefix = "--\(boundary)\r\n"

        if let parameters = parameters {
            
            for (key, value) in parameters {
                data.append(string: boundaryPrefix)
                data.append(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                data.append(string: "\(value)\r\n")
            }
            
        }
        
        for file in files {
            
            let mime = string(for: file.type)
            
            data.append(string: boundaryPrefix)
            data.append(string: "Content-Disposition: form-data; name=\"\(file.key)\"; filename=\"\(file.name)\"\r\n")
            data.append(string: "Content-Type: \(mime)\r\n\r\n")
            data.append(file.data)
            data.append(string: "\r\n")
            
        }
        
        data.append(string: "--\(boundary)--\r\n")
        return SpiderRequest.Body(data: data)
        
    }
    
}
