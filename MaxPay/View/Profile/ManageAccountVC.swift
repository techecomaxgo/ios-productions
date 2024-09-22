//
//  ManageAccountVC.swift
//  MaxPay
//
//  Created by Ios Developer on 27/05/24.
//

import UIKit

class ManageAccountVC: UIViewController {
    
    @IBOutlet weak var btnRadio: UIImageView!
    
    @IBOutlet weak var btnBack: UIButton!
    
    var strTagForCardMenuSelection: String = ""

    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
          self.tabBarController?.tabBar.isHidden = true

  }
    
    
    @IBAction func btnBackClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false

    }
    
    
    @IBAction func btnPrimryClicked(_ sender: UIButton) {
        
        
        
        
    }
    
    
    @IBAction func btnChangeClicked(_ sender: UIButton) {
        
        
        
    }
    
    
    @IBAction func btnResetClicked(_ sender: UIButton) {
        
        
    }
    
    @IBAction func btnCheckBalanceClicked(_ sender: UIButton) {
        
        /*
            //print("btnCheckBalance")
            strTagForCardMenuSelection = "ChkBal"
            btnTagForCardMenuSelection = sender
            self.lblBalance = lblBalance
            
            DispatchQueue.main.async {
                SwiftLoader.show(animated: true)
            }
            
            let accountDetailsTemp = self.cardsArr[sender.tag]
            
            let accountDetails = AccountCheckBalance(name: accountDetailsTemp.name ?? "", mmid: accountDetailsTemp.mmid ?? "", aeba: accountDetailsTemp.aeba ?? "", mbeba: accountDetailsTemp.mbeba ?? "", accRefNumber: accountDetailsTemp.accRefNumber ?? "", ifsc: accountDetailsTemp.ifsc ?? "", maskedAccnumber: accountDetailsTemp.maskedAccnumber ?? "", status: accountDetailsTemp.status ?? "", type: accountDetailsTemp.type ?? "", vpa: accountDetailsTemp.vpa ?? "", dLength: accountDetailsTemp.dLength ?? "", dType: accountDetailsTemp.dType ?? "", balance: accountDetailsTemp.balance ?? "", balTime: accountDetailsTemp.balTime ?? "")
            
            var jsonObjectString = ""
            
            do {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
                let jsonData = try encoder.encode(accountDetails)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                    jsonObjectString = jsonString
                }
            } catch {
                print("Error encoding JSON: \(error)")
            }
            
            
            if accountDetailsTemp.vpa != "" {
                
                if accountDetailsTemp.status == "R" { // Account Not active
                   // call activate account function
                   DispatchQueue.main.async {
                       let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                       let vc = storyboard.instantiateViewController(withIdentifier: "UPISetUPIPinVC") as! UPISetUPIPinVC
                       vc.accountDetails = accountDetailsTemp
                       self.navigationController?.pushViewController(vc, animated: true)
                   }
                    
                } else {
                    
                    DispatchQueue.global(qos: .background).async {
                        
                        // Working Properly
                        OliveUpiManager.checkBalance(account: jsonObjectString, viewController: self) { data, error in
                            
                            if let err = error {
                                DispatchQueue.main.async {
                                    SwiftLoader.hide()
                                }
                                
                                if err.code == 102 { // VPA not allowed for this customer
                                    DispatchQueue.main.async {
                                        self.showErrorAlert(err.localizedDescription)
                                    }
                                } else if err.code == 401 || err.code == 107 {
                                    
                                    self.checksumConfiguration()
                                    
                                }
                                
                            } else {
                                
                                
                                let dataObject = data as! [String: Any]
                                
                                DispatchQueue.main.async {
                                    SwiftLoader.hide()
                                    //self.showErrorAlert("Account Balance: \(data as! String)")
                                    
                                    lblBalance.isHidden = false
                                    lblBalance.text = "₹\(dataObject["data"] as! String)"
                                    
                                }
                            }
                        }
                    }
                }
                
            } else {
                
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "UPILinkUpdateVC") as! UPILinkUpdateVC
                    vc.accountDetails = accountDetailsTemp
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        
        */
            
    }
    
    
    @IBAction func btnUpiInternational(_ sender: Any) {
        
        
    }
    
    
    @IBAction func btnDeleteClicked(_ sender: UIButton) {
        
        
        
    }
    
    
   
    /*
     
     func btnSetMpin(_ sender: UIButton) {
         
         print("btnSetMpin")
         
         strTagForCardMenuSelection = "SetChngMpin"
         btnTagForCardMenuSelection = sender
         
         DispatchQueue.main.async {
             SwiftLoader.show(animated: true)
         }

         let accountDetailsTemp = cardsArr[sender.tag]

         let accountDetails = AccountCheckBalance(name: accountDetailsTemp.name ?? "", mmid: accountDetailsTemp.mmid ?? "", aeba: accountDetailsTemp.aeba ?? "", mbeba: accountDetailsTemp.mbeba ?? "", accRefNumber: accountDetailsTemp.accRefNumber ?? "", ifsc: accountDetailsTemp.ifsc ?? "", maskedAccnumber: accountDetailsTemp.maskedAccnumber ?? "", status: accountDetailsTemp.status ?? "", type: accountDetailsTemp.type ?? "", vpa: accountDetailsTemp.vpa ?? "", dLength: accountDetailsTemp.dLength ?? "", dType: accountDetailsTemp.dType ?? "", balance: accountDetailsTemp.balance ?? "", balTime: accountDetailsTemp.balTime ?? "")

         var jsonObjectString = ""
         do {
             let encoder = JSONEncoder()
             encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
             let jsonData = try encoder.encode(accountDetails)
             if let jsonString = String(data: jsonData, encoding: .utf8) {
                 print(jsonString)
                 jsonObjectString = jsonString
             }
         } catch {
             print("Error encoding JSON: \(error)")
         }

         
         if accountDetailsTemp.status == "R" { // upi mpin not set / not active
             
             if accountDetailsTemp.vpa == "" {
                 DispatchQueue.main.async {
                     let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                     let vc = storyboard.instantiateViewController(withIdentifier: "UPILinkUpdateVC") as! UPILinkUpdateVC
                     vc.accountDetails = accountDetailsTemp
                     self.navigationController?.pushViewController(vc, animated: true)
                 }
                 
             } else {
                 DispatchQueue.main.async {
                     let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                     let vc = storyboard.instantiateViewController(withIdentifier: "UPISetUPIPinVC") as! UPISetUPIPinVC
                     vc.accountDetails = accountDetailsTemp
                     self.navigationController?.pushViewController(vc, animated: true)
                 }
             }
             
         } else if accountDetailsTemp.status == "A" { // Account active
             
             if accountDetailsTemp.vpa != "" {
                 DispatchQueue.main.async {
                     SwiftLoader.show(animated: true)
                 }
                 DispatchQueue.global(qos: .background).async {
                     
                     // Working Properly
                     OliveUpiManager.changeMpin(bankid: accountDetailsTemp.iin!, account: jsonObjectString, viewController: self) { data, error in
                         
                         
                         if let err = error {
                             
                             if err.code == 102 { // VPA not allowed for this customer
                                 DispatchQueue.main.async {
                                     self.showErrorAlert(err.localizedDescription)
                                 }
                             } else if err.code == 401 || err.code == 107 {
                                 
                                 self.checksumConfiguration()
                                 return
                             }
                             DispatchQueue.main.async {
                                 SwiftLoader.hide()
                             }
                                                         
                         } else {
                             
                             DispatchQueue.main.async {
                                 print(data ?? "")
                                 SwiftLoader.hide()
                                 self.showErrorAlert("MPIN Set Successfully")
                                 
                                 self.fetchMyAccounts()
                             }
                         }
                     }
                 }
             } else {
                 DispatchQueue.main.async {
                     let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                     let vc = storyboard.instantiateViewController(withIdentifier: "UPILinkUpdateVC") as! UPILinkUpdateVC
                     vc.accountDetails = accountDetailsTemp
                     self.navigationController?.pushViewController(vc, animated: true)
                 }
             }
             
         }
     }
     
     
     
     
     func btnDeleteAccount(_ sender: UIButton) {
         
         strTagForCardMenuSelection = "RmAcc"
         btnTagForCardMenuSelection = sender
         
         let accountDetailsTemp = cardsArr[sender.tag]
                 
         let accountDetails = AccountCheckBalance(name: accountDetailsTemp.name ?? "", mmid: accountDetailsTemp.mmid ?? "", aeba: accountDetailsTemp.aeba ?? "", mbeba: accountDetailsTemp.mbeba ?? "", accRefNumber: accountDetailsTemp.accRefNumber ?? "", ifsc: accountDetailsTemp.ifsc ?? "", maskedAccnumber: accountDetailsTemp.maskedAccnumber ?? "", status: accountDetailsTemp.status ?? "", type: accountDetailsTemp.type ?? "", vpa: accountDetailsTemp.vpa ?? "", dLength: accountDetailsTemp.dLength ?? "", dType: accountDetailsTemp.dType ?? "", balance: accountDetailsTemp.balance ?? "", balTime: accountDetailsTemp.balTime ?? "")

         var jsonObjectString = ""
         do {
             let encoder = JSONEncoder()
             encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
             let jsonData = try encoder.encode(accountDetails)
             if let jsonString = String(data: jsonData, encoding: .utf8) {
                 print(jsonString)
                 jsonObjectString = jsonString
             }
         } catch {
             print("Error encoding JSON: \(error)")
         }
         
         DispatchQueue.main.async {
             SwiftLoader.show(animated: true)
         }

         DispatchQueue.global(qos: .background).async {
             
             // Working Properly
             OliveUpiManager.accountRemove(account: jsonObjectString) { data, error in
                 
                 if let err = error {
                     DispatchQueue.main.async {
                         SwiftLoader.hide()
                     }
                     if err.code == 102 { // Customer Accounts not found
                         DispatchQueue.main.async {
                             self.showErrorAlert(err.localizedDescription)
                         }
                     } else if err.code == 401 || err.code == 107 {
                         
                         self.checksumConfiguration()
                         
                     }
                 } else {
                     
                     self.cardsArr = []
                     Common.shared.myCards = nil
                     
                     DispatchQueue.main.async {
                         SwiftLoader.hide()
                         self.collVWCard.reloadData()
                         self.showToast(message: "Account Removed", font: .systemFont(ofSize: 12))
                     }
                     
                 }
             }
         }
     }
     */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
