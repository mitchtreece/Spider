//
//  SpiderMultipartRequest.swift
//  Spider-Web
//
//  Created by Mitch Treece on 11/10/17.
//

import Foundation

public class SpiderMultipartRequest: SpiderRequest {
    
    /**
     Representation of the various common MIME (media) types.
     */
    public enum MIMEType {
        case image_png
        case image_jpg
        case image_gif
        case audio_mp3
        case video_mp4
        case custom(String)
    }
    
    internal func mimeStringify() -> String? {
        
        guard let type = mimeType else { return nil }
        
        switch type {
        case .image_png: return "image/png"
        case .image_jpg: return "image/jpeg"
        case .image_gif: return "image/gif"
        case .audio_mp3: return "audio/mpeg3"
        case .video_mp4: return "video/mp4"
        case .custom(let _type): return _type
        }
        
    }
    
    var fileData: Data?
    var fileKey: String?
    var filename: String?
    var mimeType: MIMEType?

    public let boundary = UUID().uuidString
    
    public init(method: Method,
                path: String,
                parameters: JSON? = nil,
                auth: SpiderAuth? = nil,
                fileData: Data,
                fileKey: String,
                filename: String,
                mimeType: MIMEType) {
        
        super.init(method: method, path: path, parameters: parameters, auth: auth)
        self.fileData = fileData
        self.fileKey = fileKey
        self.filename = filename
        self.mimeType = mimeType
        
        self.header.contentType = .multipart
        self.body = multipartBody() ?? SpiderRequest.Body()
        
    }
    
    private func multipartBody() -> SpiderRequest.Body? {
        
        guard let content = self.header.contentType, case .multipart = content else { return nil }
        guard let fileData = fileData else { return nil }
        guard let fileKey = fileKey else { return nil }
        guard let filename = filename else { return nil }
        guard let mime = mimeType else { return nil }

        var data = Data()
        let prefix = "--\(boundary)\r\n"

        if let parameters = parameters {
            for (key, value) in parameters {
                data.append(string: prefix)
                data.append(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                data.append(string: "\(value)\r\n")
            }
        }

        data.append(string: prefix)
        data.append(string: "Content-Disposition: form-data; name=\"\(fileKey)\"; filename=\"\(filename)\"\r\n")
        data.append(string: "Content-Type: \(mime)\r\n\r\n")
        data.append(fileData)
        data.append(string: "\r\n")
        data.append(string: "--\(boundary)--\r\n")

        return SpiderRequest.Body(data: data)
        
    }
    
}
