//
//  RestAPIClient.swift
//  MyMedium
//
//  Created by neosoft on 11/01/23.
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
                                    completion: @escaping(Result<T,NetworkError>) -> Void) {
        
        @AppStorage(AppConst.tokan) var tokan: String = ""
        print(endPoint)
        let encodedURL = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(encodedURL)
        var headers: HTTPHeaders? = nil
        if(tokan != ""){
            headers = [
                "Authorization": "Bearer \(tokan)",
                "Accept": "application/json"
            ]
        } else {
            headers = nil
        }//encoding: URLEncoding(destination: .queryString)
        AF.request(encodedURL,method: method,parameters: parameters,headers: headers)
            .response { response in
                DispatchQueue.main.async {
                    print(response)
                    let statusCode = response.response?.statusCode
                    print(statusCode)
                    // If statusCode == 200 || 2001
                    if(statusCode == 200 || statusCode == 201){
                        let result = response.result
                        switch result {
                        case .success(let data):
                            guard let data = data else {
                                completion(.failure(.NoData))
                                return //https://api.realworld.io/api/profiles/Rahul%20G/follow
                            }
                            do {
                                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                                print(json)
                            }catch{
                                print(error)
                            }
//                             JSON TO Types
                            guard let obj = try? JSONDecoder().decode(T.self, from: data) else {
                                completion(.failure(.DecodingErrpr))
                                return
                            }
//
                            completion(.success(obj))
                        case .failure(let error):
                            completion(.failure(.NetworkErrorAPIError(error.localizedDescription)))
                        }
                    } else if(statusCode == 401 || statusCode == 403 || statusCode == 404 || statusCode == 422){
                        print("stat")
                        guard let jsonData = response.data else {
                            return
                        }
                        do {
                            let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
                            let error = removeSpecialCharsFromString(text: "\(json!["errors"] ?? "Error")")
                            var errorList:[String] = []
                            let errorData = JSON(json!["errors"])
                            errorData.dictionaryValue.forEach({
                                print("pring in loop data2")
                                var sunError:[String] = []
                                var finalSubError = ""
                                errorData[$0.key].forEach ({val in
                                    sunError.append(val.1.rawValue as! String)
                                })
                                finalSubError  = sunError.joined(separator: ", ")
                                errorList.append($0.key + " " + finalSubError)
                            })
                            var displayError: String = errorList.joined(separator: ", ")
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



