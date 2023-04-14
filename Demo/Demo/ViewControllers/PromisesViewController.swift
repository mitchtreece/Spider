//
//  PromisesViewController.swift
//  Spider
//
//  Created by Mitch Treece on 5/27/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Spider
import SpiderPromise
import PromiseKit

class PromisesViewController: LoadingViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Promises"
        self.view.backgroundColor = .systemGroupedBackground
        
        self.startLoading()
        
        Spider.web
            .get("https://jsonplaceholder.typicode.com/users")
            .data()
            .then { data -> Guarantee<String> in
                return self.createStatusString(from: data)
            }.done { status in
                self.updateStatus(status)
            }.catch { error in
                self.updateStatus(error.localizedDescription)
            }.finally {
                self.stopLoading()
            }
        
    }
    
    func createStatusString(from data: Data) -> Guarantee<String> {
        return Guarantee<String>.value("Fetched \(data)")
    }
    
}
