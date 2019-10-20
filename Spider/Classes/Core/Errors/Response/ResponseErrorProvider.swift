//
//  ResponseErrorProvider.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public protocol ResponseErrorProvider {
    func error<T>(from response: Response<T>) -> Error?
}
