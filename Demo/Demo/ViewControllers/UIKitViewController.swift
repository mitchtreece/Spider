//
//  UIKitViewController.swift
//  Spider
//
//  Created by Mitch Treece on 5/27/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import Spider
import SpiderUI

class UIKitViewController: LoadingViewController {
    
    private var imageView: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "UIKit"
        self.view.backgroundColor = .systemGroupedBackground
        
        self.imageView = UIImageView()
        self.imageView.backgroundColor = .secondarySystemGroupedBackground
        self.imageView.layer.cornerRadius = 16
        self.imageView.layer.cornerCurve = .continuous
        self.imageView.clipsToBounds = true
        self.imageView.isUserInteractionEnabled = true
        self.view.insertSubview(self.imageView, at: 0)
        self.imageView.snp.makeConstraints { make in
            make.width.height.equalTo(view.snp.width).multipliedBy(0.9)
            make.center.equalTo(view)
        }
        
        loadRandomImage()
        
        self.imageView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap(_:))
        ))
        
    }
    
    @objc private func handleTap(_ recognizer: UITapGestureRecognizer) {
        loadRandomImage()
    }
    
    private func loadRandomImage() {
        
        guard self.isLoading == false else { return }
        
        self.imageView.image = nil
        self.startLoading()
        
        self.imageView.web.setImage("https://unsplash.it/500/?random", cacheImage: false) { (image, isCached, error) in
            
            self.imageView.image = image
            self.stopLoading()
            
        }
        
    }
    
}
