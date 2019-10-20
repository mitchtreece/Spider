//
//  HTTPStatusCode.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

// Source: https://httpstatuses.com


public extension HTTPStatusCode {
    
    static func from(response: URLResponse?) -> HTTPStatusCode? {
        
        if let statusCode = (response as? HTTPURLResponse)?.statusCode {
            return HTTPStatusCode(rawValue: statusCode)
        }
        
        return nil
        
    }
    
}

public enum HTTPStatusCode: Int {
    
    // MARK: 100's - Informational
    
    /// The initial part of a request has been received and has not yet been rejected by the server.
    /// The server intends to send a final response after the request has been fully received and acted upon.
    case `continue` = 100
    
    /// The server understands and is willing to comply with the client's request, via the `Upgrade` header field,
    /// for a change in the application protocol being used on this connection.
    case switchingProtocols = 101
    
    /// An interim response used to inform the client that the server has accepted the complete request,
    /// but has not yet completed it.
    case processing = 102
    
    // MARK: 200's - Success
    
    /// The payload sent in a `200` response depends on the request method. Aside from responses to `CONNECT`,
    /// a `200` response always has a payload, though an origin server _may_ generate a payload body of zero length.
    /// If no payload is desired, an origin server ought to send `204 No Content` instead.
    /// For `CONNECT`, no payload is allowed because the successful result is a tunnel,
    /// which begins immediately after the `200` response header section.
    case ok = 200
    
    /// The request has been fulfilled and has resulted in one or more new resources being created.
    case created = 201
    
    /// The request has been accepted for processing, but the processing has not been completed.
    /// The request might or might not eventually be acted upon, as it might be disallowed when processing actually takes place.
    case accepted = 202
    
    /// The request was successful but the enclosed payload has been modified from that of the origin server's
    /// `200 OK` response by a transforming proxy.
    case nonAuthoritativeInfo = 203
    
    /// The server has successfully fulfilled the request and that there is no additional content to send in the response payload body.
    case noContent = 204
    
    /// The server has fulfilled the request and desires that the user agent reset the \"document view\",
    /// which caused the request to be sent, to its original state as received from the origin server.
    case resetContent = 205
    
    /// The server is successfully fulfilling a range request for the target resource by transferring one or more
    /// parts of the selected representation that correspond to the satisfiable ranges found in the request's Range header field.
    case partialContent = 206
    
    /// A Multi-Status response conveys information about multiple resources in situations where multiple
    /// status codes might be appropriate.
    case multiStatus = 207
    
    /// Used inside a DAV: propstat response element to avoid enumerating the internal members of
    /// multiple bindings to the same collection repeatedly.
    case alreadyReported = 208
    
    /// The server has fulfilled a `GET` request for the resource, and the response is a representation of the
    /// result of one or more instance-manipulations applied to the current instance.
    case imUsed = 226
    
    // MARK: 300's - Redirection
    
    /// The target resource has more than one representation, each with its own more specific identifier,
    /// and information about the alternatives is being provided so that the user (or user agent)
    /// can select a preferred representation by redirecting its request to one or more of those identifiers.
    case multipleChoices = 300
    
    /// The target resource has been assigned a new permanent URI and any future references to this
    /// resource ought to use one of the enclosed URIs.
    case movedPermanently = 301
    
    /// The target resource resides temporarily under a different URI. Since the redirection might be altered on occasion,
    /// the client ought to continue to use the effective request URI for future requests.
    case found = 302
    
    /// The server is redirecting the user agent to a different resource, as indicated by a URI in the Location header field,
    /// which is intended to provide an indirect response to the original request.
    case seeOther = 303
    
    /// A conditional `GET` or `HEAD` request has been received and would have resulted in a `200 OK` response
    /// if it were not for the fact that the condition evaluated to false.
    case notModified = 304
    
    /// Defined in a previous version of this specification and is now deprecated,
    /// due to security concerns regarding in-band configuration of a proxy.
    case useProxy = 305
    
    /// The target resource resides temporarily under a different URI and the user agent
    /// **must not** change the request method if it performs an automatic redirection to that URI.
    case temporaryRedirect = 307
    
    /// The target resource has been assigned a new permanent URI and any future references
    /// to this resource ought to use one of the enclosed URIs.
    case permanentRedirect = 308
    
    // MARK: 400's - Client error
    
    /// The server cannot or will not process the request due to something that is perceived to be a client error
    /// (e.g., malformed request syntax, invalid request message framing, or deceptive request routing).
    case badRequest = 400
    
    /// The request has not been applied because it lacks valid authentication credentials for the target resource.
    case unauthorized = 401
    
    /// Reserved for future use.
    case paymentRequired = 402
    
    /// The server understood the request but refuses to authorize it.
    case forbidden = 403
    
    /// The origin server did not find a current representation for the target resource
    /// or is not willing to disclose that one exists.
    case notFound = 404
    
    /// The method received in the request-line is known by the origin server but not supported by the target resource.
    case methodNotAllowed = 405
    
    /// The target resource does not have a current representation that would be acceptable to the user agent,
    /// according to the proactive negotiation header fields received in the request,
    /// and the server is unwilling to supply a default representation.
    case notAcceptable = 406
    
