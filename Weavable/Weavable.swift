//
//  Weaver.swift
//  Pods
//
//  Created by Mitch Treece on 5/27/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public class Weaver<T: Codable> {
    
    private var json: JSON?
    private var jsonArray: [JSON]?
    
    public init(_ json: JSON) {
        self.json = json
    }
    
    public init(_ array: [JSON]) {
        self.jsonArray = array
    }
    
    public func map() -> T? {
        
        guard let object = json else { return nil }
        guard JSONSerialization.isValidJSONObject(object) else { return nil }
        guard let data = try? JSONSerialization.data(withJSONObject: object) else { return nil }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        }
        catch (let error) {
            print(error)
            return nil
        }
        
    }
    
    public func mapArray() -> [T]? {
        
        guard let object = jsonArray else { return nil }
        guard JSONSerialization.isValidJSONObject(object) else { return nil }
        guard let data = try? JSONSerialization.data(withJSONObject: object) else { return nil }
        
        do {
            return try JSONDecoder().decode([T].self, from: data)
        }
        catch (let error) {
            print(error)
            return nil
        }
        
    }
    
}
