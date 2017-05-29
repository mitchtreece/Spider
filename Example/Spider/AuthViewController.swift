//
//  AuthViewController.swift
//  Spider
//
//  Created by Mitch Treece on 5/27/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Spider

class AuthViewController: LoadingViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Authorization"
        view.backgroundColor = UIColor.groupTableViewBackground
        
        self.startLoading()
        
        let token = TokenAuth(value: "24h21gg43y2gcc283423vhugvu")
        
        Spider.web.get("https://jsonplaceholder.typicode.com/users", auth: token) { (response) in
            
            guard let data = response.data as? Data, response.err == nil else {
                
                var message = "There was an error fetching the data"
                if let error = response.err {
                    message = error.localizedDescription
                }
                
                print(message)
                self.updateStatus(message)
                return
                
            }
            
            self.updateStatus("Fetched: \(data) of secret data")
            self.stopLoading()
            
        }
        
    }
    
}
