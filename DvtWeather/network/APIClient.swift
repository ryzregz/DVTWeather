//
//  APIClient.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/19/21.
//

import Foundation

/// Generic client to avoid rewrite URL session code
protocol APIClient{
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
}

extension APIClient {
    /// success respone executed on viewmodel.
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {

        let task = DecodingTask.decode(with: request, session: session, decodingType: T.self) { (json, error) in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    error != nil ? completion(.failure(.decodingTaskFailure(description: "\(String(describing: error))"))) : completion(.failure(.invalidData))
                    return
                }
                guard let value = decode(json) else { completion(.failure(.jsonDecodingFailure)); return }
                completion(.success(value))
            }
        }
        task.resume()
    }
    
}
