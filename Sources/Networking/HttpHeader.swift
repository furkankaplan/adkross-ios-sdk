//
//  File.swift
//  
//
//  Created by Furkan Kaplan on 23.06.2022.
//

import Foundation

struct HttpHeader {
    
    static func get(
        with apiKey: String,
        appKey: String
    ) -> [String : String] {
        return [
            "apiKey" : apiKey,
            "appKey" : appKey
        ]
    }
}
