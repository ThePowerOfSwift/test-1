//
//  AppDelegate.swift
//  ProvaPulley
//
//  Created by Lorenzo Caso on 18/05/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import UserNotifications

import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var token: String?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
         FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        // Override point for customization after application launch.
        registerForPushNotifications()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
         self.saveContext()
    }

    //    login solo con facebook
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("E' ARRIVATO COCCOS:\(userInfo)")
        let dic = userInfo["aps"] as! [String: String]
       let stringJSON = dic["alert"]
        
        print(stringJSON!)
        let data = stringJSON?.data(using: .utf8)

        let decoder = JSONDecoder()
        do{
            
            switch (SingletonServer.singleton.questionSelezionata?.tipo) {
            case tipoChat.myquestions.hashValue:
                let answer = try decoder.decode(DBAnswerQ.self, from: data!)
                if(SingletonServer.singleton.user?.myQuestions![(SingletonServer.singleton.questionSelezionata?.index!)!].ID == answer.question?.ID){

                    SingletonServer.singleton.user?.myQuestions![(SingletonServer.singleton.questionSelezionata?.index!)!].answers?.append(answer)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadDataCollectionView"), object: nil)
                    }
            case tipoChat.myevents.hashValue:
                let answer = try decoder.decode(DBAnswerE.self, from: data!)
                if(SingletonServer.singleton.user?.myEvents![(SingletonServer.singleton.questionSelezionata?.indexReal!)!].id == answer.event?.id){
                    
                    SingletonServer.singleton.user?.myEvents![(SingletonServer.singleton.questionSelezionata?.indexReal!)!].answers?.append(answer)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadDataCollectionView"), object: nil)
                }
            case tipoChat.pulleyquestions.hashValue:
                 let answer = try decoder.decode(DBAnswerQ.self, from: data!)
                if(SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][(SingletonServer.singleton.questionSelezionata?.index!)!].ID == answer.question?.ID){
                    
                    SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][(SingletonServer.singleton.questionSelezionata?.index!)!].answers?.append(answer)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadDataCollectionView"), object: nil)
                }
            case tipoChat.pulleyevents.hashValue:
                 let answer = try decoder.decode(DBAnswerE.self, from: data!)
                if(SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][(SingletonServer.singleton.questionSelezionata?.indexReal!)!].id == answer.event?.id){
                    
                    SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][(SingletonServer.singleton.questionSelezionata?.index!)!].answers?.append(answer)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadDataCollectionView"), object: nil)
                }

            default:
                print("ciao")
            }

           }catch{
            print("errore di serializz s")
//
            }
      
        
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            // 1. Check if permission granted
            guard granted else { return }
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
//                UIApplication.shared.registerForRemoteNotifications()
                 self.getNotificationSettings()
            }
        }
    }
    
    
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
             DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 1. Convert device token to string
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        // 2. Print device token to use for PNs payloads
        print("Device Token: \(token)")
        self.token = token
    }
    
    
    func returnToken() -> String {
        if token == nil {
            token = "1"
        }
        return token!
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("Failed to register: \(error)")
    }
    
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Unicorner")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void){
        if response.actionIdentifier == "like" {
            print("Handle like action identifier")
        } else if response.actionIdentifier == "save" {
            print("Handle save action identifier")
        } else {
            print("No custom action identifiers chosen")
        }
        // Make sure completionHandler method is at the bottom of this func
        completionHandler()
    }
    
    

}


