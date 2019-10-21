//
//  RequestWorker+UIImage.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import UIKit

public extension RequestWorker /* UIImage */ {
    
    func image(_ completion: @escaping (Response<UIImage>)->()) {
        
        data { response in
            completion(response.compactMap {
                UIImage(data: $0)
            })
        }
        
    }
    
    func imageValue(_ completion: @escaping (UIImage?, Error?)->()) {
        
        image { completion(
            $0.value,
            $0.error
        )}
        
    }
    
}
