//
//  AppDelegate.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/18/21.
//

import UIKit
import CoreData
import GooglePlaces
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var config:Config?
    let TAG = "AppDelegateScene"
    //
    static var AppConfig:Config?{
        get{
            return config
        }
        set{
            config = newValue
        }
    }
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        do {
            //
            if let url = Bundle.main.url(forResource: Constants.KEY_CONFIG_FILE, withExtension: Constants.KEY_PLIST_FILE) {
                //
                let data = try Data(contentsOf: url)
                //
                AppDelegate.config = try PropertyListDecoder().decode(Config.self, from: data)
                GMSPlacesClient.provideAPIKey(AppDelegate.AppConfig!.google_api_key)
            }
        }catch{
            print(error)
            Logger.Log(from:self,with:"\(TAG): \(Constants.KEY_CONFIG_READ_ERROR) \(error)")
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
}

