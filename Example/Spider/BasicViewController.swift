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
        
        Spider.web.get("https://jsonplaceholder.typicode.com/users", as: Data.self) { (data, error) in

            guard let data = data, error == nil else {

                var message = "There was an error fetching the data"
                if let error = error {
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
