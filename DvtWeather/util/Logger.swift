//
//  Logger.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/18/21.
//

import Foundation
import UIKit
class Logger{
    
    static func Log(from obj:AnyObject, with :String){
        print("\(String(describing: type(of: obj))) |:> \(with)")
    }
    
    
}
