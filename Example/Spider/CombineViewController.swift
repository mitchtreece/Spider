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
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Combine"
        self.view.backgroundColor = .systemGroupedBackground
                
        self.startLoading()
        
//        Spider.web
//            .get("https://jsonplaceholder.typicode.com/users")
//            .dataValue()
//            .then { data -> Guarantee<String> in
//                return self.createStatusString(from: data)
//            }.done { status in
//                self.updateStatus(status)
//            }.catch { error in
//                self.updateStatus(error.localizedDescription)
//            }.finally {
//                self.stopLoading()
//            }
                
        Spider.web
            .get("https://jsonplaceholder.typicode.com/users")
            .stringFuture()
            .sink(receiveCompletion: { comp in
                print("")
            }, receiveValue: { val in
                print("")
            })
            .store(in: &self.cancellables)
            
//            .resultSink { result in
//
//                switch result {
//                case .success(let string): self.updateStatus(string)
//                case .failure(let error): self.updateStatus(error.localizedDescription)
//                }
//
//                self.stopLoading()
//
//            }
//            .store(in: &self.cancellables)
        
    }
    
    func createStatusString(from data: Data) -> Future<String, Never> {
        
        return Future<String, Never> { seal in
            seal(.success("Fetched \(data)"))
        }
                
    }
    
}
