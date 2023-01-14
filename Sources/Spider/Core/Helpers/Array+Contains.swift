//
//  Array+Contains.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/22/19.
//

import Foundation

public extension Array where Element: Equatable /* Contains */ {
    
    func contains(_ elements: [Element]) -> Bool {
        
        for e in elements {
            
            if !self.contains(e) {
                return false
            }
            
        }
        
        return true
        
    }
    
}
