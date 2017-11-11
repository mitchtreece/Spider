//
//  MultipartViewController.swift
//  Spider_Example
//
//  Created by Mitch Treece on 11/10/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Spider

class MultipartViewController: LoadingViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Multipart Requests"
        view.backgroundColor = UIColor.groupTableViewBackground
        
        self.startLoading()
        
        let request = SpiderMultipartRequest(method: .put,
                                             path: "https://google/upload",
                                             parameters: nil,
                                             auth: nil,
                                             fileData: Data(),
                                             fileKey: "file_key",
                                             filename: "file.png",
                                             mimeType: .image_png)
        
        Spider.web.perform(request) { (response) in
            
//            guard let data = response.data, response.err == nil else {
//
//                var message = "There was an error fetching the data"
//                if let error = response.err {
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
            
        }
        
    }
    
}
