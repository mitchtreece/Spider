//
//  PassthroughViewController.swift
//  Spider_Example
//
//  Created by Mitch Treece on 1/16/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import Spider

class PassthroughViewController: LoadingViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Passthrough"
        self.view.backgroundColor = .systemGroupedBackground
        
        startLoading()
                
        let spider = Spider()
        
        spider
            .get("https://jsonplaceholder.typicode.com/users/1")
            .voidPassthrough { print("-> This is a void passthrough!") }
            .voidPassthrough { print("-> This is another one!") }
            .jsonPassthrough { json in
                
                if let json {
                    
                    print("-> This is a json passthrough with a value:")
                    json.debugPrint()
                    
                }
                else {
                    print("-> This is a json passthrough")
                }
                                
            }
            .dataResponse { response in
                
                print("-> We got a response!")
                
                self.stopLoading()
                                
                switch response.result {
                case .success(let data): self.updateStatus("Fetched: \(data)")
                case .failure(let error): self.updateStatus("Error: \(error.localizedDescription)")
                }
                
            }
        
    }
    
}
