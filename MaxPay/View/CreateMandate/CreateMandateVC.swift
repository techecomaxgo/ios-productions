//
//  CreateMandateVC.swift
//  MaxPay
//
//  Created by india on 14/11/23.
//

import UIKit
import DropDown

class CreateMandateVC: UIViewController {

    @IBOutlet weak var lblMandateDuration: UILabel!
    @IBOutlet weak var btnMandateDuration: UIButton!
    @IBOutlet weak var btnCreateMandate: UIButton!
    
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        btnCreateMandate.layer.applyCornerRadiusShadow()
        dropDown.anchorView = view // UIView or UIBarButtonItem
        dropDown.dataSource = ["ONE TIME"]
        dropDown.bottomOffset = CGPoint(x: btnMandateDuration.frame.origin.x + 20, y:btnMandateDuration.frame.origin.y + btnMandateDuration.frame.height + 110)
        
    }

    @IBAction func btnCreateMandateAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MandateSuccessVC") as! MandateSuccessVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnMandateDurationAction(_ sender: Any) {
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self?.lblMandateDuration.text = "\(item)"
            self?.dropDown.hide()
        }
        dropDown.width = btnMandateDuration.frame.width - 40
    }
    
}
