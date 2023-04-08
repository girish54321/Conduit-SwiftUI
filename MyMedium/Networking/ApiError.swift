//
//  ApiError.swift
//  Conduit
//
//  Created by na on 11/01/23.
//

import Foundation
import Alamofire

struct ApiError {
    
    func handleError<T: Decodable>(response: DataResponse<T, AFError>, completion: (Result<T, Error>) -> Void) {
        switch response.result {
        case .success(let value):
            completion(.success(value))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private static func CheckApiError(response: HTTPURLResponse?) -> Bool{
        if response?.statusCode == 200 || response?.statusCode == 201 {
            
            return true;
        } else {
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


