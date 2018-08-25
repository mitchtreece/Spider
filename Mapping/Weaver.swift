//
//  Weaver.swift
//  Pods
//
//  Created by Mitch Treece on 5/27/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public class Weaver<T: Codable> {
    
    private var object: JSON?
    private var array: [JSON]?
    
    public init(_ json: JSON) {
        self.object = json
    }
    
    public init(_ array: [JSON]) {
        self.array = array
    }
    
    public func map() -> T? {
        
        guard let data = self.object?.jsonData else { return nil }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        }
        catch (let error) {
            print(error)
            return nil
        }
        
    }
    
    public func arrayMap() -> [T]? {
        
        guard let data = self.array?.jsonData else { return nil }
        
        do {
            return try JSONDecoder().decode([T].self, from: data)
        }
        catch (let error) {
            print(error)
            return nil
        }
                
    }
    
}
