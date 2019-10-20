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
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        self.startLoading()
        
        let request = Request(
            method: .get,
            path: "https://jsonplaceholder.typicode.com/users",
            parameters: ["user_id": "12345"],
            authorization: nil
        )
        
        request.header.acceptTypes = [
            .text_plain,
            .text_json,
            .image_jpeg,
            .custom("animal/cat")
        ]
        
        request.header.set(
            value: "bar",
            forField: "foo"
        )
        
        Spider.web.perform(request).dataResponse { response in
            
            self.stopLoading()
            
            switch response.result {
            case .success(let data): self.updateStatus("Fetched: \(data)")
            case .failure(let error): self.updateStatus(error.localizedDescription)
            }
            
        }
                
    }
    
}
