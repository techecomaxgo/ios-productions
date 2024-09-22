//
//  ClaimPopUpVC.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 25/05/24.
//

import UIKit

class ClaimPopUpVC: UIViewController {
    
    @IBOutlet var btnClaim: UIButton!
    @IBOutlet weak var tvDescription: TextViewWithPlaceholder!
    
    var parentVC:ItemDetailsVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tittle2 = NSAttributedString(string: "Claim Now", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: KThemeTextDark2) ?? .gray, NSAttributedString.Key.font:UIFont(name: "Roboto-Medium", size: 16.0)!])
        btnClaim.setAttributedTitle(tittle2, for: .normal)
    }
    
    @IBAction func btnClaimClicked(_ sender: UIButton) {
        if tvDescription.text.count>0{
            parentVC?.claimItem(desc: self.tvDescription.text)
        }else{
            self.displayAlert(message: "Please enter description")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
