//
//  ImageSerializer.swift
//  Pods
//
//  Created by Mitch Treece on 5/26/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import UIKit

/**
 `ImageSerializer` serializes data/images to-and-from UIImage.
 */
public class ImageSerializer: Serializer {
    
    public required init() {
        //
    }
    
    public func data(from object: Any?) -> Data? {
        
        guard let image = object as? UIImage else { return nil }
        
        if let data = UIImagePNGRepresentation(image) {
            return data
        }
        
        return nil
        
    }
    
    public func object(from data: Data?) -> Any? {
        
        guard let data = data else { return nil }
        
        if let image = UIImage(data: data) {
            return image
        }
        
        return nil
        
    }
    
}
