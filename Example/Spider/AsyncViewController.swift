//
//  AsyncViewController.swift
//  Spider_Example
//
//  Created by Mitch Treece on 6/15/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Spider

@available(iOS 15, *)
class AsyncViewController: LoadingViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Async"
        self.view.backgroundColor = .groupTableViewBackground
        
        detach {
            await self.loadData()
        }
        
    }
    
    private func loadData() async {
        
        startLoading()
        
        do {
            
            let data = try await Spider.web
                .get("https://jsonplaceholder.typicode.com/users")
                .data()
            
            let status = await createStatusString(from: data)
            updateStatus(status)
            
        }
        catch {
            updateStatus(error.localizedDescription)
        }

        stopLoading()
        
    }
    
    private func createStatusString(from data: Data) async -> String {
        
        await Task.sleep(3 * 1_000_000_000) // 3 seconds
        return "Fetched \(data)"
        
    }
    
}
