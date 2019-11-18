//
//  ImageRepresentable.swift
//  Spider-Web
//
//  Created by Mitch Treece on 5/31/17.
//
//

import Foundation

/// `ImageRepresentable` is a protocol describing the conversion to various image representations.
public protocol ImageRepresentable {
    
    /// An image representation.
    var image: Image? { get }
    
}

extension ImageRepresentable {
    
    /// An image data representation.
    var imageData: Data? {
        
        guard let image = self.image else { return nil }
        
        #if canImport(UIKit)
        return image.pngData()
        #elseif os(macOS)
        
        guard let tiffData = image.tiffRepresentation else { return nil }
        guard let rep = NSBitmapImageRep(data: tiffData) else { return nil }
        return rep.representation(using: .png, properties: [:])
        
        #else
        return nil
        #endif
                
    }
    
}

#if canImport(UIKit)

extension UIImage: ImageRepresentable {
    
    public var image: Image? {
        return self
    }
    
}

#elseif os(macOS)

extension NSImage: ImageRepresentable {
    
    public var image: Image? {
        return self
    }
    
}

#endif

extension Data: ImageRepresentable {
    
    public var image: Image? {
        
        #if canImport(UIKit)
        return UIImage(data: self)
        #elseif os(macOS)
        return NSImage(data: self)
        #endif
                
    }
    
}
