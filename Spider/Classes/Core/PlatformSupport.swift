//
//  PlatformSupport.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

#if canImport(UIKit)
    import UIKit
    public typealias Image = UIImage
    public typealias ImageView = UIImageView
    public typealias View = UIView
#elseif os(macOS)
    import AppKit
    public typealias Image = NSImage
    public typealias ImageView = NSImageView
    public typealias View = NSView
#endif
