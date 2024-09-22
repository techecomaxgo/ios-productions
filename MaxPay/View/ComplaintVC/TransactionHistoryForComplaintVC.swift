//
//  MandateListVC.swift
//  MaxPay
//
//  Created by india on 14/11/23.
//

import UIKit
import OlivePayLibrary
import SwiftLoader
import MessageUI

class TransactionHistoryForComplaintVC: BaseVC {
    
    private var checksumViewModel = SIMSelectionViewModel()
    var accountDetails: AccountDetailsOnIIN?
    private var complaintViewModel = ComplaintViewModel()
    var arrComplaints = [ComplaintData]()

    @IBOutlet weak var btnAll: UIButton!
    @IBOutlet weak var btnSent: UIButton!
    @IBOutlet weak var btnReceived: UIButton!

    @IBOutlet weak var vwLineAll: UIView!
    @IBOutlet weak var vwLineSent: UIView!
    @IBOutlet weak var vwLineReceived: UIView!
    
    @IBOutlet weak var tableViewComplaint: UITableView!
    
    var selectedTab = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDefautTabs(btnAll, lineView: btnAll, isSelected: true)
        setDefautTabs(btnSent, lineView: vwLineSent)
        setDefautTabs(btnReceived, lineView: vwLineReceived)

        configurationForComplaintList()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           self.tabBarController?.tabBar.isHidden = true

   }
    
    @IBAction func btnBackAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func btnTabAction(_ sender: UIButton) {
        
        selectedTab = sender.tag
        
        setDefautTabs(btnAll, lineView: vwLineAll)
        setDefautTabs(btnSent, lineView: vwLineSent)
        setDefautTabs(btnReceived, lineView: vwLineReceived)
        
        setDefautTabs(sender, lineView: selectedTab == 0 ? vwLineAll : selectedTab == 1 ? vwLineSent : vwLineReceived, isSelected: true)
           
    }
    
    @IBAction func btnFilter(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Complaint", bundle: nil).instantiateViewController(withIdentifier: "HistoryFIlterVC") as! HistoryFIlterVC
        self.present(vc, animated: true)//navigationController?.pushViewController(vc, animated: true)
    }
    

    func setDefautTabs(_ sender: UIButton, lineView: UIView, isSelected: Bool = false) {
        lineView.isHidden = !isSelected
        lineView.backgroundColor = isSelected ? UIColor(hexString: "9FC438") : UIColor(hexString: "808080")
        sender.setTitleColor(isSelected ? UIColor(hexString: "9FC438") : UIColor(hexString: "808080"), for: .normal)
        sender.backgroundColor = .clear
    }
    
}

extension TransactionHistoryForComplaintVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrComplaints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionHistoryForComplaintListCell", for: indexPath) as! TransactionHistoryForComplaintListCell
        
        cell.setHistoryData(object: arrComplaints[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as! PaymentSuccessfulVC
        
        vc.accountDetails = self.accountDetails
//        vc.beneVpa = self.beneVpa
//        vc.beneName = self.beneName
//        vc.transId = self.transId
//        vc.amount = "\(self.amtDecimal)"
        vc.fromScreenOption = "complaint"
        vc.complaintObj = arrComplaints[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
    
extension TransactionHistoryForComplaintVC {
    
    func configurationForComplaintList() {
        SwiftLoader.show(animated: true)
        initViewModel()
        observeEventForComplaintSearch()
    }
    //MARK Network checking
    
    func initViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            complaintViewModel.complaintListModel(1) // pass dynamic pagenumber
        }else{
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
        }
    }
    
    //MARK: Observing the data
    func observeEventForComplaintSearch() {
        SwiftLoader.show(animated: true)
        complaintViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                
            case .dataLoaded:
                print("Data loaded...")
                
                self?.arrComplaints.append(contentsOf: (self?.complaintViewModel.complaintListModel?.data)!)
                
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                    self?.tableViewComplaint.reloadData()
//                    self?.lblNoNotifications.isHidden = self?.complaintViewModel.notificationListModel?.notifications?.count != 0
                }
                
            case .error(let error):
                print(error!)
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                }
            }
        }
    }
}
