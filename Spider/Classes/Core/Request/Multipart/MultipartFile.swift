//
//  MultipartFile.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/24/18.
//

import Foundation

/// Wrapper over common properties of a multipart file.
public struct MultipartFile {
    
    /// Representation of the various common MIME (media) types.
    public enum MIMEType {
        
        /// An image/png type.
        case image_png
        
        /// An image/jpeg type.
        case image_jpg
        
        /// An image/gif type.
        case image_gif
        
        /// An audio/mpeg3 type.
        case audio_mp3
        
        /// An audio/aac type.
        case audio_aac
        
        /// A video/mp4 type.
        case video_mp4
        
        /// A custom MIME type.
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
    
    /// The multipart file's data.
    public var data: Data
    
    /// The multipart file's key.
    public var key: String
    
    /// The multipart file's name.
    public var name: String
    
    /// The multipart file's MIME type.
    public var mimeType: MIMEType
    
    /// Initializes a multipart file.
    /// - Parameter data: The multipart file data.
    /// - Parameter key: The mmultipart file key.
    /// - Parameter name: The multipart file name.
    /// - Parameter mimeType: The multipart file MIME type.
    public init(data: Data,
                key: String,
                name: String,
                mimeType: MIMEType) {
        
        self.data = data
        self.key = key
        self.name = name
        self.mimeType = mimeType
        
    }
    
}
