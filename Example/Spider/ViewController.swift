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

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        let baseUrl = URL(string: "https://jsonplaceholder.typicode.com")!
//        let accessToken = SpiderToken(headerField: "x-access-token", value: "123456789")
//
//        // Shared (One-time request)
//        
//        Spider.web.get(path: "http://loremflickr.com/300/300", parameters: nil) { (res, obj, err) in
//            print("Shared (One-time request)")
//        }
//        
//        // Shared (Base url)
//        
//        Spider.web(withBaseUrl: baseUrl).get(path: "/300/300", parameters: nil) { (res, obj, err) in
//            print("Shared (Base url)")
//        }
//        
//        // Instance (One-time request)
//        
//        let spider = Spider()
//        spider.get(path: "http://loremflickr.com/300/300", parameters: nil) { (res, obj, err) in
//            print("Instance (One-time request)")
//        }
//        
//        // Instance (Base url)
//        
//        let spider2 = Spider(baseUrl: baseUrl)
//        spider2.get(path: "/300/300", parameters: nil) { (res, obj, err) in
//            print("Instance (Base url)")
//        }
//        
//        // Advanced Request
//        
//        let spider3 = Spider()
//        let request = SpiderRequest(method: .get, path: "http://loremflickr.com/300/300", parameters: nil)
//        request.header.accept = [.image_jpeg]
//        spider3.perform(request) { (res, obj, err) in
//            print("Advanced Request")
//        }
//
//        // Shared Token Authorization (Per request)
//        
//        Spider.web.get(path: "/300/300", parameters: nil, auth: .token(accessToken)) { (res, obj, err) in
//            print("Shared Token Authorization (Per request)")
//        }
//        
//        // Shared Token Authorization (Every request)
//        
//        Spider.web(withBaseUrl: baseUrl, auth: .token(accessToken)).get(path: "/300/300", parameters: nil) { (res, obj, err) in
//            print("Shared Token Authorization (Every request)")
//        }
//        
//        // Token Authorization (Instance)
//        
//        let spider4 = Spider(baseUrl: baseUrl, auth: Spider.Authorization.token(accessToken))
//        spider4.get(path: "/300/300", parameters: nil) { (res, obj, err) in
//            print("Token Authorization (Instance)")
//        }
//
//        // Promises
//        
//        Spider.web.get(path: "https://jsonplaceholder.typicode.com/photos", parameters: nil).then { (response) -> Promise<SpiderResponse> in
//            
//            guard let data = response.data as? Data, let photos = data.json() as? [[String: Any]], response.err == nil && photos.count > 0 else {
//                throw SpiderError.badResponse
//            }
//            
//            return Spider.web.get(path: photos[0]["url"] as! String, parameters: nil)
//            
//        }.then { (response) -> Void in
//                
//            guard let data = response.data as? Data, let image = UIImage(data: data) else {
//                throw SpiderError.badResponse
//            }
//            
//            print(image)
//                
//        }.always {
//                
//            print("Image download finished!")
//                
//        }.catch { (error) in
//                
//            print(error);
//                
//        }
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }

}

