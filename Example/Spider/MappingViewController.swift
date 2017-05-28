//
//  MappingViewController.swift
//  Spider
//
//  Created by Mitch Treece on 5/27/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Spider

class MappingViewController: LoadingViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Object Mapping"
        view.backgroundColor = UIColor.groupTableViewBackground
        
        self.startLoading()
        
        Spider.web.get("https://jsonplaceholder.typicode.com/users") { (response) in
            
            guard let data = response.data as? Data, let array = data.jsonArray, response.err == nil else {
                
                var message = "There was an error fetching the data"
                if let error = response.err {
                    message = error.localizedDescription
                }
                
                print(message)
                self.updateStatus(message)
                return
                
            }
            
            if let users = Weaver<User>(array).arrayMap() {
                self.updateStatus("Fetched: \(users.count) users")
            }
            else {
                self.updateStatus("Error mapping users")
            }
            
            self.stopLoading()
            
        }
        
    }
    
}