    /// Similar to `401 Unauthorized`, but it indicates that the client needs to authenticate itself in order to use a proxy.
    case proxyAuthenticationRequired = 407
    
    /// The server did not receive a complete request message within the time that it was prepared to wait.
    case requestTimeout = 408
    
    /// The request could not be completed due to a conflict with the current state of the target resource.
    /// This code is used in situations where the user might be able to resolve the conflict and resubmit the request.
    case conflict = 409
    
    /// The target resource is no longer available at the origin server and that this condition is likely to be permanent.
    case gone = 410
    
    /// The server refuses to accept the request without a defined Content-Length.
    case lengthRequired = 411
    
    /// One or more conditions given in the request header fields evaluated to false when tested on the server.
    case preconditionFailed = 412
    
    /// The server is refusing to process a request because the request payload is
    /// larger than the server is willing or able to process.
    case payloadTooLarge = 413
    
    /// The server is refusing to service the request because the request-target is
    /// longer than the server is willing to interpret.
    case requestURITooLong = 414
    
    /// The origin server is refusing to service the request because the payload is in a
    /// format not supported by this method on the target resource.
    case unsupportedMediaType = 415
    
    /// None of the ranges in the request's Range header field overlap the current extent of the
    /// selected resource or that the set of ranges requested has been rejected due to
    /// invalid ranges or an excessive request of small or overlapping ranges.
    case requestedRangeNotSatisfiable = 416
    
    /// The expectation given in the request's `Expect` header field could not be met by at least one of the inbound servers.
    case expectationFailed = 417
    
    /// Any attempt to brew coffee with a teapot should result in the error code
    ///`418 I'm a teapot`. The resulting entity body _may_ be short and stout.
    case teapot = 418
    
    /// The request was directed at a server that is not able to produce a response.
    /// This can be sent by a server that is not configured to produce responses for the
    /// combination of scheme and authority that are included in the request URI.
    case misdirectedRequest = 421
    
    /// The server understands the content type of the request entity
    /// (hence a `415 Unsupported Media Type` status code is inappropriate), and the syntax of the
    /// request entity is correct (thus a `400 Bad Request` status code is inappropriate) but was
    /// unable to process the contained instructions.
    case unprocessableEntity = 422
    
    /// The source or destination resource of a method is locked.
    case locked = 423
    
    /// The method could not be performed on the resource because the requested
    /// action depended on another action and that action failed.
    case failedDependency = 424
    
    /// The server refuses to perform the request using the current protocol but might be
    /// willing to do so after the client upgrades to a different protocol.
    case upgradeRequired = 426
    
    /// The origin server requires the request to be conditional.
    case preconditionRequired = 428
    
    /// The user has sent too many requests in a given amount of time (\"rate limiting\").
    case tooManyRequests = 429
    
    /// The server is unwilling to process the request because its header fields are too large.
    /// The request _may_ be resubmitted after reducing the size of the request header fields.
    case requestHeaderFieldsTooLarge = 431
    
    /// A non-standard status code used to instruct nginx to close the connection without
    /// sending a response to the client, most commonly used to deny malicious or malformed requests.
    case connectionClosedWithoutResponse = 444
    
    /// The server is denying access to the resource as a consequence of a legal demand.
    case unavailableForLegalReasons = 451
    
    /// A non-standard status code introduced by nginx for the case when a client
    /// closes the connection while nginx is processing the request.
    case clientClosedRequest = 499
    
    // MARK: 500's - Server error
    
    /// The server encountered an unexpected condition that prevented it from fulfilling the request.
    case internalServerError = 500
    
    /// The server does not support the functionality required to fulfill the request.
    case notImplemented = 501
    
    /// The server, while acting as a gateway or proxy, received an invalid response from an
    /// inbound server it accessed while attempting to fulfill the request.
    case badGateway = 502
    
    /// The server is currently unable to handle the request due to a temporary overload or scheduled maintenance,
    /// which will likely be alleviated after some delay.
    case serviceUnavailable = 503
    
    /// The server, while acting as a gateway or proxy, did not receive a timely response from an
    /// upstream server it needed to access in order to complete the request.
    case gatewayTimeout = 504
    
    /// The server does not support, or refuses to support, the major version of HTTP that was used in the request message.
    case httpVersionNotSupported = 505
    
    /// The server has an internal configuration error: the chosen variant resource is configured to engage in
    /// transparent content negotiation itself, and is therefore not a proper end point in the negotiation process.
    case variantAlsoNegotiates = 506
    
    /// The method could not be performed on the resource because the server is unable to
    /// store the representation needed to successfully complete the request.
    case insufficientStorage = 507
    
    /// The server terminated an operation because it encountered an infinite loop while
    /// processing a request with \"Depth: infinity\". This status indicates that the entire operation failed.
    case loopDetected = 508
    
    /// The policy for accessing the resource has not been met in the request.
    /// The server should send back all the information necessary for the client to issue an extended request.
    case notExtended = 510
    
    /// The client needs to authenticate to gain network access.
    case networkAuthenticationRequired = 511
    
    /// This status code is not specified in any RFCs, but is used by some HTTP proxies to signal a
    /// network connect timeout behind the proxy to a client in front of the proxy.
    case networkConnectTimeoutError = 599
    
}
