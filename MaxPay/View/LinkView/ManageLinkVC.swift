//
//  ManageLinkVC.swift
//  MaxPay
//
//  Created by Admin on 24/06/24.
//

import UIKit
import FSPopoverView


class ManageLinkVC: UIViewController {

    
    @IBOutlet weak var stackMobHeight: NSLayoutConstraint!
    
    var stackMobHeightStr = ""
    
    
    @IBOutlet weak var viewOne: UIView!
    
    @IBOutlet weak var viewTwo: UIView!
    
    
    @IBOutlet weak var lblMobileOne: UILabel!
    
    @IBOutlet weak var lblMobilewo: UILabel!
    
    @IBOutlet weak var lblBankname: UILabel!
    
    @IBOutlet weak var lblBankAccount: UILabel!
    
    private let listView = FSPopoverListView()
    
    var UPIAddressRequest: UPIAddressRequest?
    var RegMapper: RegMapper?

    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        stackMobHeightStr = "1"
        
        if stackMobHeightStr == "1"{
            
            stackMobHeight.constant = 60
            viewOne.isHidden = false
            viewTwo.isHidden = true
            
        }else{
            
            stackMobHeight.constant = 120
            viewOne.isHidden = false
            viewOne.isHidden = false
            
        }
            
    }
    
    
    // getaddress
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        
        self.navigationController?.popViewController(animated: true)

        
    }
    
    
    
    @IBAction func btnMenuClicked(_ sender: UIButton) {
                
        let features: [UPIFeature] = [.deactive, .addPriv]
        let items: [FSPopoverListItem] = features.map { feature in
            let item = FSPopoverListTextItem()
            item.image = feature.image
            item.title = feature.title
            item.isSeparatorHidden = false
            item.selectedHandler = { item in
                guard let item = item as? FSPopoverListTextItem else {
                    return
                }
                print(item.title ?? "")
                
                if item.title ?? "" == "Deactivate mobile number"{
                    
                    self.deactiveTask()
                    
                } else if item.title ?? "" == "Add a private UPI number"{
                    
                    self.addPrivUpiTask()
                    
                }
                else{
                    
                    
                }
                
            }
            
            item.updateLayout()
            return item
        }
        items.last?.isSeparatorHidden = true
      
        listView.items = items
        listView.dismissWhenSelected = true
        listView.present(fromRect: sender.frame.insetBy(dx: 0.0, dy: -36.0), in: view)
        
    }
    
    func deactiveTask() {
        
        print("Deactivate mobile number func ")
    }
    
    func addPrivUpiTask() {
        
      //  print("Add a private UPI number Func")
        
             let storyBoard: UIStoryboard = UIStoryboard(name: "BhimUpi", bundle: nil)
             
             let vc = storyBoard.instantiateViewController(withIdentifier: "UPINumberVC") as! UPINumberVC
             
             self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func btnCopyONe(_ sender: UIButton) {
        
        self.view.makeToast("COPIED", duration: 1.0, position: .bottom)

    }
    
    
    @IBAction func btnCopyTwo(_ sender: UIButton) {
        
        self.view.makeToast("COPIED", duration: 1.0, position: .bottom)

        
    }
    
    @IBAction func btnChangeClicked(_ sender: UIButton) {
        
        
        
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
