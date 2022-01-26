//
//  AsyncViewController.swift
//  Spider_Example
//
//  Created by Mitch Treece on 6/15/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Spider

@available(iOS 13, *)
class AsyncViewController: LoadingViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Async"
        self.view.backgroundColor = .groupTableViewBackground
        
        Task {
            await self.loadData()
        }
                
    }
    
    private func loadData() async {
        
        startLoading()
        
        let data = await Spider.web
            .get("https://jsonplaceholder.typicode.com/users")
            .data()
        
        updateStatus(await createStatusString(from: data))

        stopLoading()
        
    }

    private func createStatusString(from data: Data?) async -> String {
        
        guard let data = data else {
            return "invalid data"
        }
                
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000) // 2 seconds
        return "Fetched \(data)"
        
    }
    
}
