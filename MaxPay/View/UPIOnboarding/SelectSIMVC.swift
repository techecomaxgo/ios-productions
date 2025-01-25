//
//  SelectSIMVC.swift
//  MaxPay
//
//  Created by india on 13/11/23.
//

import UIKit
import CoreTelephony
import SwiftLoader

class SelectSIMVC: BaseVC {

    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var lblOperatorName: UILabel!
    private var simSelectionViewModel = SIMSelectionViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        lblMobileNumber.text = "+91 \(Common.shared.phoneNo ?? "")"
        lblOperatorName.text = "Jio True"
        getSIMInformation()
    }
    @IBAction func btnSIMSelectionAction(_ sender: Any) {
        configuration()
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func getSIMInformation() {
        if #available(iOS 12.0, *) {
            if let providers = CTTelephonyNetworkInfo().dataServiceIdentifier {
               // providers.forEach { (key, value) in
                print("key:, carrier: \(providers )")
               // }
            }
        } else {
            let provider = CTTelephonyNetworkInfo().subscriberCellularProvider
            print("carrier: \(provider?.carrierName ?? "nil")")
        }
    }
}
extension SelectSIMVC {
   //MARK: API Calling
    func configuration() {
        SwiftLoader.show(animated: true)
        initViewModel()
        observeEvent()
    }
    //MARK Network checking
    func initViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            simSelectionViewModel.loginChecksumCall(Common.shared.phoneNo ?? "", Common.shared.token ?? "")
        }else{
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
            
        }
    }
    //MARK: Observing the data
    func observeEvent() {
        simSelectionViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }

            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                SwiftLoader.hide()
            case .dataLoaded:
                print("Data loaded...")
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    if self?.simSelectionViewModel.checksumModel?.data?.result == "Success" {
                        Common.shared.merchantauthtoken = self?.simSelectionViewModel.checksumModel?.data?.data?.merchantauthtoken ?? ""
                       let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                       let vc = storyboard.instantiateViewController(withIdentifier: "SelectBankVC") as! SelectBankVC
                       self?.navigationController?.pushViewController(vc,animated: true)
                    }else{
                        self?.showErrorAlert(self?.simSelectionViewModel.checksumModel?.data?.result ?? "")
                    }
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }

}
