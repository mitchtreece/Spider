//
//  PlatformSupport.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

#if os(iOS)
    import UIKit
    public typealias Image = UIImage
#elseif os(macOS)
    import AppKit
    public typealias Image = NSImage
#endif
