//
//  HTTPStatusCode+Name.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

public extension HTTPStatusCode /* Name */ {
    
    public var name: String {
        
        switch self {
        
        // MARK: 100's - Informational
            
        case .continue: return "Continue"
        case .switchingProtocols: return "Switching Protocols"
        case .processing: return "Processing"
            
        // MARK: 200's - Success
            
        case .ok: return "OK"
        case .created: return "Created"
        case .accepted: return "Accepted"
        case .nonAuthoritativeInfo: return "Non-authoritative Information"
        case .noContent: return "No Content"
        case .resetContent: return "Reset Content"
        case .partialContent: return "Partial Content"
        case .multiStatus: return "Multi-Status"
        case .alreadyReported: return "Already Reported"
        case .imUsed: return "IM Used"
            
        // MARK: 300's - Redirection
            
        case .multipleChoices: return "Multiple Choices"
        case .movedPermanently: return "Moved Permanently"
        case .found: return "Found"
        case .seeOther: return "See Other"
        case .notModified: return "Not Modified"
        case .useProxy: return "Use Proxy"
        case .temporaryRedirect: return "Temporary Redirect"
        case .permanentRedirect: return "Permanent Redirect"
            
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
