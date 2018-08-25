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
    
    public var data: Data
    public var key: String
    public var name: String
    public var mimeType: MultipartRequest.MIMEType
    
    public init(data: Data, key: String, name: String, mimeType: MultipartRequest.MIMEType) {
        
        self.data = data
        self.key = key
        self.name = name
        self.mimeType = mimeType
        
    }
    
}
