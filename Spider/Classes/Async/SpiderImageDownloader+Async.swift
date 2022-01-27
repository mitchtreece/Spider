//
//  SpiderImageDownloader+Async.swift
//  Spider-Web
//
//  Created by Mitch Treece on 1/26/22.
//

//import Foundation
//
//@available(iOS 13, *)
//@available(macOS 12, *)
//public extension SpiderImageDownloader {
//
//    /// Fetches an image at a given URL.
//    /// - Parameter url: The image URL.
//    /// - Parameter cache: A boolean indicating if the image should be cached; _defaults to false_.
//    /// - Returns: An optional image download result.
//    static func getImage(_ url: URLRepresentable,
//                         cache: Bool = false) async -> (Image?, Bool, SpiderImageDownloadTask?) {
//
//        await withCheckedContinuation { c in
//
//            let task = getImage(url, cache: cache) { image, fromCache, error in
//                c.resume(returning: (image, fromCache, task))
//            }
//
//        }
//
//    }
//
//    /// Fetches an image at a given URL.
//    /// - Parameter url: The image URL.
//    /// - Parameter cache: A boolean indicating if the image should be cached; _defaults to false_.
//    /// - Returns: An image download result.
//    static func getImageThrowing(_ url: URLRepresentable,
//                                 cache: Bool = false) async throws -> (Image, Bool, SpiderImageDownloadTask?) {
//
//        try await withCheckedThrowingContinuation { c in
//
//            let task = getImage(url, cache: cache) { image, fromCache, error in
//
//                if let error = error {
//                    c.resume(throwing: error)
//                    return
//                }
//                else if let image = image {
//                    c.resume(returning: (image, fromCache, task))
//                    return
//                }
//
//                c.resume(throwing: ErrorType.invalidImage)
//
//            }
//
//        }
//
//    }
//
//}
