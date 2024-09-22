//
//  RaiseComplainVC.swift
//  MaxPay
//
//  Created by Ios Developer on 13/05/24.
//

import UIKit

class RaiseComplainVC: UIViewController {
    
    
    @IBOutlet weak var btnBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)

        
    }
    
    
    @IBAction func btnRaiseClicked(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RaiseComplainDetailVC") as! RaiseComplainDetailVC
       // vc.tranHistoryObj = tranHistoryArr[indexPath.row]
       // vc.accountDetails = self.accountDetails
        self.navigationController?.pushViewController(vc, animated: true)
        
        
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
