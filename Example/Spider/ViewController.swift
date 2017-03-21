//
//  ViewController.swift
//  Spider
//
//  Created by Mitch Treece on 12/13/2016.
//  Copyright (c) 2016 Mitch Treece. All rights reserved.
//

import UIKit
import Spider
import PromiseKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        Spider.web.get(path: "https://jsonplaceholder.typicode.com/photos", parameters: nil) { (response) in
            
            guard let data = response.data as? Data, let photos = data.json() as? [[String: Any]], response.err == nil && photos.count > 0 else {
                print("Error fetching photos")
                return
            }
            
            print("Fetched \(photos.count) photos")
            
            let photoUrl = photos[0]["url"] as! String
            
            Spider.web.get(path: photoUrl, parameters: nil) { (anotherResponse) in
                
                guard let data = anotherResponse.data as? Data, let image = UIImage(data: data), anotherResponse.err == nil else {
                    print("Error fetching image")
                    return
                }
                
                print("Fetched first image!")
                self.imageView.image = image
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }

}

