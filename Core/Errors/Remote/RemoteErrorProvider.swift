//
//  RemoteErrorProvider.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

public protocol RemoteErrorProvider {
    func error(from response: Response) -> ResponseRemoteError?
}
