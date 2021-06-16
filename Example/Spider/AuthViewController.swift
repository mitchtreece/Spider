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
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        let token = TokenRequestAuth(value: "24h21gg43y2gcc283423vhugvu")
                  
        self.startLoading()
        
        Spider.web
            .get(
                "https://jsonplaceholder.typicode.com/users",
                authorization: token
            )
            .dataResponse { response in
            
                self.stopLoading()
                
                switch response.result {
                case .success(let data): self.updateStatus("Fetched: \(data) of secret data")
                case .failure(let error): self.updateStatus(error.localizedDescription)
                }
            
            }
        
    }
    
}
