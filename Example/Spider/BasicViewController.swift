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
        
        let req = SerializedRequest<Data>(method: .get, path: "https://jsonplaceholder.typicode.com/users")
        Spider.web.perform(request: req) { (data, error) in

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
        
//        Spider.web.get("https://jsonplaceholder.typicode.com/users") { (response) in
//
//            guard let data = response.data, response.error == nil else {
//
//                var message = "There was an error fetching the data"
//                if let error = response.error {
//                    message = error.localizedDescription
//                }
//
//                print(message)
//                self.updateStatus(message)
//                return
//
//            }
//
//            self.updateStatus("Fetched: \(data)")
//            self.stopLoading()
//
//        }
        
    }
    
}
