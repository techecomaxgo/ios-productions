//
//  MilesViewController.swift
//  MaxPay
//
//  Created by Ios Developer on 28/05/24.
//

import UIKit
import SwiftLoader

class MilesViewController: BaseVC {
    
    
    private var milesTotalViewModel =  GetMilesViewModel()
    

    private var allmilesTransactionViewModel = AllmilesTransactionViewModel()
    

    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBOutlet weak var viewforTop: UIView!
    
    @IBOutlet weak var lbldistance: DesignableButton!
    
    
    @IBOutlet weak var imgWinner: UIImageView!
    
    
    @IBOutlet weak var tableMiles: UITableView!
    
    
    @IBOutlet weak var btnBack: UIButton!
    
    
    @IBOutlet weak var lblTotalMiles: UILabel!
    
    
    @IBOutlet weak var lblMilesEarn: UILabel!
    
    
    var allMilesArr : [AllmilesTransModelData]?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        lblTotalMiles.numberOfLines = 0
        lblTotalMiles.textAlignment = .center
        
        
        lblMilesEarn.numberOfLines = 0
        lblMilesEarn.textAlignment = .center
        
        
        tableMiles.delegate = self
        tableMiles.dataSource = self
        
        
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            
            milesTotalViewModel.GetMilesApiCall(skeyStr: "AVJQIdwn79iR0zlP0iKNKumME")

            observeGetTotalMilesApi()
            
            
            allmilesTransactionViewModel.GetAllMilesApiCall(skeyStr: "AVJQIdwn79iR0zlP0iKNKumME")
            
            observeGetAllMilesApi()
            
        }else{
            
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
            
        }
        
        
        
        
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true

}

    
    
    
    //MARK: Observing the data
    func observeGetTotalMilesApi() {
        
        milesTotalViewModel.eventHandler = { [weak self] event in
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
                                        
                  //  print((self?.milesTotalViewModel.getMilesModel?.data)!)
                    
                    SwiftLoader.hide()
                    
                    if self?.milesTotalViewModel.getMilesModel?.status == "success" {
                        
                       
                        
                        //self?.addRankArr = self?.rankVM.rankModelBase?.data?.allrank
                        
                       // self?.operatorResData = self?.operatorVM.OperatorBaseModel?.responseData
                        
                        

                        DispatchQueue.main.async {
                            
                            
                            print(self?.milesTotalViewModel.getMilesModel?.data?.total_miles ?? 0)
                            
                           // self?.lblTotalMiles.text = "\(self?.milesTotalViewModel.getMilesModel?.data?.total_miles ?? 0)"
                            
                            print(self?.milesTotalViewModel.getMilesModel?.data?.total_spent_amount ?? 0)
                            
                            self?.lblMilesEarn.text = "\(self?.milesTotalViewModel.getMilesModel?.data?.total_spent_amount ?? 0)"

                            
                            
                            
                            let fullString = NSMutableAttributedString()

                            // Create the large number part
                            let largeNumberAttributes: [NSAttributedString.Key: Any] = [
                                .font: UIFont.systemFont(ofSize: 24, weight: .bold),
                                .foregroundColor: UIColor.black
                            ]
                            let largeNumberString = NSAttributedString(string: "\(self?.milesTotalViewModel.getMilesModel?.data?.total_miles ?? 0)", attributes: largeNumberAttributes)

                            // Create the small "miles" part
                            let smallTextAttributes: [NSAttributedString.Key: Any] = [
                                .font: UIFont.systemFont(ofSize: 11, weight: .regular),
                                .foregroundColor: UIColor.black
                            ]
                            let smallTextString = NSAttributedString(string: "\nmiles", attributes: smallTextAttributes)

                            // Append both parts to the full string
                            fullString.append(largeNumberString)
                            fullString.append(smallTextString)

                            
                            self?.lblTotalMiles.attributedText = fullString
                            
                            
                            
                            //Lower Part Display
                            
                            
                            
                            let full2String = NSMutableAttributedString()
                            
                            let normal2TextAttributes: [NSAttributedString.Key: Any] = [
                                .font: UIFont.systemFont(ofSize: 11, weight: .regular),
                                .foregroundColor: UIColor.black
                            ]
                            let normal2TextString = NSAttributedString(string: "You’ve Earned\n", attributes: normal2TextAttributes)
                            
                            let largeCurrency2Attributes: [NSAttributedString.Key: Any] = [
                                .font: UIFont.systemFont(ofSize: 18, weight: .bold),
                                .foregroundColor: UIColor.black
                            ]
                            let largeCurrency2String = NSAttributedString(string: "₹\(self?.milesTotalViewModel.getMilesModel?.data?.total_spent_amount ?? 0)", attributes: largeCurrency2Attributes)
                            
                            full2String.append(normal2TextString)
                            full2String.append(largeCurrency2String)
                            
                            self?.lblMilesEarn.attributedText = full2String
                                                        
                            self?.lblMilesEarn.translatesAutoresizingMaskIntoConstraints = false

                            

                            
                            SwiftLoader.hide()
                            
                            
                            
                        }
                        
                    }else{
                        
                        self?.showErrorAlert(self?.milesTotalViewModel.getMilesModel?.status ?? "")
                        
                    }
                    
                    
                    
                        
      
                    
                    
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
                
            }
        }
    }
    
    
    
    //MARK: All miles Observing the data
    func observeGetAllMilesApi() {
        
        allmilesTransactionViewModel.eventHandler = { [weak self] event in
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
                                        
                    print((self?.allmilesTransactionViewModel.geAllMilesModel?.data)!)
                    
                    SwiftLoader.hide()
                    
                    if self?.allmilesTransactionViewModel.geAllMilesModel?.status == "Success" {
                        
                        print(self?.allmilesTransactionViewModel.geAllMilesModel?.data?.count ?? 0)
                        
                        self?.allMilesArr = self?.allmilesTransactionViewModel.geAllMilesModel?.data
                        
                        //self?.addRankArr = self?.rankVM.rankModelBase?.data?.allrank
                        
                       // self?.operatorResData = self?.operatorVM.OperatorBaseModel?.responseData
                        print(self?.allMilesArr)

                        DispatchQueue.main.async {
                            
                    
                            self?.tableMiles.reloadData()
                            
                            SwiftLoader.hide()
                            
                        }
                        
                    }else{
                        
                       // self?.showErrorAlert(self?.milesTotalViewModel.getMilesModel?.message ?? "")
                        
                    }
                    
                    
                    
                        
      
                    
                    
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
                
            }
        }
    }
    
    
    @IBAction func btnBackToClick(_ sender: Any) {
        
        
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    @IBAction func btnInfoClicked(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MilestonesViewController") as! MilestonesViewController
       // vc.accountDetails = primaryAccount
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


extension MilesViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  self.allMilesArr?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableMiles.dequeueReusableCell(withIdentifier: "MilesTableViewCell") as! MilesTableViewCell
        
        cell.lblMiles.text =  "\(self.allMilesArr?[indexPath.row].miles ?? 0)"
        
        cell.lblAmountpaid.text = "Amount Paid \(self.allMilesArr?[indexPath.row].spent_amount ?? "" )"
        cell.lblforpaid.text = "Paid for \(self.allMilesArr?[indexPath.row].service_type ?? "" )"

        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
        
    }
    
    
    
}
