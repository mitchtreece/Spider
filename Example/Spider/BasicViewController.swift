//
//  BasicViewController.swift
//  Spider
//
//  Created by Mitch Treece on 5/27/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Spider

class BasicViewController: LoadingViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Basic Requests"
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        self.startLoading()
        
        Spider.web.timeout = 1
        
        Spider.web
            .get("https://jsonplaceholder.typicode.com/users")
            .dataResponse { response in
            
                self.stopLoading()
                
                switch response.result {
                case .success(let data): self.updateStatus("Fetched: \(data)")
                case .failure(let error): self.updateStatus("Error: \(error.localizedDescription)")
                }
            
            }
        
    }
    
}
