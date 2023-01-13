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
        self.view.backgroundColor = .systemGroupedBackground
        
        self.startLoading()
        
        loadUsers { 
            self.loadUserWithId("1", completion: {
                self.updateStatus("Done!")
                self.stopLoading()
            })
        }
        
    }
    
    private func loadUsers(completion: @escaping ()->()) {
        
        Spider.web
            .get("https://jsonplaceholder.typicode.com/users")
            .jsonArrayResponse { response in
                        
                switch response.result {
                case .success(let array): self.updateStatus("Fetched \(array.count) users")
                case .failure(let error): self.updateStatus(error.localizedDescription)
                }
                
                completion()
            
            }
        
    }
    
    private func loadUserWithId(_ userId: String, completion: @escaping ()->()) {
        
        Spider.web
            .get("https://jsonplaceholder.typicode.com/users/\(userId)")
            .jsonResponse { response in
            
                switch response.result {
                case .success(let json): self.updateStatus("Fetched user: \(json)")
                case .failure(let error): self.updateStatus(error.localizedDescription)
                }
                
                completion()
            
            }
        
    }
    
}
