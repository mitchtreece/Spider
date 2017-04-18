//
//  JSONParser.swift
//  Pods
//
//  Created by Mitch Treece on 4/16/17.
//
//

import Foundation

internal class JSONParser {
    
    internal static func stringify(jsonObject: Any, prettyPrint: Bool = true) -> String? {
        
        guard JSONSerialization.isValidJSONObject(jsonObject) else { return nil }
        
        let opts = prettyPrint ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: opts)
            if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                return string as String
            }
        }
        catch {
            return nil
        }
        
        return nil
        
    }
    
}
