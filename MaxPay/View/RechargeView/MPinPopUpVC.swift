//
//  MPinPopUpVC.swift
//  MaxPay
//
//  Created by Admin on 25/02/25.
//

import UIKit

class MPinPopUpVC: UIViewController {

    @IBOutlet weak var labelDescription: UILabel!
    var desTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        labelDescription.text = desTitle

    }
    @IBAction func btnOkTap(_ sender: Any) {
        dismiss(animated: true) {
            let storyboard = UIStoryboard(name: "USP", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "RechargeBillPaymentMethodVC") as! RechargeBillPaymentMethodVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
