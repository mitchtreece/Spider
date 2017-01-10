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
        
        let url = URL(string: "http://lorempixel.com")
        let spider = Spider(baseUrl: url!)
        
        // Simple
        
        spider.get(path: "/400/400", parameters: nil) { (res, obj, err) in
            print(obj ?? "No data")
        }
        
        // Advanced
        
        let request = SpiderRequest(path: "/400/400", parameters: nil)
        request.header.accept = [.image_jpeg]
        request.header.set(value: "123456789", forHeaderField: "x-access-token")
        
        spider.execute(request) { (res, obj, err) in
            print(obj ?? "No data")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

