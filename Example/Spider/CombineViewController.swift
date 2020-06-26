//
//  CombineViewController.swift
//  Spider_Example
//
//  Created by Mitch Treece on 6/24/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Spider
import Combine

class CombineViewController: LoadingViewController {
    
    private var storage = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Combine"
        self.view.backgroundColor = .systemGroupedBackground
                
        self.startLoading()
        
        Spider.web
            .get("https://jsonplaceholder.typicode.com/users")
            .dataPublisher()
            .resultSink { result in

                self.stopLoading()

                switch result {
                case .success(let data): self.updateStatus("Fetched \(data)")
                case .failure(let error): self.updateStatus(error.localizedDescription)
                }

            }
            .store(in: &self.storage)
        
//        Spider.web
//            .get("https://jsonplaceholder.typicode.com/users")
//            .dataPublisher()
//            .valueSink { data in
//                print("")
//            }
//            .store(in: &self.storage)
        
    }
    
    func createStatusString(from data: Data) -> AnyPublisher<String, Never> {
        
        return Future<String, Never> { seal in
            seal(.success("Fetched \(data)"))
        }
        .eraseToAnyPublisher()
                
    }
    
}
