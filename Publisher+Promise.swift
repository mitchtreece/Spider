//
//  Publisher+Promise.swift
//  Spider-Web
//
//  Created by Mitch Treece on 6/25/20.
//

import Combine

//public func flatMap<T, P>(maxPublishers: Subscribers.Demand = .unlimited, _ transform: @escaping (Self.Output) -> P) -> Publishers.FlatMap<P, Self> where T == P.Output, P : Publisher, Self.Failure == P.Failure

public extension Publisher /* Promise */ {
    
    // TODO: then
    
    // Sugar for `resultSink`
    func done(_ body: @escaping (Result<Output, Failure>)->()) -> AnyCancellable {
        return resultSink(body)
    }
    
}
