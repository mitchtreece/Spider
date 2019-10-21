//
//  MultipartFile.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/24/18.
//

import Foundation

/**
 `MultipartFile` is a wrapper over common properties of HTTP multipart files.
 */
public struct MultipartFile {
    
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
    
    internal static func string(for mimeType: MIMEType) -> String {
        
        switch mimeType {
        case .image_png: return "image/png"
        case .image_jpg: return "image/jpeg"
        case .image_gif: return "image/gif"
        case .audio_mp3: return "audio/mpeg3"
        case .audio_aac: return "audio/aac"
        case .video_mp4: return "video/mp4"
        case .custom(let type): return type
        }
        
    }
    
    public var data: Data
    public var key: String
    public var name: String
    public var mimeType: MIMEType
    
    public init(data: Data, key: String, name: String, mimeType: MIMEType) {
        
        self.data = data
        self.key = key
        self.name = name
        self.mimeType = mimeType
        
    }
    
}
