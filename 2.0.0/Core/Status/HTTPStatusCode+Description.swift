//
//  HTTPStatusCode+Description.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

public extension HTTPStatusCode /* Description */ {
    
    public var description: String {
        
        switch self {
            
        // MARK: 100's - Informational
            
        case .continue: return "The initial part of a request has been received and has not yet been rejected by the server. The server intends to send a final response after the request has been fully received and acted upon."
            
        case .switchingProtocols: return "The server understands and is willing to comply with the client's request, via the Upgrade header field, for a change in the application protocol being used on this connection."
            
        case .processing: return "An interim response used to inform the client that the server has accepted the complete request, but has not yet completed it."
            
        // MARK: 200's - Success
            
        case .ok: return "The payload sent in a 200 response depends on the request method. Aside from responses to CONNECT, a 200 response always has a payload, though an origin server MAY generate a payload body of zero length. If no payload is desired, an origin server ought to send 204 No Content instead. For CONNECT, no payload is allowed because the successful result is a tunnel, which begins immediately after the 200 response header section."
            
        case .created: return "The request has been fulfilled and has resulted in one or more new resources being created."
            
        case .accepted: return "The request has been accepted for processing, but the processing has not been completed. The request might or might not eventually be acted upon, as it might be disallowed when processing actually takes place."
            
        case .nonAuthoritativeInfo: return "The request was successful but the enclosed payload has been modified from that of the origin server's 200 OK response by a transforming proxy."
            
        case .noContent: return "The server has successfully fulfilled the request and that there is no additional content to send in the response payload body."
            
        case .resetContent: return "The server has fulfilled the request and desires that the user agent reset the \"document view\", which caused the request to be sent, to its original state as received from the origin server."
            
        case .partialContent: return "The server is successfully fulfilling a range request for the target resource by transferring one or more parts of the selected representation that correspond to the satisfiable ranges found in the request's Range header field."
            
        case .multiStatus: return "A Multi-Status response conveys information about multiple resources in situations where multiple status codes might be appropriate."
            
        case .alreadyReported: return "Used inside a DAV: propstat response element to avoid enumerating the internal members of multiple bindings to the same collection repeatedly."
            
        case .imUsed: return "The server has fulfilled a GET request for the resource, and the response is a representation of the result of one or more instance-manipulations applied to the current instance."
            
        // MARK: 300's - Redirection
            
        case .multipleChoices: return "The target resource has more than one representation, each with its own more specific identifier, and information about the alternatives is being provided so that the user (or user agent) can select a preferred representation by redirecting its request to one or more of those identifiers."
            
        case .movedPermanently: return "The target resource has been assigned a new permanent URI and any future references to this resource ought to use one of the enclosed URIs."
            
        case .found: return "The target resource resides temporarily under a different URI. Since the redirection might be altered on occasion, the client ought to continue to use the effective request URI for future requests."
            
        case .seeOther: return "The server is redirecting the user agent to a different resource, as indicated by a URI in the Location header field, which is intended to provide an indirect response to the original request."
            
        case .notModified: return "A conditional GET or HEAD request has been received and would have resulted in a 200 OK response if it were not for the fact that the condition evaluated to false."
            
        case .useProxy: return "Defined in a previous version of this specification and is now deprecated, due to security concerns regarding in-band configuration of a proxy."
            
        case .temporaryRedirect: return "The target resource resides temporarily under a different URI and the user agent MUST NOT change the request method if it performs an automatic redirection to that URI."
            
        case .permanentRedirect: return "The target resource has been assigned a new permanent URI and any future references to this resource ought to use one of the enclosed URIs."
            
        // MARK: 400's - Client error
            
        case .badRequest: return "Bad Request"
        case .unauthorized: return "Unauthorized"
        case .paymentRequired: return "Payment Required"
        case .forbidden: return "Forbidden"
        case .notFound: return "Not Found"
        case .methodNotAllowed: return "Method Not Allowed"
        case .notAcceptable: return "Not Acceptable"
        case .proxyAuthenticationRequired: return "Proxy Authentication Required"
        case .requestTimeout: return "Request Timeout"
        case .conflict: return "Conflict"
        case .gone: return "Gone"
        case .lengthRequired: return "Length Required"
        case .preconditionFailed: return "Precondition Failed"
        case .payloadTooLarge: return "Payload Too Large"
        case .requestURITooLong: return "Request-URI Too Long"
        case .unsupportedMediaType: return "Unsupported Media Type"
        case .requestedRangeNotSatisfiable: return "Requested Range Not Satisfiable"
        case .expectationFailed: return "Expectation Failed"
        case .teapot: return "I'm a teapot"
        case .misdirectedRequest: return "Misdirected Request"
        case .unprocessableEntity: return "Unprocessable Entity"
        case .locked: return "Locked"
        case .failedDependency: return "Failed Dependency"
        case .upgradeRequired: return "Upgrade Required"
        case .preconditionRequired: return "Precondition Required"
        case .tooManyRequests: return "Too Many Requests"
        case .requestHeaderFieldsTooLarge: return "Request Header Fields Too Large"
        case .connectionClosedWithoutResponse: return "Connection Closed Without Response"
        case .unavailableForLegalReasons: return "Unavailable For Legal Reasons"
        case .clientClosedRequest: return "Client Closed Request"
            
        // MARK: 500's - Server error
            
        case .internalServerError: return "Internal Server Error"
        case .notImplemented: return "Not Implemented"
        case .badGateway: return "Bad Gateway"
        case .serviceUnavailable: return "Service Unavailable"
        case .gatewayTimeout: return "Gateway Timeout"
        case .httpVersionNotSupported: return "HTTP Version Not Supported"
        case .variantAlsoNegotiates: return "Variant Also Negotiates"
        case .insufficientStorage: return "Insufficient Storage"
        case .loopDetected: return "Loop Detected"
        case .notExtended: return "Not Extended"
        case .networkAuthenticationRequired: return "Network Authentication Required"
        case .networkConnectTimeoutError: return "Network Connect Timeout Error"
            
        }
        
    }
    
}
