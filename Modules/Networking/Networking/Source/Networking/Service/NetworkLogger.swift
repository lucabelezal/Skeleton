//
//  NetworkLogger.swift
//  Networking
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Foundation

class NetworkLogger {
    
    static func log(request: URLRequest) {
        
        print("\n - - - - - - - - - - REQUEST - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        var logOutput = """
        \(urlAsString) \n\n
        \(method) \(path)?\(query) HTTPS/1.1 \n
        HOST: \(host)\n
        """
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        print(logOutput)
    }
    
    static func log(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
        
        print("\n - - - - - - - - - - RESPONSE - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        guard let data = data, let response = response else {
            return print("Error request: \(error.debugDescription)")
        }
        
        var logOutput = ""
        for (key, value) in response.dictionaryWithValues(forKeys: ["URL"]) {
            logOutput += "\(key): \(value) \n"
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            logOutput += "Status Code: \(httpResponse.statusCode)"
        }
        
        if let object = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
            let jsonData = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
            logOutput += "\n \(String(describing: prettyPrintedString))"
        }
        
        print(logOutput)
    }
    
}
