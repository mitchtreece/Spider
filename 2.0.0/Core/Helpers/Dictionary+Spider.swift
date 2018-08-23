//
//  Dictionary+Spider.swift
//  Pods
//
//  Created by Mitch Treece on 5/27/17.
//
//

import Foundation

public extension Dictionary {
    
    func jsonString() -> String? {
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
            guard let jsonString = String(data: jsonData, encoding: .utf8) else { return nil }
            return jsonString
        }
        catch {
            return nil
        }
        
    }
}
