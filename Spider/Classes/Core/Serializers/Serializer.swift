//
//  Serializer.swift
//  Pods
//
//  Created by Mitch Treece on 4/19/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

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
