//
//  JSONResponseErrorProvider.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

//{
//    "error": {
//        "code": 401,
//        "name": "NotAuthorized",
//        "description": "You must provide a valid access token"
//    }
//}

public struct JSONResponseErrorProvider: ResponseErrorProvider {
    
    public typealias T = JSON
    
    public func error(from response: Response<JSON>) -> ResponseError<JSON>? {
        
        guard let json = response.value else {
            
            return ResponseError<JSON>(
                response: response,
                error: .badResponseData
            )
            
        }
        
        guard let errorDict = json["error"] as? JSON,
            let code = errorDict["code"] as? Int else { return nil }
        
        var description = "[\(code)]"
        
        if let name = errorDict["name"] as? String {
            
            description += " <\(name)>"
            
            if let _description = errorDict["description"] as? String {
                description += ": \(_description)"
            }
            
        }
        else if let _description = errorDict["description"] as? String {
            description += ": \(_description)"
        }
        else {
            description += "response error"
        }
        
        return ResponseError<JSON>(
            response: response,
            description: description
        )
        
    }
    
}
