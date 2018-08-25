//
//  Response+UIImage.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation
import UIKit

public extension Response {
    
    /**
     Serializes a response into a `UIImage`.
     - Returns: A `UIImage` object.
     */
    public func image() -> UIImage? {
        return self.data?.image
    }
    
}
