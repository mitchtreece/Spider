//
//  LoadingViewController.swift
//  Spider
//
//  Created by Mitch Treece on 5/27/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

class LoadingViewController: UIViewController {
    
    private var statusLabel: UILabel!
    private var spinner: UIActivityIndicatorView!
    private(set) var isLoading = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        statusLabel = UILabel()
        statusLabel.backgroundColor = UIColor.clear
        statusLabel.textAlignment = .center
        view.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(view).inset(14)
        }
        
        spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        spinner.color = UIColor.black
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        spinner.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.center.equalTo(view)
        }
        
    }
    
    func startLoading() {
        
        isLoading = true
        
        DispatchQueue.main.async {
            self.view.bringSubview(toFront: self.spinner)
            self.spinner.startAnimating()
        }
        
    }
    
    func stopLoading() {
        
        isLoading = false
        
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
        
    }
    
    func updateStatus(_ status: String) {
        
        DispatchQueue.main.async {
            self.statusLabel.text = status
        }
        
    }
    
}
