//
//  ResponseErrorCatcher.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

//public protocol ResponseErrorCatcher {
//
//    associatedtype T
//    func `catch`(response: Response<T>) -> ResponseError<T>?
//
//}

//public typealias ResponseErrorCatcher<T> = (Response<T>)->(ResponseError<T>?)
//
//public struct AnyResponseErrorCatcher {
//    
//    private let catcher: (Response<Any>)->(ResponseError<Any>?)
//    
////    init<C: ResponseErrorCatcher>(_ catcher: C) where C.T == T {
////        self.catcher = catcher
////    }
////
////
////
////    public func `catch`(response: Response<Any>) -> ResponseError<Any>? {
////        (self.catcher as! ResponseErrorCatcher).catch(response: response)
////    }
//    
//    init<T>(catcher: @escaping (Response<T>)->(ResponseError<T>?)) {
//        self.catcher = catcher
//    }
//    
//}
