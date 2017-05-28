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

class UIKitViewController: LoadingViewController {
    
    private var imageView: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "UIKit"
        view.backgroundColor = UIColor.groupTableViewBackground
        
        imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        view.insertSubview(imageView, at: 0)
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(view.snp.width).multipliedBy(0.9)
            make.center.equalTo(view)
        }
        
        loadRandomImage()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        imageView.addGestureRecognizer(recognizer)
        
    }
    
    @objc private func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        loadRandomImage()
        
    }
    
    private func loadRandomImage() {
        
        guard self.isLoading == false else { return }
        
        imageView.image = nil
        self.startLoading()
        
        imageView.web.setImage("https://unsplash.it/500/?random", cacheImage: false) { (image, isCached, error) in
            
            self.imageView.image = image
            self.stopLoading()
            
        }
        
    }
    
}
