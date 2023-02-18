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
            if let error = error as? AFError {
                switch error {
                case .invalidURL(let url):
                    print("Invalid URL: \(url) - \(error.localizedDescription)")
                case .parameterEncodingFailed(let reason):
                    print("Parameter encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .multipartEncodingFailed(let reason):
                    print("Multipart encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .responseValidationFailed(let reason):
                    print("Response validation failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")

                    switch reason {
                    case .dataFileNil, .dataFileReadFailed:
                        print("Downloaded file could not be read")
                    case .missingContentType(let acceptableContentTypes):
                        print("Content Type Missing: \(acceptableContentTypes)")
                    case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                        print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                    case .unacceptableStatusCode(let code):
                        print("Response status code was unacceptable: \(code)")
                    case .customValidationFailed(error: let error):
                        print("to do")
                    }
                case .responseSerializationFailed(let reason):
                    print("Response serialization failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .createUploadableFailed(error: let error):
                    print("to do")
                case .createURLRequestFailed(error: let error):
                    print("to do")
                case .downloadedFileMoveFailed(error: let error, source: let source, destination: let destination):
                    print("to do")
                case .explicitlyCancelled:
                    print("to do")
                case .parameterEncoderFailed(reason: let reason):
                    print("to do")
                case .requestAdaptationFailed(error: let error):
                    print("to do")
                case .requestRetryFailed(retryError: let retryError, originalError: let originalError):
                    print("to do")
                case .serverTrustEvaluationFailed(reason: let reason):
                    print("to do")
                case .sessionDeinitialized:
                    print("to do")
                case .sessionInvalidated(error: let error):
                    print("to do")
                case .sessionTaskFailed(error: let error):
                    print(error.localizedDescription)
                    print("dididi")
                    print("to do")
                case .urlRequestValidationFailed(reason: let reason):
                    print("to do")
                }
            } else if let error = error as? URLError {
                switch error.code {
                case .notConnectedToInternet:
                    print("No internet connection")
                default:
                    print("Unknown error")
                }
            } else {
                print("Unknown error: \(error)")
            }

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


