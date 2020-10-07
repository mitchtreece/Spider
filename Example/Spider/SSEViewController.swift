//
//  SSEViewController.swift
//  Spider_Example
//
//  Created by Mitch Treece on 10/6/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Spider

class SSEViewController: LoadingViewController {
    
    private var source: EventSource?
    
    deinit {
        print("EventSource - disconnect")
        self.source?.disconnect()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "SSE"
        self.view.backgroundColor = .groupTableViewBackground
        
        updateStatus("Waiting")
        
        guard let source = try? EventSource(url: "http://localhost:8080") else {
            updateStatus("Invalid URL")
            return
        }
        
        source
            .opened { [weak self] in
                print("EventSource - open")
                self?.updateStatus("Opened")
            }
            .closed { [weak self] _ in
                print("EventSource - closed")
                self?.updateStatus("Closed")
            }
            .event("CALL_STATUS_UPDATED", { [weak self] event in // user-connected
                print("<-- EVENT: \"\(event.type ?? "nil")\"")
                self?.updateStatus("\"\(event.type ?? "nil")\"")
            })
            .message { [weak self] _ in
                print("<-- MESSAGE")
                self?.updateStatus("Message")
            }
            .connect()
                
    }

}
