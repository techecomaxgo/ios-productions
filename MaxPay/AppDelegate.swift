//
//  AppDelegate.swift
//  MaxPay
//
//  Created by india on 06/11/23.
//

import UIKit
import CoreData
import IQKeyboardManager
import FirebaseCore
import FirebaseMessaging



@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var refidStr = ""
    var window: UIWindow?
    var storyMain: UIStoryboard?
    let gcmMessageIDKey = "gcm.message_id"
    
    var NavigationController:UINavigationController?
    
    var titleStr = ""
    
    var primaryAccount: AccountDetailsOnIIN?
    private var cardsArr:[AccountDetailsOnIIN] = []
    
    let referenceUITabBarController = HHTabBarView.shared.referenceUITabBarController

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared().isEnabled = true
        
        FirebaseApp.configure()
        
        
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
        
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                //                self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
            }
        }
        
        
        
        cardsArr = []
        
        if let decoded = Common.shared.myCards {
            do {
                let cardList: [AccountDetailsOnIIN] = try JSONDecoder().decode([AccountDetailsOnIIN].self, from: decoded)
                
                for card in cardList {
                    cardsArr.append(card)
                }
                
                print("cardsArr :", cardsArr)
                
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
       
        
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
                       components.scheme == "upi",
                       components.host == "pay" else {
                     return false
                 }
     
                 var parameters: [String: String] = [:]
                 components.queryItems?.forEach { item in
                     print(item)
                     parameters[item.name] = item.value
                 }
                
                
        if url.scheme == "upi" {
            handleUPILink(url)
            return true
        }
        return false
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//           
//        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
//                  components.scheme == "upi",
//                  components.host == "pay" else {
//                return false
//            }
//
//            var parameters: [String: String] = [:]
//            components.queryItems?.forEach { item in
//                parameters[item.name] = item.value
//            }
//
//            if let paymentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaymentView") as? PaymentView {
//                paymentViewController.parameters = parameters
//                if let navigationController = window?.rootViewController as? UINavigationController {
//                    navigationController.pushViewController(paymentViewController, animated: true)
//                }
//            }
//
//            return true
//        }
//    }
    
    
    func handleUPILink(_ url: URL) {
        
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        
        var parameters = [String: String]()
        components.queryItems?.forEach { item in
            parameters[item.name] = item.value
        }
        
//        if let paymentAmount = parameters["am"],
//           let orderID = parameters["tr"] {
//            
//            // Assuming you have a way to access the main storyboard and navigate
//            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//           
//            if let paymentViewController = storyboard.instantiateViewController(withIdentifier: "PaymentView") as? PaymentView {
//                
//                paymentViewController.amount = paymentAmount
//                paymentViewController.orderID = orderID
//                
//                if let navigationController = window?.rootViewController as? UINavigationController {
//                    navigationController.pushViewController(paymentViewController, animated: true)
//                } else {
//                    window?.rootViewController = UINavigationController(rootViewController: paymentViewController)
//                    window?.makeKeyAndVisible()
//                }
//            }
//            
//        }
        
        
    }
    

        
    
    // MARK: - NAVIGATION
    internal func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController? {
        
        if (rootViewController == nil) { return nil }
        
        if (rootViewController.isKind(of: (UITabBarController).self)) {
            
            
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UITabBarController).selectedViewController)
            
        } else if (rootViewController.isKind(of:(UINavigationController).self)) {
            
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UINavigationController).visibleViewController)
            
        } else if (rootViewController.presentedViewController != nil) {
            return topViewControllerWithRootViewController(rootViewController: rootViewController.presentedViewController)
        }
        return rootViewController
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        guard let rootViewController = window?.rootViewController else {
            return
        }
        
        if let selectBankVC = getSelectBankVC(from: rootViewController) {
            
            if let navigationController = selectBankVC.navigationController {
                NotificationCenter.default.post(name: Notification.Name("NotificationPoptoDashboard"), object: nil)
            }
        }
        
        else if let selectedBankAccountVC = getSelectedBankAccountVC(from: rootViewController) {
            if let navigationController = selectedBankAccountVC.navigationController {
                NotificationCenter.default.post(name: Notification.Name("NotificationPoptoDashboard1"), object: nil)
            }
        }
        
        else if let upiLinkUpdateVC = getUPILinkUpdateVC(from: rootViewController) {
            if let navigationController = upiLinkUpdateVC.navigationController {
                NotificationCenter.default.post(name: Notification.Name("NotificationPoptoDashboard2"), object: nil)
            }
        }
        
        else if let upiSetUPIPinVC = getUPISetUPIPinVC(from: rootViewController) {
            if let navigationController = upiSetUPIPinVC.navigationController {
                NotificationCenter.default.post(name: Notification.Name("NotificationPoptoDashboard3"), object: nil)
            }
        }
        
    }
    
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        print("applicationWillEnterForeground")
        
        fetchAppInfoData()

        
    }
    
    
    func fetchAppInfoData() {
            // Example function to fetch app info data
            // You can customize this function to retrieve the specific data you need
            
            // For example, retrieving user defaults
            if let userInfo = UserDefaults.standard.object(forKey: "UserInfo") as? [String: Any] {
              
                print("User info: \(userInfo)")
            }
            
            // Or performing a network request to update data
            // performNetworkRequestToUpdateData()
        }

    
    

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MaxPay")
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
    
    
    // MARK: - Push Notification
    
    func application(_ application: UIApplication,
                       didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)

        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
          print("Message ID: \(messageID)")
        }

        // Print full message.
        print(userInfo)
      }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        
        // With swizzling disabled you must set the APNs token here.
         Messaging.messaging().apnsToken = deviceToken
    }
    
    // Recursive function to find SelectBankVC in the view controller hierarchy
    func getSelectBankVC(from viewController: UIViewController) -> SelectBankVC? {
        if let selectBankVC = viewController as? SelectBankVC {
            return selectBankVC
        }
        
        // Check child view controllers if present
        for childViewController in viewController.children {
            if let selectBankVC = getSelectBankVC(from: childViewController) {
                return selectBankVC
            }
        }
        
        // Check presented view controller if any
        if let presentedViewController = viewController.presentedViewController {
            if let selectBankVC = getSelectBankVC(from: presentedViewController) {
                return selectBankVC
            }
        }
        
        return nil
    }
    
    func getSelectedBankAccountVC(from viewController: UIViewController) -> SelectedBankAccountVC? {
        if let selectedBankAccountVC = viewController as? SelectedBankAccountVC {
            return selectedBankAccountVC
        }
        
        // Check child view controllers if present
        for childViewController in viewController.children {
            if let selectedBankAccountVC = getSelectedBankAccountVC(from: childViewController) {
                return selectedBankAccountVC
            }
        }
        
        // Check presented view controller if any
        if let presentedViewController = viewController.presentedViewController {
            if let selectedBankAccountVC = getSelectedBankAccountVC(from: presentedViewController) {
                return selectedBankAccountVC
            }
        }
        
        return nil
    }
    
    func getUPILinkUpdateVC(from viewController: UIViewController) -> UPILinkUpdateVC? {
        if let upiLinkUpdateVC = viewController as? UPILinkUpdateVC {
            return upiLinkUpdateVC
        }
        
        // Check child view controllers if present
        for childViewController in viewController.children {
            if let upiLinkUpdateVC = getUPILinkUpdateVC(from: childViewController) {
                return upiLinkUpdateVC
            }
        }
        
        // Check presented view controller if any
        if let presentedViewController = viewController.presentedViewController {
            if let upiLinkUpdateVC = getUPILinkUpdateVC(from: presentedViewController) {
                return upiLinkUpdateVC
            }
        }
        
        return nil
    }

    func getUPISetUPIPinVC(from viewController: UIViewController) -> UPISetUPIPinVC? {
            if let upiSetUPIPinVC = viewController as? UPISetUPIPinVC {
                return upiSetUPIPinVC
            }
            
            // Check child view controllers if present
            for childViewController in viewController.children {
                if let upiSetUPIPinVC = getUPISetUPIPinVC(from: childViewController) {
                    return upiSetUPIPinVC
                }
            }
            
            // Check presented view controller if any
            if let presentedViewController = viewController.presentedViewController {
                if let upiSetUPIPinVC = getUPISetUPIPinVC(from: presentedViewController) {
                    return upiSetUPIPinVC
                }
            }
            
            return nil
        }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    
      func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  willPresent notification: UNNotification) async
    -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // [START_EXCLUDE]
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {


            print("Message ID: \(messageID)")
        }
        // [END_EXCLUDE]
        
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        return [[.alert, .sound]]
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
        
        // [START_EXCLUDE]
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // [END_EXCLUDE]
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print full message.
        print(userInfo)
        
        if cardsArr.count <= 0 {
            
            
            //return
            
            
        } else {
            for card in cardsArr {
                
                if card.maskedAccnumber == Common.shared.primaryAccNo {
                    
                    primaryAccount = card
                    
                    break
                }else{
                    primaryAccount = card
                    
                }
            }
        }
        
        
       // let userInfo = response.notification.request.content.userInfo
        
        // Extracting refid from userInfo
        if let refid = userInfo[AnyHashable("refid")] as? String {
            
            print("Received refid: \(refid)")
            // Use the refid as needed in your application
            refidStr = "\(refid)"
            
        } else {
            
            print("refid not found in notification")
            
        }

        
        
        
        
        if let aps = userInfo["aps"] as? [String: Any],
           let alert = aps["alert"] as? [String: Any],
           let title = alert["title"] as? String {
            print("Notification title: \(title)")
            
            titleStr = title
            
            
            if titleStr.contains("Collect") {
                
                print("The word '\("Collect")' was found in the string.")
                
                // Ensure the root view controller is a UINavigationController
                if let navigationController = window?.rootViewController as? UINavigationController {
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "BhimUpi", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "RequestLandingVC") as! RequestLandingVC
                    vc.accountDetails = primaryAccount
                    vc.isComefromNotifiction = "Yes"
                    vc.refidSt = refidStr
                    navigationController.pushViewController(vc, animated: true)
                    
                } else {

                    print("Root view controller is not a UINavigationController.")
                    
                }
                
            } 
            
            else if titleStr.contains("Mandate") {
                
                print("The word '\("Collect")' was found in the string.")
                
                // Ensure the root view controller is a UINavigationController
                
                if let navigationController = window?.rootViewController as? UINavigationController {
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "MandateListVC") as! MandateListVC
                    navigationController.pushViewController(vc, animated: true)
                    
                } else {
                    
                    print("Root view controller is not a UINavigationController.")
                    
                }

                
                
            }
           
            else if titleStr.contains("Payment") {
                
                print("The word '\("Collect")' was found in the string.")
                
                // Ensure the root view controller is a UINavigationController
                if let navigationController = window?.rootViewController as? UINavigationController {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "BhimUpi", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "BhimUPIHistoryVC") as! BhimUPIHistoryVC

                    navigationController.pushViewController(vc, animated: true)
                } else {
                    print("Root view controller is not a UINavigationController.")
                }

                
                
            }
            
            else {
                
                print("The word '\("")' was not found in the string.")
                
            }
            
            
            
            
        } else {
            print("Title not found in notification")
        }
        
        
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        Common.shared.fcmToken = fcmToken ?? ""
        
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

}

extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
