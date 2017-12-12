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
        view.backgroundColor = UIColor.groupTableViewBackground
        
        self.startLoading()
        
        Spider.web.get("https://jsonplaceholder.typicode.com/users") { (response) in
                        
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
