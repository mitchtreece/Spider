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
    
    private var button: UIButton!
    private var source: EventSource?
    
    deinit {
        print("EventSource - disconnect")
        self.source?.disconnect()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "SSE"
        self.view.backgroundColor = .groupTableViewBackground
        
        self.button = UIButton()
        self.button.backgroundColor = .lightGray
        self.button.setTitle("Connect", for: .normal)
        self.button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        self.view.addSubview(self.button)
        self.button.snp.makeConstraints { make in
            make.bottom.equalTo(-30)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(50)
        }
    
        updateStatus("Closed")
        
        self.source = try? EventSource(url: "http://localhost:8080")
        
        if self.source == nil {
            updateStatus("Invalid URL")
        }
        
        self.source?
            .opened { [weak self] in
                
                print("EventSource: opened")
                
                self?.updateStatus("Opened")
                self?.button.setTitle("Disconnect", for: .normal)
                
            }
            .closed { [weak self] _ in
                
                print("EventSource: closed")
                
                self?.updateStatus("Closed")
                self?.button.setTitle("Connect", for: .normal)
                
            }
            .event("CALL_STATUS_UPDATED", { [weak self] event in // user-connected
                
                print("Event: \"\(event.type ?? "nil")\"")
                self?.updateStatus("\"\(event.type ?? "nil")\"")
                
            })
            .message { [weak self] _ in
                
                print("Message")
                self?.updateStatus("Message")
                
            }
                
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        
        guard let source = self.source else { return }
        
        switch source.state {
        case .closed: source.connect()
        case .open: source.disconnect()
        default: return
        }
        
    }

}
