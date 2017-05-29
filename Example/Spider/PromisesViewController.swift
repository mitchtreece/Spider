//
//  PromisesViewController.swift
//  Spider
//
//  Created by Mitch Treece on 5/27/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Spider
import PromiseKit

class PromisesViewController: LoadingViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Promises"
        view.backgroundColor = UIColor.groupTableViewBackground
        
        self.startLoading()
        
        Spider.web.get("https://jsonplaceholder.typicode.com/users").then { (response) -> Promise<String> in
            
            guard let data = response.data as? Data, response.err == nil else {
                
                var message = "There was an error fetching the data"
                if let error = response.err {
                    message = error.localizedDescription
                }
                
                throw message.error!
                
            }
            
            return self.createStatusString(from: data)
            
        }.then { (status) -> Void in
            
            self.updateStatus(status)
            
        }.catch { (error) in
            
            print(error)
            self.updateStatus(error.localizedDescription)
            
        }.always {
            
            self.stopLoading()
            
        }
        
    }
    
    func createStatusString(from data: Data) -> Promise<String> {
        
        return Promise<String>(value: "Fetched \(data)")
        
    }
    
}
