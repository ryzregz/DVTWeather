//
//  CustomLoader.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/26/21.
//

import Foundation
import UIKit

class CustomLoader : NSObject{
    static let sharedInstance = CustomLoader()

      let indicator: UIActivityIndicatorView? = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

      let screen = UIScreen.main.bounds

      var appDelegate: SceneDelegate {
          guard let sceneDelegate = UIApplication.shared.connectedScenes
              .first!.delegate as? SceneDelegate else {
            fatalError(Constants.KEY_APP_DELEGATE_ERROR)
          }
          return sceneDelegate
      }
      
      var rootController:UIViewController? {
          guard let viewController = appDelegate.window?.rootViewController else {
            fatalError(Constants.KEY_ROOT_CONTROLLER_ERROR)
          }
          return viewController
      }
      
      func show() {
          indicator?.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
          indicator?.frame.origin.x = (screen.width/2 - 20)
          indicator?.frame.origin.y = (screen.height/2 - 20)
          rootController?.view.addSubview(indicator!)
          indicator?.startAnimating()
      }
      
      func hide() {
          DispatchQueue.main.async {
              self.indicator?.stopAnimating()
              self.indicator?.removeFromSuperview()
          }
      }
}
