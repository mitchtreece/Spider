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
        
        Spider.web.get("https://jsonplaceholder.typicode.com/users") { (response) in
            
            guard let array = (response.data as? Data)?.jsonArray, response.err == nil else {
                
                var message = "There was an error fetching the data"
                if let error = response.err {
                    message = error.localizedDescription
                }
                
                print(message)
                self.updateStatus(message)
                return
                
            }
            
            print("Loaded \(array.count) users")
            completion()
            
        }
        
    }
    
    private func loadUserWithId(_ userId: String, completion: @escaping ()->()) {
        
        Spider.web.get("https://jsonplaceholder.typicode.com/users/\(userId)") { (response) in
            
            guard let userDict = (response.data as? Data)?.json, response.err == nil else {
                
                var message = "There was an error fetching the data"
                if let error = response.err {
                    message = error.localizedDescription
                }
                
                print(message)
                self.updateStatus(message)
                return
                
            }
            
            print("Loaded user: \(userDict.jsonString() ?? "Unknown")")
            completion()
            
        }
        
    }
    
}
