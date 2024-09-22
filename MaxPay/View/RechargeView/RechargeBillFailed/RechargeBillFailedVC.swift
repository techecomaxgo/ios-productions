//
//  RechargeBillFailedVC.swift
//  MaxPay
//
//  Created by Ios Developer on 22/05/24.
//

import UIKit

class RechargeBillFailedVC: UIViewController {
    
    
    @IBOutlet weak var lblAmount: UILabel!
    
    var amountStr = ""
    
    
    @IBOutlet weak var lblBillersName: UILabel!
    
    @IBOutlet weak var lblrecieverName: UILabel!
    
    @IBOutlet weak var lblConsumerName: UILabel!

    @IBOutlet weak var btnnTryAgain: DesignableButton!
    
    
    var consumerName = ""
    
    var receiverName = ""
    
    
    @IBOutlet weak var lblPaidThrough: UILabel!
    
    
    @IBOutlet weak var viewBackBanner: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewBackBanner.layer.applyCornerRadiusShadow()
        
        lblAmount.text = "₹\(amountStr)"
        
        lblBillersName.text = Common.shared.userMobile_NUMBER ?? ""
        
        lblrecieverName.text = receiverName
        
        lblConsumerName.text = consumerName
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        
      //  RechargeViewController
        
        if let viewControllers = navigationController?.viewControllers {
                   for viewController in viewControllers {
                       if let viewControllerA = viewController as? RechargeViewController {
                           navigationController?.popToViewController(viewControllerA, animated: true)
                           break
                       }
                   }
               }
        
        
        
    }
    
    
    @IBAction func btnTryAgainClicked(_ sender: UIButton) {
        
        if let viewControllers = navigationController?.viewControllers {
                   for viewController in viewControllers {
                       if let viewControllerA = viewController as? RechargeViewController {
                           navigationController?.popToViewController(viewControllerA, animated: true)
                           break
                       }
                   }
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
