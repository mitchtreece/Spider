//
//  SerializedRequestViewController.swift
//  Spider_Example
//
//  Created by Mitch Treece on 8/29/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Spider

class SerializedRequestViewController: LoadingViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Serialized Requests"
        view.backgroundColor = UIColor.groupTableViewBackground
        
        self.startLoading()
        
        let req = SerializedRequest<User>(method: .get, path: "https://jsonplaceholder.typicode.com/users")
        Spider.web.perform(request: req) { (user, error) in
            
            guard let user = user, error == nil else {
                
                var message = "There was an error fetching the data"
                if let error = error {
                    message = error.localizedDescription
                }
                
                print(message)
                self.updateStatus(message)
                return
                
            }
            
            self.updateStatus("Fetched: \(user)")
            self.stopLoading()
            
        }
        
    }
    
}
