//
//  ChainViewController.swift
//  MaxPay
//
//  Created by Admin on 30/05/24.
//

import UIKit
import SwiftLoader
import FirebaseDynamicLinks
import Firebase

class ChainViewController: BaseVC {
    
    
    @IBOutlet weak var imgTbUser: UIImageView!
    @IBOutlet weak var lblOne: UILabel!
    @IBOutlet weak var lblTwo: UILabel!
    @IBOutlet weak var tableChainView: UITableView!
    @IBOutlet weak var chainActive: UILabel!
    
    private var chainViewModel =  ChainViewModel()

    var usersChainArr : [Users]? = []
    var referCode = ""
    var isActive = false
    
 

    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            
            chainViewModel.ChainModelApiCall(skeyStr: "AVJQIdwn79iR0zlP0iKNKumME")
            chainViewModel.ChainReferDetailsApiCall(skeyStr: "AVJQIdwn79iR0zlP0iKNKumME")
            
            observeChainApi()
            
        }else{
            
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
            
        }
        
        
        
        
        
        //imgTbUser.layer.cornerRadius = 12.0
        //imgTbUser.clipsToBounds = true

        
        lblTwo.textAlignment = .center
        
        // Create the attributed string
        let fullText = "Make Chain & Get ₹2 per chain*"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Define attributes
        let regularAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.black
        ]
        
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.red
        ]
        
        // Apply attributes
        attributedString.addAttributes(regularAttributes, range: NSRange(location: 0, length: fullText.count))
        if let range = fullText.range(of: "₹2") {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttributes(boldAttributes, range: nsRange)
        }
        
        // Assign the attributed text to the label
        lblTwo.attributedText = attributedString
        
                
        
        

        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
         super.viewWillAppear(animated)
         
         self.tabBarController?.tabBar.isHidden = true

 }
    
    @IBAction func btnMakeChainAction(_ sender: Any) {
        //let link = "https://api.maxupi.in/chain/referral?chainid=OBL"

//        let message = "Hi,\n" +
//        "Inviting you to join Max UPI\n" +
//        "an interesting app which provides you incredible offers on Mobile Recharge, Bill Payments & many more.\n\n" +
//        "Use my Chain Id:- \(referCode)\n\nDownload app from link:"
//            let link = URL(string: "https://api.maxupi.in/chain/referral?chainid=\(referCode)")!
//            
//            let activityVC = UIActivityViewController(activityItems: [message, link], applicationActivities: nil)
//            
//            // For iPad support (avoids crashes)
//            if let popoverController = activityVC.popoverPresentationController {
//                popoverController.sourceView = sender as! UIView
//            }
//            
//            present(activityVC, animated: true)
        //https://example.com/page?param=value"
        guard let link = URL(string: "https://api.maxupi.in/chain/referral?chainid=\(referCode)") else { return }
        
        let dynamicLinkComponents = DynamicLinkComponents(link: link, domainURIPrefix: "https://maxpe.page.link/?")
        
        dynamicLinkComponents?.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.maxupi.in.maxpay")
       // dynamicLinkComponents?.androidParameters = DynamicLinkAndroidParameters(packageName: "com.maxupi.in.maxpay")

        guard let longDynamicLink = dynamicLinkComponents?.url else { return }
        print("Long Dynamic Link: \(longDynamicLink)")
        
                let message = "Hi,\n" +
                "Inviting you to join Max UPI\n" +
                "an interesting app which provides you incredible offers on Mobile Recharge, Bill Payments & many more.\n\n" +
                "Use my Chain Id:- \(referCode)\n\nDownload app from link:"
        
                    let activityVC = UIActivityViewController(activityItems: [message, link], applicationActivities: nil)
        
                    // For iPad support (avoids crashes)
                    if let popoverController = activityVC.popoverPresentationController {
                        popoverController.sourceView = sender as! UIView
                    }
        
                    present(activityVC, animated: true)
        
        
        
        
    }
    //getReferDetailsApi
    //MARK: Observing the data
    func observeChainApi() {
        
        chainViewModel.eventHandler = { [weak self] event in
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
                                        
//                print((self?.rankVM.rankModelBase?.data)!)
                    
                    SwiftLoader.hide()
                    
                    if self?.chainViewModel.chainModelBase?.status == "success" {
                        let data = self?.chainViewModel.chainModelBase?.data
                        let isActive = self?.chainViewModel.chainModelBase?.isActive
                        self?.referCode = data ?? ""
                        self?.isActive = isActive ?? false
                        print("Data refer key \(data ?? "")")
                        print("Data user isActive\(isActive ?? false)")
                        if isActive == true{
                            self?.chainActive.text = "Active"
                        }else{
                            self?.chainActive.text = "Inactive"
                            self?.chainActive.textColor = .red
                        }

                       
                        
                        //print(self?.rankVM.rankModelBase?.data?.allrank)
                        
                       // self?.addRankArr = self?.rankVM.rankModelBase?.data?.allrank
                        
                       // self?.operatorResData = self?.operatorVM.OperatorBaseModel?.responseData
                        
                        self?.usersChainArr = self?.chainViewModel.chainModelBase?.users
                        print("Data user isActive \(String(describing: self?.usersChainArr))")

                        DispatchQueue.main.async {
                            self?.tableChainView.reloadData()
                            SwiftLoader.hide()
                        }
                        
                        
                        self?.lblOne.textAlignment = .center
                        
                        // Create the attributed string
                        let countStr = self?.chainViewModel.chainModelBase?.count ?? 0
                        let fulltText = "\(countStr) My Chain"
                        let attributedRString = NSMutableAttributedString(string: fulltText)
                        
                        // Define attributes
                        let yellowAttributes: [NSAttributedString.Key: Any] = [
                            .font: UIFont.boldSystemFont(ofSize: 16),
                            //.foregroundColor: UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
                            .foregroundColor: UIColor.black
                        ]
                        
                        let blackAttributes: [NSAttributedString.Key: Any] = [
                            .font: UIFont.systemFont(ofSize: 16),
                            .foregroundColor: UIColor.black
                        ]
                        
                        // Apply attributes
                        
                        attributedRString.addAttributes(yellowAttributes, range: NSRange(location: 0, length: 10)) // "24 members"
                        //attributedRString.addAttributes(blackAttributes, range: NSRange(location: 11, length: 6)) // "joined"
                        
                        // Assign the attributed text to the label
                        self?.lblOne.attributedText = attributedRString
                        
                    }else{
                        
                        self?.showErrorAlert(self?.chainViewModel.chainModelBase?.status ?? "")
                        
                    }
                    
                    
      
                    
                    
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }
    

    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
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

extension ChainViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.usersChainArr?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableChainView.dequeueReusableCell(withIdentifier: "ChainTableViewCell") as! ChainTableViewCell
        
        cell.lblName.text = self.usersChainArr?[indexPath.row].full_name
        
        cell.lblSpent.text = "₹\(self.usersChainArr?[indexPath.row].spent ?? 0)/-"
        
        cell.lblgot.text = "₹\(self.usersChainArr?[indexPath.row].earned ?? 0)/-"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
        
    }
    
    
    
}
