//
//  AdvancedViewController.swift
//  Spider
//
//  Created by Mitch Treece on 5/27/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Spider

class AdvancedViewController: LoadingViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Advanced Requests"
        view.backgroundColor = UIColor.groupTableViewBackground
        
        self.startLoading()
        
        let request = SpiderRequest(method: "GET", path: "https://jsonplaceholder.typicode.com/users", parameters: ["user_id": "12345"])
        request.header.accept = [.text_plain, .text_json, .image_jpeg, .custom("animal/cat")]
        request.header.set(value: "bar", forField: "foo")
        
        Spider.web.perform(request) { (response) in
            
            guard let data = response.data, response.err == nil else {
                
                var message = "There was an error fetching the data"
                if let error = response.err {
                    message = error.localizedDescription
                }
                
                print(message)
                self.updateStatus(message)
                return
                
            }
            
            self.updateStatus("Fetched: \(data)")
            self.stopLoading()
            
        }
        
    }
    
}
