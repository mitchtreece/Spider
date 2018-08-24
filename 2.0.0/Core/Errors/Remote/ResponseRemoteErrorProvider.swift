//
//  ResponseRemoteErrorProvider.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

public protocol ResponseRemoteErrorProvider {
    func error(from response: Response) -> ResponseRemoteError?
}
