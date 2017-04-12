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
    @IBOutlet weak var statusLabel: UILabel!
    private var fetching: Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        statusLabel.text = nil
        
    }
    
    @IBAction func fetchPhotosWithCallbacks() {
        
        guard fetching == false else { return }
        
        self.fetching = true
        self.imageView.image = nil
        self.statusLabel.text = nil
        
        Spider.web.get(path: "https://jsonplaceholder.typicode.com/photos") { (response) in
            
            guard let data = response.data as? Data, let photos = data.json() as? [[String: Any]], response.err == nil && photos.count > 0 else {
                print("Error fetching photos")
                return
            }
            
            self.statusLabel.text = "Fetched \(photos.count) photos!"
            
            let photoUrl = photos[0]["url"] as! String
            
            Spider.web.get(path: photoUrl) { (anotherResponse) in
                
                guard let data = anotherResponse.data as? Data, let image = UIImage(data: data), anotherResponse.err == nil else {
                    print("Error fetching image")
                    return
                }
                
                print("Fetched first photo image!")
                self.imageView.image = image
                self.fetching = false
                
            }
            
        }
        
    }
    
    @IBAction func fetchPhotosWithPromises() {
        
        guard fetching == false else { return }
        
        self.fetching = true
        self.imageView.image = nil
        self.statusLabel.text = nil

        Spider.web.get(path: "https://jsonplaceholder.typicode.com/photos").then { (response) -> Promise<SpiderResponse> in
            
            guard let data = response.data as? Data, let photos = data.json() as? [[String: Any]], response.err == nil && photos.count > 0 else {
                throw SpiderError.badResponse
            }
            
            self.statusLabel.text = "Fetched \(photos.count) photos!"
            return Spider.web.get(path: photos[0]["url"] as! String)
            
        }.then { (response) -> Void in
                
            guard let data = response.data as? Data, let image = UIImage(data: data), response.err == nil else {
                throw SpiderError.badResponse
            }
            
            print("Fetched first photo image!")
            self.imageView.image = image
            self.fetching = false
                
        }.catch { (error) in
                
            print(error)
                
        }
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }

}

