//
//  Serializer.swift
//  Pods
//
//  Created by Mitch Treece on 4/19/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

/*
 Need a way to make serializers infer their types so we don't have to manually cast
 Maybe make response.data -> reponse.result & generic ?

 let s = Spider()
 s.responseSerializer = ImageSerializer()
 s.get("https://codepo8.github.io/canvas-images-and-pixels/img/horse.png") { (response) in

    guard let image = response.data as? UIImage, response.err == nil else { return }
    print(image)

 }
 */

/**
 `Serializer` is a protocol describing the conversion to various data & object representations.
 */
public protocol Serializer {
    
    init()
    
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
