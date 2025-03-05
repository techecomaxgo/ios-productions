//
//  PlanViewPopupVC.swift
//  MaxPay
//
//  Created by Ios Developer on 18/05/24.
//

import UIKit

class PlanViewPopupVC: UIViewController {

    
    @IBOutlet weak var tableViewPlans: UITableView!
    
    
    @IBOutlet var bgView_ctrl: UIView!
    
    @IBOutlet weak var popView_Ctrl: UIView!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblValidity: UILabel!
    
    @IBOutlet weak var lblDataDay: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblOffersHeadLine: UILabel!
    
    
    var selectedPopStr = ""

    var priceStr = ""
    var validityStr = ""
    var descriptionStr = ""
    var dataDayStr = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //lblOffersHeadLine.text = "No Offers available "
        
        self.bgView_ctrl.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        popView_Ctrl.layer.cornerRadius = 25
        popView_Ctrl.layer.borderWidth = 1.0
        popView_Ctrl.layer.borderColor = UIColor.white.cgColor
        popView_Ctrl.clipsToBounds = true
        
//        print(priceStr)
//        print(validityStr)
//        print(descriptionStr)
        
        lblPrice.text = priceStr
        lblValidity.text = validityStr
        lblDescription.text = descriptionStr
        lblDataDay.text = dataDayStr
        
        // Add tap gesture recognizer to the background view
             let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
        bgView_ctrl.addGestureRecognizer(tapGestureRecognizer)
                     
    }
    
    @objc func dismissPopup() {
            // Dismiss the popup and background view
           removeAnimate()
        }
    
    
    
    
    
    @IBAction func btnProceedPay(_ sender: UIButton) {
        
        
        removeAnimate()
        
        //RechargePaymentVC
        
        let vc = UIStoryboard(name: "USP", bundle: nil).instantiateViewController(withIdentifier: "RechargePaymentVC") as! RechargePaymentVC
        
        vc.pricePStr = Int(priceStr) ?? 0
        vc.dataDayPStr = dataDayStr
        vc.validityPStr = validityStr
        vc.descriptionPStr = descriptionStr
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    
    func showAnimate()
        
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations:
            {
                self.view.alpha = 1.0
                self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
        
    {
        UIView.animate(withDuration: 0.0, animations:
            {
                self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
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
