//
//  API.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/18/21.
//

import Foundation

protocol API {
    var scheme: String { get }
    var host: String { get }
    var endpoint: String { get }
}

extension API {
    
    func generateRequest<T: Encodable>(parameters: T, method: String) -> URLRequest? {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.endpoint
        
        var params =  try! DictionaryEncoder.encode(parameters)
        
        guard let appid = AppDelegate.AppConfig?.headers.appid else {return nil}
        params[Constants.KEY_APPID] = appid
        components.setQueryItems(with: params)
        var request = URLRequest(url: components.url!)
        request.httpMethod = method
        return request
    }
}



