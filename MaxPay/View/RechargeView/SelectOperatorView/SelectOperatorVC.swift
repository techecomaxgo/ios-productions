//
//  SelectOperatorVC.swift
//  MaxPay
//
//  Created by Ios Developer on 19/05/24.
//

protocol selectOperatorProtocol {
    
    func selectedOperatorInfo(operatorName:String,serviceType:String)
    
    
    
}


import UIKit
import SwiftLoader


class SelectOperatorVC: BaseVC {
    
    var operatorSelectDelegate : selectOperatorProtocol?
    
    @IBOutlet weak var btnBack: UIButton!
    
    private var operatorVM =  OperatorViewModel()

    var operatorResData : [Operator_Data]? = []


    @IBOutlet weak var tableViewOp: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            
            operatorVM.OperatorBaseCall(skeyStr: "AVJQIdwn79iR0zlP0iKNKumME")

            observeOperatorApi()
            
        }else{
            
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internetconnection.")
            
        }
    }
    
    
    
    //MARK: Observing the data
    func observeOperatorApi() {
        
        operatorVM.eventHandler = { [weak self] event in
            guard self != nil else { return }

            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                SwiftLoader.hide()
            case .dataLoaded:
                
                print("Data loaded...")
                DispatchQueue.main.async {
                                        
                   // print((self?.rechargeAllPlanVM.rechargeAllModel?.data?.plans)!)
                    
                    SwiftLoader.hide()
                    
                    if self?.operatorVM.OperatorBaseModel?.status == "success" {
                        
                        self?.operatorResData = self?.operatorVM.OperatorBaseModel?.responseData
                        
                        DispatchQueue.main.async {
                            self?.tableViewOp.reloadData()
                            SwiftLoader.hide()
                        }
                        
                    }else{
                        
                        self?.showErrorAlert(self?.operatorVM.OperatorBaseModel?.status ?? "")

                        
                    }
                    
                    
                    
                        
      
                    
                    
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
        
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



extension SelectOperatorVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operatorResData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OperatorTVC") as! OperatorTVC
        
        cell.setOperatorCellData(operatorCellData: operatorResData?[indexPath.row])
        
//        let contact = operatorResData?[indexPath.row]
//        
//        cell.lblName.text = contact.contactName
//        cell.lblMobileOrUpi.text = contact.contactNumbers
//        
//        if let imageData = contact.thumbnailImageData {
//            cell.imgContact.image = UIImage(data: imageData)
//        } else {
//            // Set a placeholder image if no contact image is available
//            cell.imgContact.image = UIImage(named: "me_profile")
//        }
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        operatorSelectDelegate?.selectedOperatorInfo(operatorName: operatorResData?[indexPath.row].operator_name ?? "", serviceType: operatorResData?[indexPath.row].service_type ?? "")
        
        self.dismiss(animated: true, completion: nil)

        
    }
    
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        tableView.deselectRow(at: indexPath, animated: true)
//        textfieldSearch.resignFirstResponder()
//        
//        let contact = filteredContactList[indexPath.row]
//        
//        if arrRecentContactList.count > 5 {
//            arrRecentContactList.removeLast()
//        }
//        arrRecentContactList.insert(contact, at: 0)
//        
//        // Save cards to NSUserDefaults
//        do {
//            let contactData = try JSONEncoder().encode(arrRecentContactList)
//            Common.shared.recentContacts = contactData
//        } catch {
//            print(error.localizedDescription)
//        }
//        
//        // RechargePlanViewController
//        
//        let vc = UIStoryboard(name: "USP", bundle: nil).instantiateViewController(withIdentifier: "RechargePlanViewController") as! RechargePlanViewController
//        vc.contactNo = contact.contactNumbers ?? ""
//       // vc.skeyStr = accountDetails
//        self.navigationController?.pushViewController(vc, animated: true)
//        
//       
//        
//    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
    
}
