//
//  ViewController.swift
//  Spider
//
//  Created by Mitch Treece on 12/13/2016.
//  Copyright (c) 2016 Mitch Treece. All rights reserved.
//

import UIKit
import Spider

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let url = URL(string: "http://google.com")
        let token = SpiderToken(headerField: "x-access-token", value: "123456789")
        
        // Shared
        
        Spider.web(withBaseUrl: url!, accessToken: token).get(path: "/test", parameters: nil) { (res, obj, err) in
            
        }
        
        // Simple
        
        let spider = Spider(baseUrl: url!, accessToken: token)
        spider.get(path: "/test", parameters: nil) { (res, obj, err) in
            
        }
        
        // Advanced
        
        let request = SpiderRequest(path: "/test", parameters: nil)
        request.header.accept = [.image_jpeg]
        request.auth = .token(SpiderToken(headerField: "x-access-token", value: "123456789"))
        spider.execute(request) { (res, obj, err) in
            print(obj ?? "No data")
        }
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }

}

