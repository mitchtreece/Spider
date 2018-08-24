//
//  HTTPStatusCode.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

// Source: https://httpstatuses.com

public enum HTTPStatusCode: Int {
    
    // MARK: None
    
    case none = 0
    
    // MARK: 100's - Informational
    
    case `continue` = 100
    case switchingProtocols = 101
    case processing = 102
    
    // MARK: 200's - Success
    
    case ok = 200
    case created = 201
    case accepted = 202
    case nonAuthoritativeInfo = 203
    case noContent = 204
    case resetContent = 205
    case partialContent = 206
    case multiStatus = 207
    case alreadyReported = 208
    case imUsed = 226
    
    // MARK: 300's - Redirection
    
    case multipleChoices = 300
    case movedPermanently = 301
    case found = 302
    case seeOther = 303
    case notModified = 304
    case useProxy = 305
    case temporaryRedirect = 307
    case permanentRedirect = 308
    
    // MARK: 400's - Client error
    
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case requestTimeout = 408
    case conflict = 409
    case gone = 410
    case lengthRequired = 411
    case preconditionFailed = 412
    case payloadTooLarge = 413
    case requestURITooLong = 414
    case unsupportedMediaType = 415
    case requestedRangeNotSatisfiable = 416
    case expectationFailed = 417
    case teapot = 418
    case misdirectedRequest = 421
    case unprocessableEntity = 422
    case locked = 423
    case failedDependency = 424
    case upgradeRequired = 426
    case preconditionRequired = 428
    case tooManyRequests = 429
    case requestHeaderFieldsTooLarge = 431
    case connectionClosedWithoutResponse = 444
    case unavailableForLegalReasons = 451
    case clientClosedRequest = 499
    
    // MARK: 500's - Server error
    
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    case httpVersionNotSupported = 505
    case variantAlsoNegotiates = 506
    case insufficientStorage = 507
    case loopDetected = 508
    case notExtended = 510
    case networkAuthenticationRequired = 511
    case networkConnectTimeoutError = 599
    
}

public extension HTTPStatusCode /* Value */ {
    
    public var value: Int {
        return rawValue
    }
    
}
