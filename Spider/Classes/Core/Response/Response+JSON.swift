//
//  Response+JSON.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/22/19.
//

import Foundation

public extension Response /* JSON */ {
    
    private var jsonObject: Any? {
        
        guard let data = self.data else { return nil }
        return (try? data.json()) ?? (try? data.jsonArray())
        
    }
    
    func printJSON() {
        
        guard let json = self.jsonObject,
            let data = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]) else {
            print("Invalid JSON response data")
            return
        }
        
        guard let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            print("Invalid JSON string")
            return
        }
        
        debugPrint(string)
        
    }
    
}
