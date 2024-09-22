//
//  splashScreenVC.swift
//  MaxPay
//
//  Created by india on 14/11/23.
//

import UIKit

class splashScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(0, forKey: "selectIndex")
        
        
        if Common.shared.isIntroDone == false || Common.shared.isIntroDone == nil {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Intro1VC") as! Intro1VC
            self.navigationController?.pushViewController(vc,animated: true)
            
        } else if Common.shared.isLoggedIn ?? false {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginMPIN") as! LoginMPIN
            self.navigationController?.pushViewController(vc,animated: true)
            
        } else {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "RegistractionVC") as! RegistractionVC
            self.navigationController?.pushViewController(vc,animated: true)
        }
        
    }

}
