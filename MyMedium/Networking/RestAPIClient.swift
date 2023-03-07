//
//  RestAPIClient.swift
//  Conduit
//
//  Created by na on 11/01/23.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftUI

// Create API Clinet
class RestAPIClient {
    
    static func request<T: Codable>(type: T.Type,
                                    endPoint: String,
                                    method: HTTPMethod = .get,
                                    parameters: Parameters? = nil,
                                    completion: @escaping(Result<T,NetworkError>) -> Void,
                                    costumeCompletion: ((HTTPURLResponse?) -> Void)? = nil) {
        
        @AppStorage(AppConst.token) var token: String = ""
        let encodedURL = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var headers: HTTPHeaders? = nil
        if(token != ""){
            headers = [
                "Authorization": "Bearer \(token)",
                "Accept": "application/json"
            ]
        } else {
            headers = nil
        }
        AF.request(encodedURL,method: method,parameters: parameters,headers: headers)
            .response { response in
                ApiError().handleError(response: response) { result in
                    switch result {
                    case .success(let value):
                        print("Success: \(value)")
                        DispatchQueue.main.async {
                            if (costumeCompletion != nil) {
                                costumeCompletion!(response.response)
                                return
                            }
                            let statusCode = response.response?.statusCode
                            if(statusCode == 204){
                                completion(.success("Done" as! T))
                                return
                            }
                            if(statusCode == 200 || statusCode == 201){
                                let result = response.result
                                switch result {
                                case .success(let data):
                                    guard let data = data else {
                                        completion(.failure(.NoData))
                                        return
                                    }
                                    do {
                                        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                                    } catch {
                                        print(error)
                                    }
                                    // JSON TO Types
                                    guard let obj = try? JSONDecoder().decode(T.self, from: data) else {
                                        completion(.failure(.DecodingError))
                                        return
                                    }
                                    completion(.success(obj))
                                case .failure(let error):
                                    completion(.failure(.NetworkErrorAPIError(error.localizedDescription)))
                                }
                            } else if(statusCode == 401 || statusCode == 403 || statusCode == 404 || statusCode == 422){
                                guard let jsonData = response.data else {
                                    return
                                }
                                do {
                                    let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
                                    let error = removeSpecialCharsFromString(text: "\(json!["errors"] ?? "Error")")
                                    var errorList:[String] = []
                                    let errorData = JSON(json!["errors"])
                                    errorData.dictionaryValue.forEach({
                                        var sunError:[String] = []
                                        var finalSubError = ""
                                        errorData[$0.key].forEach ({val in
                                            sunError.append(val.1.rawValue as! String)
                                        })
                                        finalSubError  = sunError.joined(separator: ", ")
                                        errorList.append($0.key + " " + finalSubError)
                                    })
                                    let displayError: String = errorList.joined(separator: ", ")
                                    let dynamicKeys = json!.keys
                                    completion(.failure(.NetworkErrorAPIError(displayError.capitalized)))
                                } catch {
                                    print("Error deserializing JSON: \(error)")
                                    completion(.failure(.NetworkErrorAPIError("Error deserializing JSON")))
                                }
                            } else {
                                guard let jsonData = response.data else {
                                    return
                                }
                                do {
                                    let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
                                    let error = removeSpecialCharsFromString(text: "\(json!["errors"] ?? "Error")")
                                    completion(.failure(.NetworkErrorAPIError(error )))
                                } catch {
                                    print("Error deserializing JSON: \(error)")
                                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                                        completion(.failure(.NetworkErrorAPIError("Error: \(utf8Text)")))
                                    }
                                    
                                }
                            }
                        }
                    case .failure(let error):
                        print("Failure: \(error.localizedDescription)")
                        completion(.failure(.NetworkErrorAPIError(error.localizedDescription)))
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
    case DecodingError
    case NetworkErrorAPIError(String)
}



