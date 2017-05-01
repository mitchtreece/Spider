//
//  SpiderImageGrabber.swift
//  Pods
//
//  Created by Mitch Treece on 4/23/17.
//
//

import Foundation

public typealias SpiderImageGrabberCompletion = (UIImage?, ErrorConvertible?)->()

public class SpiderImageGrabber {
    
    public static func getImage(at url: URLConvertible, completion: @escaping SpiderImageGrabberCompletion) {
        
        guard let url = url.urlString else {
            completion(nil, SpiderError.invalidUrl)
            return
        }
        
        Spider.web.get(url) { (response) in
            
            guard let data = response.data as? Data, let image = UIImage(data: data) else {
                completion(nil, SpiderError.invalidImageData)
                return
            }

            completion(image, nil)
            
        }
        
    }
    
}
