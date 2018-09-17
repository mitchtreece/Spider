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
        
        let request = Request<Data>(method: .get, path: "https://jsonplaceholder.typicode.com/users", parameters: ["user_id": "12345"], auth: nil)
        request.header.acceptTypes = [.text_plain, .text_json, .image_jpeg, .other("animal/cat")]
        request.header.set(value: "bar", forField: "foo")

        Spider.web.perform(request) { (data, error) in
            
            guard let data = data, error == nil else {
                
                var message = "There was an error fetching the data"
                if let error = error {
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
