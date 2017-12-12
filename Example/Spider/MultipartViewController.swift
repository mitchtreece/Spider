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
        
        let data = UIImagePNGRepresentation(#imageLiteral(resourceName: "logo"))!
        let file = MultipartFile(data: data, key: "image", name: "image.png", type: .image_png)
        let request = SpiderMultipartRequest(method: "POST",
                                             path: "https://www.googleapis.com/upload/drive/v2/files?uploadType=multipart",
                                             parameters: nil,
                                             files: [file],
                                             auth: nil)
        
        Spider.web.perform(request) { (response) in
            
            guard let data = response.data, response.err == nil else {

                var message = "There was an error fetching the data"
                if let error = response.err {
                    message = error.localizedDescription
                }

                print(message)
                self.updateStatus(message)
                return

            }

            self.updateStatus("Response: \(data)")
            self.stopLoading()
            
        }
        
    }
    
}
