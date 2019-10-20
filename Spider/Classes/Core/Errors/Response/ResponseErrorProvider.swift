//
//  ResponseErrorProvider.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public protocol ResponseErrorProvider {
    
    associatedtype T
    func error(from response: Response<T>) -> ResponseError<T>?
    
}
