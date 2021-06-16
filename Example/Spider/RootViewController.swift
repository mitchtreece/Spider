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
        case auth
        case json
        case mapping
        case multipart
        case middleware
        case sse
        case uikit
        case promises
        case `async`
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        Spider.web.isDebugEnabled = true
                
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
        case .basic: navigationController?.pushViewController(BasicViewController(), animated: true)
        case .advanced: navigationController?.pushViewController(AdvancedViewController(), animated: true)
        case .auth: navigationController?.pushViewController(AuthViewController(), animated: true)
        case .json: navigationController?.pushViewController(JSONViewController(), animated: true)
        case .mapping: navigationController?.pushViewController(MappingViewController(), animated: true)
        case .multipart: navigationController?.pushViewController(MultipartViewController(), animated: true)
        case .middleware: navigationController?.pushViewController(MiddlewareViewController(), animated: true)
        case .sse: navigationController?.pushViewController(SSEViewController(), animated: true)
        case .uikit: navigationController?.pushViewController(UIKitViewController(), animated: true)
        case .promises: navigationController?.pushViewController(PromisesViewController(), animated: true)
        case .async:
            
            if #available(iOS 15, *) {
                navigationController?.pushViewController(AsyncViewController(), animated: true)
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
            
        }
        
    }
    
}
