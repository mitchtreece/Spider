//
//  Dictionary+JSON.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/22/19.
//

import Foundation

public extension Dictionary {
    
    var formattedJSONString: String? {
        
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
