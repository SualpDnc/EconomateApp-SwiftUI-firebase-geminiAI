//
//  APIKey.swift
//  Economate
//
//  Created by Sualp Danacı on 31.05.2024.
//

import Foundation

enum APIKey {
    static var `default` : String {
        guard let filePath = Bundle.main.path(forResource: "GenerativeAi-Info", ofType: "plist")
        else{
            fatalError("couldnt find the propertylist file")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else{
            fatalError("couldnt find apikey in plist")
        }
        if value.starts(with: "_"){
            fatalError("follow instructions")
        }
        return value
    }
}
