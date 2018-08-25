//
//  JSONRemoteError.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

//{
//    "status": "KO",
//    "error": {
//        "code": 401,
//        "name": "NotAuthorized",
//        "description": "You must provide a valid access token"
//    }
//}

public class JSONRemoteError: ResponseRemoteErrorProvider {
    
    public var statusField = "status"
    public var errorField = "error"
    public var errorCodeField = "code"
    public var errorNameField = "name"
    public var errorDescriptionField = "description"
    
    public func error(from response: Response) -> ResponseRemoteError? {
        
        guard let json = response.data?.json, let status = json[statusField] as? String else {
            return ResponseRemoteError(error: .bad(response))
        }
        
        guard status.uppercased() != "OK" else { return nil }
        
        guard let errorDict = json[errorField] as? JSON else {
            return ResponseRemoteError(error: .bad(response))
        }
        
        var description = (errorDict[errorDescriptionField] as? String) ?? "JSON Response error"
        
        if response.statusCode != .none {
            description = response.statusCode.name
        }
        
        return ResponseRemoteError(description: description, response: response)
        
    }
    
}
