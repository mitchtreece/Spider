//
//  ResponseSerializer.swift
//  Pods
//
//  Created by Mitch Treece on 4/17/17.
//
//

import Foundation

public protocol ResponseSerializer {
    
    func serialization(of data: Data?) -> Any?
    
}
