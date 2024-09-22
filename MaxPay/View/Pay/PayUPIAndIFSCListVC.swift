//
//  PayUPIAndIFSCListVC.swift
//  MaxPay
//
//  Created by india on 13/11/23.
//

import UIKit

class PayUPIAndIFSCListVC: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
   
    var accountDetails: AccountDetailsOnIIN?
    @IBOutlet weak var btnUPI: UIButton!
    @IBOutlet weak var btnIFSC: UIButton!
    @IBOutlet weak var lblUPIAndIFSC: UILabel!
    @IBOutlet weak var vwLineIFSC: UIView!
    @IBOutlet weak var vwLineUPI: UIView!
    
    var filteredData: [String]!
    var bolIsUPI = true
    var bolIsPay:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        vwLineIFSC.isHidden = true
        vwLineUPI.isHidden = false
        vwLineIFSC.backgroundColor = UIColor(hexString: "808080")
        vwLineUPI.backgroundColor = UIColor(hexString: "9FC438")
        btnIFSC.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        bolIsUPI = true
        
    }
    @IBAction func btnUPIAction(_ sender: Any) {
        lblUPIAndIFSC.text = "New UPI Id"
        vwLineIFSC.isHidden = true
        vwLineUPI.isHidden = false
        vwLineUPI.backgroundColor = UIColor(hexString: "9FC438")
        vwLineIFSC.backgroundColor = UIColor(hexString: "808080")
        btnIFSC.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        btnUPI.setTitleColor(UIColor(hexString: "9FC438"), for: .normal)
        bolIsUPI = true
        
    }
    @IBAction func btnIFSCAction(_ sender: Any) {
        lblUPIAndIFSC.text = "New IFSC"
        vwLineIFSC.isHidden = false
        vwLineUPI.isHidden = true
        vwLineIFSC.backgroundColor = UIColor(hexString: "9FC438")
        vwLineUPI.backgroundColor = UIColor(hexString: "808080")
        btnIFSC.setTitleColor(UIColor(hexString: "9FC438"), for: .normal)
        btnUPI.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        bolIsUPI = false
    }
    @IBAction func btnAddUPIAndIFSCAction(_ sender: Any) {
        if bolIsUPI == true {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "UPIVerifyVC") as! UPIVerifyVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PaymentUPIIDRequestVC") as! PaymentUPIIDRequestVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UPIAndIFSCCell", for: indexPath) as! UPIAndIFSCCell
        if bolIsPay ?? false {
//            cell.btnDelete.isHidden = true
        }else{
//            cell.btnDelete.isHidden = false
        }
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}
