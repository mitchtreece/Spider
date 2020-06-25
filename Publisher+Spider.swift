//
//  Publisher+Spider.swift
//  Spider-Web
//
//  Created by Mitch Treece on 6/24/20.
//

import Combine

public extension Publisher {
    
    /// Attaches a subscriber with a result-based behavior.
    ///
    /// This method creates the subscriber and holds the latest value until a completion event is received.
    /// - parameter body: The closure to execute on completion.
    /// - returns: A cancellable instance; used when you end assignment of the received value. Deallocation of the result will tear down the subscription stream.
    func resultSink(_ body: @escaping (Result<Self.Output, Self.Failure>)->()) -> AnyCancellable {
        
        var _value: Self.Output!
        
        return self.sink(receiveCompletion: { completion in
            
            switch completion {
            case .finished: body(.success(_value))
            case .failure(let err): body(.failure(err))
            }
            
        }, receiveValue: { value in
            
            _value = value
            
        })
        
    }
        
}
