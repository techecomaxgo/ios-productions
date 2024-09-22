//
//  Intro2VC.swift
//  MaxPay
//
//  Created by Ios Developer on 04/02/24.
//

import UIKit

class Intro2VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnActionSkip(_ sender: UIButton) {
        Common.shared.isIntroDone = true
        if Common.shared.isLoggedIn ?? false {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginMPIN") as! LoginMPIN
            self.navigationController?.pushViewController(vc,animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "RegistractionVC") as! RegistractionVC
            self.navigationController?.pushViewController(vc,animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

     @IBAction func btnActionSkip(_ sender: UIButton) {
     }
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
