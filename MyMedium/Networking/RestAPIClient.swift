//
//  RestAPIClient.swift
//  MyMedium
//
//  Created by neosoft on 11/01/23.
//

import Foundation
import Alamofire

// Create API Clinet
class RestAPIClient {
    
    static func request<T: Codable>(type: T.Type,
                                    endPoint: String,
                                    method: HTTPMethod = .get,
                                    parameters: Parameters? = nil,
                                    completion: @escaping(Result<T,NetworkError>) -> Void) {
        
        AF.request(endPoint,method: method,parameters: parameters,encoding: URLEncoding.default)
            .response { response in
                DispatchQueue.main.async {
                    let statusCode = response.response?.statusCode
                    // If statusCode == 200 || 2001
                    if(statusCode == 200 || statusCode == 201){
                        let result = response.result
                        switch result {
                        case .success(let data):
                            guard let data = data else {
                                completion(.failure(.NoData))
                                return
                            }
                            // JSON TO Types
                            guard let obj = try? JSONDecoder().decode(T.self, from: data) else {
                                completion(.failure(.DecodingErrpr))
                                return
                            }
                            completion(.success(obj))
                        case .failure(let error):
                            completion(.failure(.NetworkErrorAPIError(error.localizedDescription)))
                        }
                    } else if(statusCode == 401 || statusCode == 403 || statusCode == 404){
                        print("stat")
                        guard let jsonData = response.data else {
                            return
                        }
                        do {
                            let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
                            let error = removeSpecialCharsFromString(text: "\(json!["errors"] ?? "Error")")
                            completion(.failure(.NetworkErrorAPIError(error)))
                        } catch {
                            print("Error deserializing JSON: \(error)")
                            completion(.failure(.NetworkErrorAPIError("Error deserializing JSON")))
                        }
                    } else {
                        guard let jsonData = response.data else {
                            return
                        }
                        //                        completion(.failure(.NetworkErrorAPIError("Api Error")))
                        do {
                            let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
                            let error = removeSpecialCharsFromString(text: "\(json!["errors"] ?? "Error")")
                            completion(.failure(.NetworkErrorAPIError(error as! String)))
                        } catch {
                            print("Error deserializing JSON: \(error)")
                            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                                print("Data: \(utf8Text)")
                                completion(.failure(.NetworkErrorAPIError("Error: \(utf8Text)")))
                            }
                            
                        }
                        
                    }
                }
            }
        func removeSpecialCharsFromString(text: String) -> String {
            let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-.!_")
            return text.filter {okayChars.contains($0) }
        }
    }
   
}

// Error Case
enum NetworkError: Error {
    case BadURL
    case NoData
    case DecodingErrpr
    case NetworkErrorAPIError(String)
}



