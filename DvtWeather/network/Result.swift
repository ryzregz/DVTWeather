//
//  Result.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/19/21.
//

import Foundation

//Result enum to show success or failure
enum Result<T, U> where U : Error {
    case success(T)
    case failure(U)
}
