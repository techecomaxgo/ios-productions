//
//  CustomTabBarController.swift
//  TabNewDesign
//
//  Created by Admin on 25/06/24.
//



import UIKit
import SwiftLoader
import OlivePayLibrary


class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var tabaccountDetails: AccountDetailsOnIIN?
  
    var primaryAccount: AccountDetailsOnIIN?

    private var cardsArr:[AccountDetailsOnIIN] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let appTabBar = AppTabBar()
        self.setValue(appTabBar, forKey: "tabBar")
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: .accountNotification, object: nil)

        // Create instances of view controllers
        //let homeVC = HomeVC()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
       
        let homeVC = storyBoard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
       homeVC.view.backgroundColor = .white
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "tab-home-ic"), selectedImage: UIImage(named: "homeIcon"))
        //homeVC.tabBarItem.badgeColor = UIColor(hexString: "000000")
        
        let nav1 = UINavigationController(rootViewController: homeVC)


        //let expenseVC = MyExpenseVC()
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "BhimUPIHistoryVC") as! BhimUPIHistoryVC
//        vc.accountDetails = accountDetails
//        self.navigationController?.pushViewController(vc, animated: true)
        let expenseVC = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "BhimUPIHistoryVC") as! BhimUPIHistoryVC
        expenseVC.accountDetails = self.primaryAccount
//        self.present(vc, animated: true)//navigationController?.pushViewController(vc, animated: true)
        
//        let expenseVC = storyBoard.instantiateViewController(withIdentifier: "TrasactionVC") as! TrasactionVC

        expenseVC.view.backgroundColor = .white
        expenseVC.tabBarItem = UITabBarItem(title: "History", image: UIImage(named: "tab-myexpense-ic"), selectedImage: UIImage(named: "expenseIcon"))
        let nav2 = UINavigationController(rootViewController: expenseVC)

        //MB - test for  scan QR call
        let qrVC = storyBoard.instantiateViewController(withIdentifier: "ScanQRVC") as! ScanQRVC

        qrVC.view.backgroundColor = .white
        qrVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: ""), selectedImage: UIImage(named: ""))
        
        let nav3 = UINavigationController(rootViewController: qrVC)
        
        

        let quizVC = storyBoard.instantiateViewController(withIdentifier: "QuizVC") as! QuizVC

        quizVC.view.backgroundColor = .white
        quizVC.tabBarItem = UITabBarItem(title: "Quiz", image: UIImage(named: "tab-quiz-ic"), selectedImage: UIImage(named: "quizIcon"))
        
        let nav4 = UINavigationController(rootViewController: quizVC)


       // let profileVC = ProfileVC()
        let profileVC = storyBoard.instantiateViewController(withIdentifier: "UserProfileView") as! UserProfileView

        profileVC.view.backgroundColor = .white
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "tab-profile-ic"), selectedImage: UIImage(named: "profileIcon"))
        
        let nav5 = UINavigationController(rootViewController: profileVC)


        // Add view controllers to the tab bar
        viewControllers = [nav1, nav2,nav3, nav4,nav5]

        // Customize the tab bar appearance
        tabBar.tintColor = UIColor(hexString: "637F13")//.systemGreen
        tabBar.unselectedItemTintColor = .black

        // Adjust the middle button (if needed)
        if let items = tabBar.items {
            items[2].title = ""
            items[2].imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
                
        
    }
    
    
    
    @objc func handleNotification(_ notification: Notification) {
       
        if let userInfo = notification.userInfo, let data = userInfo["accountDetails"] as? Data {
            do {
                let decoder = JSONDecoder()
                let accountDetails = try decoder.decode(AccountDetailsOnIIN.self, from: data)
                print("Received account details: \(accountDetails)")
                self.primaryAccount = accountDetails
                
                print("Received account details:",self.primaryAccount)

                
            } catch {
                print("Failed to decode account details: \(error)")
            }
        }
    }

    
    
    
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        let middleButton = UIButton(frame: CGRect(x: (view.bounds.width / 2) - 35, y: -20, width: 70, height: 70))
       // middleButton.backgroundColor = .systemGreen
        middleButton.layer.cornerRadius = 35
        middleButton.setImage(UIImage(named: "tabQrscan"), for: .normal)
        middleButton.addTarget(self, action:#selector(self.qrScanClicked), for: .touchUpInside)

        tabBar.addSubview(middleButton)
        tabBar.bringSubviewToFront(middleButton)
        
    }
     
    
    
    @objc func qrScanClicked() {
        
                  
//                VC.isFromtabBar = true
//                let navigationController = UINavigationController(rootViewController: VC)
//                navigationController.isNavigationBarHidden = true
//                self.view.window?.rootViewController = navigationController
            
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ScanQRVC") as! ScanQRVC
        
        
            vc.accountDetails = self.primaryAccount
            vc.isFromtabBar = true
        
        

        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen

        self.present(navController, animated: true, completion: nil)
        
        
        //self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
