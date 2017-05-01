//
//  UIImageView+Spider.swift
//  Pods
//
//  Created by Mitch Treece on 4/23/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import UIKit

private var SpiderAssociationKey: UInt8 = 0

public extension UIImageView {
    
    public var web: UISpider<UIImageView> {
        
        get {
            
            if let web = objc_getAssociatedObject(self, &SpiderAssociationKey) as? UISpider<UIImageView> {
                return web
            }
            
            let web = UISpider<UIImageView>()
            self.web = web
            return web
            
        }
        set {
            
            let web = newValue
            web.view = self
            objc_setAssociatedObject(self, &SpiderAssociationKey, web, .OBJC_ASSOCIATION_RETAIN)
            
        }
        
    }
    
}

public extension UISpider where T: UIImageView {
    
    // If completion is set, caller is reponsible for assigning image to UIImageView
    
    public func setImage(_ url: URLConvertible, placeholder: UIImage? = nil, completion: SpiderImageGrabberCompletion? = nil) {
        
        if let placeholder = placeholder {
            (view as? UIImageView)?.image = placeholder
        }
        
        SpiderImageGrabber.getImage(at: url) { [weak self] (image, err) in
            
            guard let _self = self else { return }
            guard let view = _self.view as? UIImageView else { return }
            
            if let _completion = completion {
                _completion(image, err)
            }
            else {
                DispatchQueue.main.async {
                    view.image = image
                }
            }
            
        }
        
    }
    
}
