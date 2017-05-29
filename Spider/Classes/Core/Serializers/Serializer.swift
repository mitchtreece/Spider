//
//  Serializer.swift
//  Pods
//
//  Created by Mitch Treece on 4/19/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

/*
 TODO: Better serialization type handling
 
 Right now Swift protocols are unable to have covariant generic types.
 Because of this, the current serialization flow is unable to infer the object type
 before passing it back to the request's response.

 Right now, response data has to be casted back to desired object type:
 
 ```
 let spider = Spider()
 spider.responseSerializer = ImageSerializer()
 spider.get("http://path/to/image.png") { (response) in

    guard let image = response.data as? UIImage, response.err == nil else { return }
    print(image)

 }
 ```
 
 It would be better if `response.data` was already of type `UIImage`.
 We either need to re-think the entire serialization flow, or find a short-term workaround
 until Swift supports true generic protocols.
 
 */

/**
 `Serializer` is a protocol describing the conversion to various data & object representations.
 */
public protocol Serializer {
        
    /**
     Serializes an object into `Data`.
     - Parameter object: The object to serialize
     - Returns: The serialized `Data`
     */
    func data(from object: Any?) -> Data?
    
    /**
     Serializes `Data` into an object.
     - Parameter data: The data to serialize
     - Returns: The serialized object
     */
    func object(from data: Data?) -> Any?
    
}
