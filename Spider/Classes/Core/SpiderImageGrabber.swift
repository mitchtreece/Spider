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
        
        Spider.web.get(url.urlString) { (response) in
            
            guard let data = response.data as? Data, let image = UIImage(data: data) else {
                completion(nil, "Invalid image data")
                return
            }

            completion(image, nil)
            
        }
        
    }
    
}
