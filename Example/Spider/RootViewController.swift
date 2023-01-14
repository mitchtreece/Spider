//
//  RootViewController.swift
//  Spider
//
//  Created by Mitch Treece on 5/27/17.
//  Copyright © 2017 Mitch Treece. All rights reserved.
//

import UIKit
import Spider

class RootViewController: UITableViewController {
    
    enum Row: Int {
        
        case basic
        case advanced
        case multipart
        case auth
        case json
        case mapping
        case middleware
        case sse
        case uikit
        case `async`
        case promises
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        Spider
            .web
            .isDebugLoggingEnabled = true
                
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let row = Row(rawValue: indexPath.row) {
            pushViewController(for: row)
        }
        
    }
    
    func pushViewController(for row: Row) {
        
        switch row {
        case .basic:
            
            self.navigationController?.pushViewController(
                BasicViewController(),
                animated: true
            )
            
        case .advanced:
            
            self.navigationController?.pushViewController(
                AdvancedViewController(),
                animated: true
            )
            
        case .multipart:
            
            self.navigationController?.pushViewController(
                MultipartViewController(),
                animated: true
            )
            
        case .auth:
            
            self.navigationController?.pushViewController(
                AuthViewController(),
                animated: true
            )
            
        case .json:
            
            self.navigationController?.pushViewController(
                JSONViewController(),
                animated: true
            )
            
        case .mapping:
            
            self.navigationController?.pushViewController(
                MappingViewController(),
                animated: true
            )

        case .middleware:
            
            self.navigationController?.pushViewController(
                MiddlewareViewController(),
                animated: true
            )
            
        case .sse:
            
            self.navigationController?.pushViewController(
                SSEViewController(),
                animated: true
            )
            
        case .uikit:
            
            self.navigationController?.pushViewController(
                UIKitViewController(),
                animated: true
            )
            
        case .async:
            
            if #available(iOS 15, *) {
                
                self.navigationController?.pushViewController(
                    AsyncViewController(),
                    animated: true
                )
                
            }
            else {
                
                let alert = UIAlertController(
                    title: "Time to update 😆",
                    message: "async/await is only available on iOS 15 or higher.",
                    preferredStyle: .alert
                )
                
                present(
                    alert,
                    animated: true,
                    completion: nil
                )
                
            }
            
        case .promises:
            
            self.navigationController?.pushViewController(
                PromisesViewController(),
                animated: true
            )
            
        }
        
    }
    
}
