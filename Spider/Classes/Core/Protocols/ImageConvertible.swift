//
//  ImageConvertible.swift
//  Pods
//
//  Created by Mitch Treece on 5/31/17.
//
//

import UIKit

/**
 `ImageConvertible` is a protocol describing the conversion to various image representations.
 */
public protocol ImageConvertible {
    
    /**
     An image representation.
     */
    var image: UIImage? { get }
    
    /**
     An image data representation.
     */
    var imageData: Data? { get }
    
}

extension UIImage: ImageConvertible {
    
    public var image: UIImage? {
        return self
    }
    
    public var imageData: Data? {
        
        if let data = self.pngData() {
            return data
        }
        
        return nil
        
    }
    
}

extension Data: ImageConvertible {
    
    public var image: UIImage? {
        
        if let image = UIImage(data: self) {
            return image
        }
        
        return nil
        
    }
    
    public var imageData: Data? {
        return self
    }
    
}
