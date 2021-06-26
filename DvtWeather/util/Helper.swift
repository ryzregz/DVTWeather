//
//  Helper.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/19/21.
//

import Foundation




struct DictionaryEncoder {
    static func encode<T>(_ value: T) throws -> [String: String] where T: Encodable {
        let jsonData = try JSONEncoder().encode(value)
        return try JSONSerialization.jsonObject(with: jsonData) as? [String: String] ?? [:]
    }
}

struct DecodingTask{
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    static func decode<T: Decodable>(with request: URLRequest, session : URLSession, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed(description: error?.localizedDescription ?? "\(Constants.KEY_REQUEST_FAILED) "))
                return
            }
            
            guard httpResponse.statusCode == 200  else {
                completion(nil, .responseUnsuccessful(description: "\(httpResponse.statusCode)"))
                return
            }
            
            guard let data = data else { completion(nil, .invalidData); return }
            
//            if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
//                print("Returned Data \(json)")
//            }
            
            do {
                let responsedata = try JSONDecoder().decode(decodingType, from: data)
                completion(responsedata, nil)
            } catch let err {
                print(err)
                completion(nil, .jsonConversionFailure(description: "\(err.localizedDescription)"))
            }
        }
        return task
    }
    
}

