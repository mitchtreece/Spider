//
//  RequestSerializer.swift
//  Pods
//
//  Created by Mitch Treece on 4/17/17.
//
//

import Foundation

public protocol RequestSerializer {
    
    func serialization(of object: Any?) -> Data?
    
}
