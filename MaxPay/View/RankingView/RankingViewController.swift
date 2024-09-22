//
//  RankingViewController.swift
//  MaxPay
//
//  Created by Admin on 29/05/24.
//

import UIKit
import SwiftLoader

class RankingViewController: BaseVC {
    
    
    
    private var rankVM =  RankViewModel()
    
    var addRankArr : [Allrank]? = []

    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblUserSpent: UILabel!
    
    
    @IBOutlet weak var tableViewRank: UITableView!
    
    @IBOutlet weak var lblUserRank: UILabel!
    
    @IBOutlet weak var imgUserView: UIImageView!
    
    
    var firstRankName = ""
    var firstRankId = ""
    var firstRankSpent = 0
    var firstRankStr = 0
    
    @IBOutlet weak var lblFirstName: UILabel!
    
    @IBOutlet weak var lblFirstSpent: UILabel!
    
    
    @IBOutlet weak var lblSecondName: UILabel!
    
    
    @IBOutlet weak var lblSecondSpent: UILabel!
    
    
    @IBOutlet weak var lblThirdName: UILabel!
    
    @IBOutlet weak var lblThirdSpent: UILabel!
    
    
    
    @IBOutlet weak var viewOne: UIView!
    
    @IBOutlet weak var viewTwo: UIView!
    
    @IBOutlet weak var viewThree: UIView!
    
    @IBOutlet weak var viewUserGreen: UIView!
    
    @IBOutlet weak var viewTopBorder: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewOne.layer.cornerRadius = 12
        viewOne.layer.masksToBounds = true
        
        viewTwo.layer.cornerRadius = 12
        viewTwo.layer.masksToBounds = true
        
        viewThree.layer.cornerRadius = 12
        viewThree.layer.masksToBounds = true
        
        viewUserGreen.layer.cornerRadius = 12
        viewUserGreen.layer.masksToBounds = true
        
        
        
       // viewTopBorder.backgroundColor = UIColor.clear
//        viewTopBorder.roundCorners(4.0)
//        viewTopBorder.addViewShadow()
        
        
       
        viewTopBorder.dropLeaderShadow()

        
     //   viewTopBorder.addShadowView()
        
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            
            rankVM.RankModelApiCall(skeyStr: "")
            observeRankApi()
            
        }else{
            
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
            
        }
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true

}
    
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    //MARK: Observing the data
    func observeRankApi() {
        
        rankVM.eventHandler = { [weak self] event in
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
                                        
                print((self?.rankVM.rankModelBase?.data)!)
                    
                    SwiftLoader.hide()
                    
                    if self?.rankVM.rankModelBase?.status == "success" {
                        
                        //print(self?.rankVM.rankModelBase?.data?.allrank)
                        
                        self?.addRankArr = self?.rankVM.rankModelBase?.data?.allrank
                        
                       // self?.operatorResData = self?.operatorVM.OperatorBaseModel?.responseData
                        
                        

                        DispatchQueue.main.async {
                            
                            
                            self?.lblUserName.text = self?.rankVM.rankModelBase?.data?.myrank?.full_name ?? ""

                            self?.lblUserRank.text = "\(self?.rankVM.rankModelBase?.data?.myrank?.rank ?? 0)"

                            self?.lblUserSpent.text = "\(self?.rankVM.rankModelBase?.data?.myrank?.spent ?? 0)"
                            
                            self?.lblFirstName.text = self?.rankVM.rankModelBase?.data?.allrank?[0].full_name ?? ""
                            self?.lblFirstSpent.text = "₹\(self?.rankVM.rankModelBase?.data?.allrank?[0].spent ?? 0)/-"

                            self?.lblSecondName.text = self?.rankVM.rankModelBase?.data?.allrank?[1].full_name ?? ""
                            self?.lblSecondSpent.text = "₹\(self?.rankVM.rankModelBase?.data?.allrank?[1].spent ?? 0)/-"
                            
                            self?.lblThirdName.text = self?.rankVM.rankModelBase?.data?.allrank?[2].full_name ?? ""
                            self?.lblThirdSpent.text = "₹\(self?.rankVM.rankModelBase?.data?.allrank?[2].spent ?? 0)/-"
                            
                            
                            self?.tableViewRank.reloadData()
                            
                            SwiftLoader.hide()
                            
                            
                        }
                        
                    }else{
                        
                        self?.showErrorAlert(self?.rankVM.rankModelBase?.status ?? "")
                        
                    }
                    
                    
                    
                        
      
                    
                    
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
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



extension RankingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.addRankArr?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableViewRank.dequeueReusableCell(withIdentifier: "RankTVC") as! RankTVC
        
        cell.setRankCellData(rankCellData: self.addRankArr?[indexPath.row])
        
    //cell.setOperatorCellData(operatorCellData: operatorResData?[indexPath.row])
        
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
        
//        
//        operatorSelectDelegate?.selectedOperatorInfo(operatorName: operatorResData?[indexPath.row].operator_name ?? "", serviceType: operatorResData?[indexPath.row].service_type ?? "")
        
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
        
        return 65
    }
    
    
}




