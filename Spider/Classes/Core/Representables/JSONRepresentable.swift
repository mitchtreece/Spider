//
//  JSONRepresentable.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

/// JSON typealias
public typealias JSON = [String: Any]

/// Representation of the various JSON errors.
public enum JSONError: Error {
    
    // An invalid JSON object error
    case invalidJSONObject
    
}

/// Protocol describing the conversion to various `JSON` representations.
public protocol JSONRepresentable {
    
    /// A `JSON` representation.
    func json() throws -> JSON
    
    /// A `JSON` array representation.
    func jsonArray() throws -> [JSON]
    
    /// A `JSON` data representation.
    func jsonData() throws -> Data
    
}

extension Dictionary: JSONRepresentable {
    
    public func json() throws -> JSON {
        
        if let json = self as? JSON {
            return json
        }
        
        throw JSONError.invalidJSONObject
        
    }
    
    public func jsonArray() throws -> [JSON] {
        
        do {
            let json = try self.json()
            return [json]
        }
        catch {
            throw error
        }
        
    }
    
    public func jsonData() throws -> Data {
        
        do {
            return try JSONSerialization.data(withJSONObject: self)
        }
        catch {
            throw JSONError.invalidJSONObject
        }
        
    }
    
}

extension Array: JSONRepresentable {
    
    public func json() throws -> JSON {
        throw JSONError.invalidJSONObject
    }
    
    public func jsonArray() throws -> [JSON] {
        
        if let array = self as? [JSON] {
            return array
        }
        
        throw JSONError.invalidJSONObject
        
    }
    
    public func jsonData() throws -> Data {
        
        do {
            return try JSONSerialization.data(withJSONObject: self)
        }
        catch {
            throw JSONError.invalidJSONObject
        }
        
    }
    
}

extension Data: JSONRepresentable {
    
    public func json() throws -> JSON {
        
        do {
            
            if let json = try JSONSerialization.jsonObject(with: self) as? JSON {
                return json
            }
            
            throw JSONError.invalidJSONObject
            
        }
        catch {
            throw JSONError.invalidJSONObject
        }
        
    }
    
    public func jsonArray() throws -> [JSON] {
        
        do {
            
            if let array = try JSONSerialization.jsonObject(with: self) as? [JSON] {
                return array
            }
            
            throw JSONError.invalidJSONObject
            
        }
        catch {
            throw JSONError.invalidJSONObject
        }
        
    }
    
    public func jsonData() throws -> Data {
        
        guard JSONSerialization.isValidJSONObject(self) else {
            throw JSONError.invalidJSONObject
        }
        
        return self
        
    }
    
}
