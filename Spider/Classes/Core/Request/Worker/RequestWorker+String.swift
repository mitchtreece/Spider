//
//  RequestWorker+String.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public extension RequestWorker /* String */ {
    
    func string(encoding: String.Encoding = .utf8,
                _ completion: @escaping (Response<String>)->()) {
        
        data { response in
            completion(response.compactMap {
                String(data: $0, encoding: encoding)
            })
        }
        
    }
    
    func stringValue(encoding: String.Encoding = .utf8,
                     _ completion: @escaping (String?, Error?)->()) {
        
        string { completion(
            $0.value,
            $0.error
        )}
        
    }
    
}
