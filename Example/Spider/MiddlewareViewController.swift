//
//  MiddlewareViewController.swift
//  Spider_Example
//
//  Created by Mitch Treece on 12/9/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Spider

private class ExampleMiddleware: Middleware {
    
    override func next(_ response: Response<Data>) throws -> Response<Data> {
        
        let stringResponse = response.compactMap { $0.string() }
                
        switch stringResponse.result {
        case .success(let string):
            
            guard !string.isEmpty else {
                
                throw NSError(
                    domain: "com.mitchtreece.Spider-Example",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "ExampleMiddleware failed"]
                )
                
            }
            
        case .failure(let error): throw error
        }
        
        
        return response
        
    }
    
}

class MiddlewareViewController: LoadingViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Middleware"
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        startLoading()
        
        let spider = Spider()
        spider.middlewares = [ExampleMiddleware()]
        
        spider
            .get("https://jsonplaceholder.typicode.com/users")
            .data { response in
                
                self.stopLoading()
                
                switch response.result {
                case .success(let data): self.updateStatus("Fetched: \(data)")
                case .failure(let error): self.updateStatus("Error: \(error.localizedDescription)")
                }
                
            }
        
    }
    
}
