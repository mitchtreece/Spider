//
//  Serializer.swift
//  Pods
//
//  Created by Mitch Treece on 4/19/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public protocol Serializer {
    
    func data(from object: Any?) -> Data?
    func object(from data: Data?) -> Any?
    
}
