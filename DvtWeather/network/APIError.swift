//
//  APIError.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/19/21.
//

import Foundation

//APIError enum which shows all possible errors
enum APIError: Error {
    case invalidData
    case jsonDecodingFailure
    case responseUnsuccessful(description: String)
    case decodingTaskFailure(description: String)
    case requestFailed(description: String)
    case jsonConversionFailure(description: String)
    case postParametersEncodingFalure(description: String)
    var customDescription: String {
        switch self {
        case .requestFailed(let description): return "\(Constants.KEY_API_ERROR) \(description)"
        case .invalidData: return "\(Constants.KEY_INVALID_DATA)"
        case .responseUnsuccessful(let description): return " \(Constants.KEY_RESPONSE_UNSUCCESSFUL) \(description)"
        case .jsonDecodingFailure: return "\(Constants.KEY_JSON_DECODING_ERROR)"
        case .jsonConversionFailure(let description): return "\(Constants.KEY_JSON_CONVERSION_ERROR) \(description)"
        case .decodingTaskFailure(let description): return " \(Constants.KEY_DECODING_TASK_ERROR) \(description)"
        case .postParametersEncodingFalure(let description): return " \(Constants.KEY_PARAMETER_ENCODING_ERROR) \(description)"
        }
    }
}

