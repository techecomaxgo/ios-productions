//
//  RechargeBillPendingVC.swift
//  MaxPay
//
//  Created by Ios Developer on 22/05/24.
//

import UIKit

class RechargeBillPendingVC: UIViewController {

    @IBOutlet weak var lblAmount: UILabel!

    @IBOutlet weak var viewBannerBack: UIView!
    
    @IBOutlet weak var lblBillersName: UILabel!
    
    @IBOutlet weak var lblrecieverName: UILabel!
    
    @IBOutlet weak var lblConsumerName: UILabel!
    
    
    @IBOutlet weak var btnRaiseComplaint: UIButton!
    
    
    @IBOutlet weak var btnNeedHelp: UIButton!
    
    var consumerName = ""
    
    var receiverName = ""
    
    var amountStr = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lblAmount.text = "₹\(amountStr)"
        
        lblBillersName.text = Common.shared.userMobile_NUMBER ?? ""
        
        lblrecieverName.text = receiverName
        
        lblConsumerName.text = consumerName
        
        
        viewBannerBack.layer.applyCornerRadiusShadow()
        
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        
        if let viewControllers = navigationController?.viewControllers {
                   for viewController in viewControllers {
                       if let viewControllerA = viewController as? RechargeViewController {
                           navigationController?.popToViewController(viewControllerA, animated: true)
                           break
                       }
                   }
               }
        
    }
    
    
    @IBAction func btnRaiseComplaintClicked(_ sender: UIButton) {
        
        
        
    }
    
    
    
    @IBAction func btnNeedHelpClicked(_ sender: UIButton) {
        
        
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
