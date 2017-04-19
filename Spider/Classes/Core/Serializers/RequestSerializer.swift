//
//  RequestSerializer.swift
//  Pods
//
//  Created by Mitch Treece on 4/17/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public protocol RequestSerializer {
    
    func serialization(of object: Any?) -> Data?
    
}
