//
//  Cancellable.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/22/19.
//

import Foundation

/// Protocol describing the attributes of a cancellable task.
internal protocol Cancellable {
    
    /// Flag indicating if the task has been cancelled.
    var isCancelled: Bool { get }
    
    /// Cancels the task.
    func cancel()
    
}
