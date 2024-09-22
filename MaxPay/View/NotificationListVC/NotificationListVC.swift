//
//  NotificationListVC.swift
//  MaxPay
//
//  Created by Ios Developer on 25/01/24.
//

import UIKit
import SwiftLoader

class NotificationListCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class NotificationListVC: BaseVC {
    

    private var notificationViewModel = NotificationViewModel()
    var arrNotifications = [Notifications]()
    @IBOutlet weak var tableNotifications: UITableView!
    @IBOutlet weak var lblNoNotifications: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true

}
    
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension NotificationListVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotifications.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationListCell", for: indexPath) as! NotificationListCell
        
        cell.lblTitle.text = arrNotifications[indexPath.row].title
        cell.lblDescription.text = arrNotifications[indexPath.row].message
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension NotificationListVC {
    
    func configuration() {
        SwiftLoader.show(animated: true)
        initViewModel()
        observeEvent()
    }
    //MARK Network checking
    
    func initViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            notificationViewModel.notificationListCall(1) // pass dynamic pagenumber
        }else{
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
        }
    }
    
    //MARK: Observing the data
    func observeEvent() {
        SwiftLoader.show(animated: true)
        notificationViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                
            case .dataLoaded:
                print("Data loaded...")

                self?.arrNotifications.append(contentsOf: (self?.notificationViewModel.notificationListModel?.notifications)!)
                
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                    self?.tableNotifications.reloadData()
                    self?.lblNoNotifications.isHidden = self?.notificationViewModel.notificationListModel?.notifications?.count != 0
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
