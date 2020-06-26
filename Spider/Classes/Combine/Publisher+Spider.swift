//
//  Publisher+Spider.swift
//  Spider-Web
//
//  Created by Mitch Treece on 6/24/20.
//

import Combine

public extension Publisher {
    
    func sink(receiveValue: @escaping (Self.Output)->(),
              receiveCompletion: @escaping (Subscribers.Completion<Self.Failure>)->()) -> AnyCancellable {
        
        return sink(
            receiveCompletion: receiveCompletion,
            receiveValue: receiveValue
        )
        
    }
    
    /// Attaches a subscriber with a result-based behavior.
    ///
    /// This method creates the subscriber and holds the latest value until a completion event is received.
    /// - parameter body: The closure to execute on completion.
    /// - returns: A cancellable instance; used when you end assignment of the received value. Deallocation of the result will tear down the subscription stream.
    func resultSink(_ body: @escaping (Result<Self.Output, Self.Failure>)->()) -> AnyCancellable {
        
        var _value: Self.Output!
        
        return sink(
            receiveValue: { _value = $0 },
            receiveCompletion: { completion in
            
                switch completion {
                case .finished: body(.success(_value))
                case .failure(let err): body(.failure(err))
                }
            
            })
        
    }
    
    // Ignores errors. only sinks values
    func valueSink(_ body: @escaping (Self.Output)->()) -> AnyCancellable {
        
        return sink(
            receiveValue: { body($0) },
            receiveCompletion: { _ in }
        )
        
    }
        
}
