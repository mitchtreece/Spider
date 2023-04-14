//
//  Response+Debug.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/22/19.
//

import Foundation

public extension Response /* Debug */ {
    
    /// Representation of the various response debug types.
    enum DebugType {

        /// A string debug type.
        case string
        
        /// A JSON debug type.
        case json
        
    }
    
    /// Debug prints the response to the console.
    /// - Parameter type: The debug type.
    func debug(_ type: DebugType) {
        
        guard let data = self.body?.data else {
            print("bad data")
            return
        }
        
        switch type {
        case .string: string(data: data)
        case .json: json(data: data)
        }
        
    }
    
    // MARK: Private
    
    private func string(data: Data) {
        
        guard let string = String(data: data, encoding: .utf8) else {
            print("Invalid string data")
            return
        }
        
        print(string)
        
    }
    
    private func json(data: Data) {
        
        let _object: Any? = data.asJson() ?? data.asJsonArray()
                
        guard let object = _object,
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            print("Invalid JSON data")
            return
        }
        
        debugPrint(string)
        
    }
    
}
