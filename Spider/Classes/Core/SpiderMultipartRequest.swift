//
//  SpiderMultipartRequest.swift
//  Spider-Web
//
//  Created by Mitch Treece on 11/10/17.
//

import Foundation

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
    
    private(set) var files: [MultipartFile]
    public let boundary = UUID().uuidString
    
    public init(method: Method, path: String, parameters: JSON?, auth: SpiderAuth? = nil, files: [MultipartFile]) {
        
        self.files = files
        
        super.init(method: method, path: path, parameters: parameters, auth: auth)
        
        self.header.content = .multipart
        
        if let body = multipartBody() {
            self.body = body
        }
        
    }
    
    private func multipartBody() -> SpiderRequest.Body? {
        
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
