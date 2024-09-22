//
//  CreateTransactVC.swift
//  MaxPay
//
//  Created by Ios Developer on 04/03/24.
//

import UIKit

class CreateTransactVC: UIViewController {
    
    var mandateTransactionObject: MandateTransactionModel?

    
    @IBOutlet weak var lblMandateVpa: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblFreq: UILabel!
    @IBOutlet weak var lblUMN: UILabel!
    @IBOutlet weak var lblValidity: UILabel!
    @IBOutlet weak var lblTransactionID: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    var statusStr = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lblMandateVpa.text = mandateTransactionObject?.payeeVpa ?? ""
        lblAmount.text = "₹ " + (mandateTransactionObject?.amount ?? "0")
        lblFreq.text = mandateTransactionObject?.recurrencePattern ?? ""
        lblUMN.text = mandateTransactionObject?.umn ?? ""
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        let yourDate = dateFormatter.date(from: mandateTransactionObject?.validity_end ?? "")

        // change to local time zone from your format
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = TimeZone.current
        let DateString = dateFormatter.string(from: yourDate!)
        print(DateString)
        
        
        lblValidity.text = DateString
        lblTransactionID.text = mandateTransactionObject?.txnid ?? ""
        
        statusStr =  mandateTransactionObject?.payeeStatus ?? ""
        
        if statusStr == "F"{
            
            lblStatus.text = "Failed"
            
        }else if statusStr == "S" {
            




















            lblStatus.text = "Active"
            
        }else if statusStr == "R" {
            
            lblStatus.text = "Revoke"
            
        }else if statusStr == "C" {
            
            lblStatus.text = "Completed"
            
        }else {

           // lblStatus.text = "Failed"
            
        }
        
       // lblStatus.text = (mandateTransactionObject?.payeeStatus ?? "") == "P" ? "Pending" : (mandateTransactionObject?.payeeStatus ?? "")
        
        
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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

