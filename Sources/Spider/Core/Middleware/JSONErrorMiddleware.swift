//
//  JSONErrorMiddleware.swift
//  Spider-Web
//
//  Created by Mitch Treece on 11/3/19.
//

import Foundation

/// A generic JSON error-catching middleware.
///
/// ```
/// {
///   "error": {
///     "alert": {
///       "title": "Error",
///       "message": "Hello, world!"
///     },
///     "description": "This is a really bad error",
///     "code": 23
///   }
/// }
/// ```
public final class JSONErrorMiddleware: Middleware {
    
    /// A JSON error object.
    public struct Error: Swift.Error {
        
        public struct Alert {
            
            let title: String?
            let message: String
            
        }
        
        /// The error alert.
        public let alert: Alert?
        
        /// The error description.
        public let description: String?
        
        /// The error code.
        public let code: Int?
        
        internal init(alert: Alert?, description: String?, code: Int?) {
            
            self.alert = alert
            self.description = description
            self.code = code
            
        }
        
    }
    
    /// The middleware's error object key; _defaults to "error"_.
    public var errorKey: String = "error"
    
    /// The middleware's alert object key; _defaults to "alert"_.
    public var alertKey: String = "alert"
    
    /// The middleware's alert title key; _defaults to "title"_.
    public var alertTitleKey: String = "title"
    
    /// The middleware's alert message key; _defaults to "message"_.
    public var alertMessageKey: String = "message"
    
    /// The middleware's error description key; _defaults to "description"_.
    public var descriptionKey: String = "description"
    
    /// The middleware's error code key; _defaults to "code"_.
    public var codeKey: String = "code"
    
    /// The middleware's error handler.
    public var handler: ((Error)->())?
    
    public override func next(_ response: Response<Data>) throws -> Response<Data> {
        
        let jsonResponse = response.map { try $0.json() }
        
        switch jsonResponse.result {
        case .success(let json):
            
            guard let error = json[self.errorKey] else { return response }
            
            var _error: Error!
            
            if let dict = error as? [String: Any] {
                
                var alert: Error.Alert?
                var desc: String?
                var code: Int?
                
                // Alert
                
                if let alertDict = dict[self.alertKey] as? [String: Any],
                    let message = alertDict[self.alertMessageKey] as? String {
  
                    var title: String?
                    
                    if let _title = alertDict[self.alertTitleKey] as? String {
                        title = _title
                    }
                    
                    alert = Error.Alert(
                        title: title,
                        message: message
                    )
                    
                }
                else if let message = dict[self.alertKey] as? String {
                    
                    alert = Error.Alert(
                        title: nil,
                        message: message
                    )
                    
                }
                         
                desc = dict[self.descriptionKey] as? String
                code = dict[self.codeKey] as? Int
                
                let error = Error(
                    alert: alert,
                    description: desc,
                    code: code
                )
                
                _error = error
                                
            }
            else if let desc = error as? String {
                                
                _error = Error(
                    alert: nil,
                    description: desc,
                    code: nil
                )
                
            }
            else if let code = error as? Int {
                                
                _error = Error(
                    alert: nil,
                    description: nil,
                    code: code
                )
                
            }
            
            self.handler?(_error)
            throw _error
            
        case .failure(let error): throw error
        }
        
    }
    
}
