//
//  Extensions.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/19/21.
//

import Foundation
import UIKit
import CoreLocation
var showAlert: UIAlertController?
extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}


extension String {
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.KEY_DEFAULT_DATEFORMATTER
        return dateFormatter.date(from: self) // replace Date String
    }
    
  
}

extension Double {
    
    func convertToTemparature() -> String{
        let mf = MeasurementFormatter()
        let temp = Measurement(value: self, unit: UnitTemperature.celsius)
        mf.locale = Locale(identifier: Constants.KEY_LOCALE)
        return mf.string(from: temp)
    }
    
}

extension Date {
    func dateConverter() -> String {
        let dateFormarter = DateFormatter()
        dateFormarter.dateFormat = Constants.KEY_DAY_DATEFORMATTER
        return dateFormarter.string(from: self)
    }
}

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func showSuccessAlert(withTitle title: String, message:String, completion:@escaping (_ result:Bool) -> Void) {
        let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: Colors.colorMainBlue])
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertController.Style.alert)
         alert.setValue(attributedString, forKey: "attributedTitle")
        alert.view.tintColor = Colors.colorMainBlue
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            completion(true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithOption(withTitle title: String,optionName: String, message:String, completion:@escaping (_ result:Bool, _ option : Bool) -> Void) {
           let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: Colors.colorMainBlue])
           let alert = UIAlertController(title: title, message: message,
                                         preferredStyle: UIAlertController.Style.alert)
            alert.setValue(attributedString, forKey: "attributedTitle")
           alert.view.tintColor = Colors.colorMainBlue
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
               completion(true,false)
           }))
        
        alert.addAction(UIAlertAction(title: optionName, style: .default, handler: { action in
                      completion(false,true)
        }))
           self.present(alert, animated: true, completion: nil)
       }
    
    func showErrorAlert(withTitle title: String, message:String, completion:@escaping (_ result:Bool) -> Void) {
         let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.red])
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertController.Style.alert)
         alert.setValue(attributedString, forKey: "attributedTitle")
        alert.view.tintColor = .red
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            completion(true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithFadingOutMessage(_ msg: String, completion: (() -> Void)? = nil){
        showAlert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        self.present(showAlert!, animated: true, completion: completion)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(UIViewController.dismissLoadingMessageAlert), userInfo: nil, repeats: false)
    }
    
    @objc func dismissLoadingMessageAlert() {
           self.dismissMessageAlert(nil)
       }
    
    func dismissMessageAlert(_ completion: (() -> Void)? = nil) {
          self.dismiss(animated: true, completion: { () -> Void in
              showAlert = nil
              completion?()
              // print("completion value: \(String(describing: completion))")
          })
      }
    
    @objc(textField:shouldChangeCharactersInRange:replacementString:) func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
               return true;
    }



}

extension CLLocation {
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}
