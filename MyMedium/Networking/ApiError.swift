//
//  ApiError.swift
//  MyMedium
//
//  Created by na on 11/01/23.
//

import Foundation
struct ApiError {
    
    private static func CheckApiError(response: HTTPURLResponse?) -> Bool{
        if response?.statusCode == 200 || response?.statusCode == 201 {
            return true;
        } else {
//            guard let errorData = try? JSONDecoder().decode(T.self, from: data! ) else {
//                print("Error: Couldn't decode data into LoginResponseError")
//                return false
//            }
//            return false
            return true
        }
    }
    
    static func checkApiError(response: HTTPURLResponse?) -> Bool{
        return CheckApiError(response: response)
    }
}

// MARK: - AppErrorRespons
struct AppErrorRespons: Codable {
    let errors: Errors
}

// MARK: - Errors
struct Errors: Codable {
    let body: [String]
}
