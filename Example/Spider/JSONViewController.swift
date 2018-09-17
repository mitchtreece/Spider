//
//  JSONViewController.swift
//  Spider
//
//  Created by Mitch Treece on 5/28/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Spider

class JSONViewController: LoadingViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "JSON"
        view.backgroundColor = UIColor.groupTableViewBackground
        
        self.startLoading()
        
        loadUsers { 
            self.loadUserWithId("1", completion: {
                self.updateStatus("Done!")
                self.stopLoading()
            })
        }
        
    }
    
    private func loadUsers(completion: @escaping ()->()) {
        
        Spider.web.get("https://jsonplaceholder.typicode.com/users", as: [JSON].self) { (jsons, error) in
            
            guard let jsons = jsons, error == nil else {
                
                var message = "There was an error fetching the data"
                if let error = error {
                    message = error.localizedDescription
                }
                
                print(message)
                self.updateStatus(message)
                return
                
            }
            
            print("Loaded \(jsons.count) users")
            completion()
            
        }
        
    }
    
    private func loadUserWithId(_ userId: String, completion: @escaping ()->()) {
        
        Spider.web.get("https://jsonplaceholder.typicode.com/users/\(userId)", as: JSON.self) { (json, error) in
            
            guard let json = json, error == nil else {
                
                var message = "There was an error fetching the data"
                if let error = error {
                    message = error.localizedDescription
                }
                
                print(message)
                self.updateStatus(message)
                return
                
            }
            
            print("Loaded user: \(json)")
            completion()
            
        }
        
    }
    
}
