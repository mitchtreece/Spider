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
    private var stream: RemoteEventStream?
    
    deinit {
                
        self.stream?
            .disconnect()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "SSE"
        self.view.backgroundColor = .systemGroupedBackground
        
        self.button = UIButton()
        self.button.backgroundColor = .systemBlue
        self.button.setTitle("Connect", for: .normal)
        self.button.layer.cornerRadius = 8
        self.button.layer.cornerCurve = .continuous
        self.view.addSubview(self.button)
        self.button.snp.makeConstraints { make in
            make.bottom.equalTo(-30)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(50)
        }
        
        self.button.addTarget(
            self,
            action: #selector(didTapButton(_:)),
            for: .touchUpInside
        )

    
        updateStatus("Disconnected")
        
        do {
            self.stream = try RemoteEventStream(url: "http://localhost:8080")
        }
        catch {
            updateStatus("Error: \(error.localizedDescription)")
        }
        
        self.stream?
            .isDebugLoggingEnabled = true
        
        self.stream?.receive { [weak self] streamEvent in
            
            switch streamEvent {
            case .connected:
                
                self?.updateStatus("Connected")
                self?.button.setTitle("Disconnect", for: .normal)
                
            case .disconnected:
                
                self?.updateStatus("Disconnected")
                self?.button.setTitle("Connect", for: .normal)
                
            case .event(let event):
                                
                self?.updateStatus("Event: \"\(event.type.name)\"")
                
            }
            
        }
        
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        
        guard let stream = self.stream else {
            return
        }
        
        switch stream.state {
        case .connected:
            
            stream
                .disconnect()
            
        case .disconnected:
            
            stream
                .connect()
            
        default: return
        }
        
    }

}
