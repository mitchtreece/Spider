//
//  Serializable.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/29/18.
//

import Foundation
import UIKit

public protocol SerializableType {}

public protocol SerializableProtocol {
    static func serialized(from data: Data) -> SerializableType?
}

public protocol Serializable: SerializableType, SerializableProtocol {}

extension Data: Serializable {
    
    public static func serialized(from data: Data) -> SerializableType? {
        return data
    }
    
}

extension String: Serializable {
    
    public static func serialized(from data: Data) -> SerializableType? {
        return data.string()
    }
    
}

extension Dictionary: SerializableType, SerializableProtocol where Key == String, Value == Any {
    
    public static func serialized(from data: Data) -> SerializableType? {
        return data.json
    }
    
}

extension Array: SerializableType, SerializableProtocol where Element: Serializable, Element: Codable {
    
    public static func serialized(from data: Data) -> SerializableType? {

        guard let object = try? JSONSerialization.jsonObject(with: data), let array = object as? [JSON] else { return nil }
        return array.compactMap { Weaver<Element>($0).map() }
        
    }
    
}

extension UIImage: Serializable {
    
    public static func serialized(from data: Data) -> SerializableType? {
        return data.image
    }
    
}
