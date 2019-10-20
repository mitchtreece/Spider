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
        self.view.backgroundColor = UIColor.groupTableViewBackground
                
        let file = MultipartFile(
            data: UIImagePNGRepresentation(UIImage(named: "logo")!)!,
            key: "image",
            name: "image.png",
            mimeType: .image_png
        )
        
        let request = MultipartRequest(
            method: .post,
            path: "https://www.googleapis.com/upload/drive/v2/files?uploadType=multipart",
            parameters: nil,
            files: [file],
            authorization: nil
        )
        
        self.startLoading()
        
        Spider.web.perform(request).data { response in
            
            self.stopLoading()
            
            switch response.result {
            case .success(let data): self.updateStatus("Response: \(data)")
            case .failure(let error): self.updateStatus(error.localizedDescription)
            }
            
        }
        
    }
    
}
