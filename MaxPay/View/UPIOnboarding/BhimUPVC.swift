//
//  BhimUPVC.swift
//  MaxPay
//
//  Created by india on 10/11/23.
//

import UIKit
import CoreTelephony
import SwiftLoader
import Network

class BhimUPVC: BaseVC {
    
    private var simSelectionViewModel = SIMSelectionViewModel()
    private var limitCheckViewModel =  LimitCheckViewModel()
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkMonitorQueue")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // detect the count of added account for a day
        //        if Common.shared.deviceBindingLimit != nil {
        //            if Common.shared.deviceBindingLimit! >= DEVICE_BINDING_LIMIT  {
        //                showAlertMessageWithOkAction(title: "MaxUPI", message: "You can add 3 accounts in a day", vc: self) { status in
        //                    if status == 1 {
        //                        self.navigationController?.popViewController(animated: true)
        //                    }
        //                }
        //            }
        //        }
        //
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //     navigationController?.setNavigationBarHidden(true, animated: animated)
        
        self.tabBarController?.tabBar.isHidden = true
        
        
    }
    @IBAction func btnBackAction(_ sender: Any) {
        
        
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
        
        // navigate or pop to Home scren
    }
    
    
    func isAirplaneModeEnabled() -> Bool? {
        
        let networkInfo = CTTelephonyNetworkInfo()
        guard let radioAccessTechnology = networkInfo.serviceCurrentRadioAccessTechnology else {
            return nil
        }
        
        return radioAccessTechnology.isEmpty
        
    }
    
    
    
    @IBAction func btnStartAction(_ sender: Any) {
        
        
        
        print(isAirplaneModeEnabled())
        
        //        if isAirplaneModeEnabled() == true{
        //
        //            DispatchQueue.main.async {
        //
        //                SwiftLoader.hide()
        //
        //                self.showErrorAlert("Sim registration failed due to non-cellular network or unavailable connection")
        //
        //            }
        //
        //        }else{
        
        let networkMonitor = NetworkMonitor.shared
        
        if networkMonitor.isConnected {
            if let interfaceType = networkMonitor.interfaceType {
                switch interfaceType {
                case .wifi:
                    print("Connected via Wi-Fi")
                    
                    startMonitoring()
                  
                    
                case .cellular:
                    print("Connected via Cellular")
                    configuration()
                default:
                    print("Connected via other interface")
                }
            }
        }
        
        
        
        
        
        
        
        
        //        getSIMInformation()
        
        //        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        //        let vc = storyboard.instantiateViewController(withIdentifier: "UPISetUPIPinVC") as! UPISetUPIPinVC
        //        vc.accountDetails = self?.accountDetails
        //        self.navigationController?.pushViewController(vc, animated: true)
        
        
        //        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        //        let vc = storyBoard.instantiateViewController(withIdentifier: "SelectSIMVC") as! SelectSIMVC
        //        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    
    func startMonitoring() {
           monitor.pathUpdateHandler = { path in
        if path.status == .satisfied {
                   // Check if Wi-Fi is on
                   let isWiFi = !path.isExpensive
                   
                   // Check if Mobile Data is on
                   let isMobileData = path.isExpensive
                   
                   if isWiFi && isMobileData {
                       
                       self.configuration()
                       self.monitor.cancel()
                    
                   } else if isWiFi {
                       
                       DispatchQueue.main.async {
                           
                           self.showErrorAlert("Sim registration failed due to non-cellular network")
                       }
                       print("Wi-Fi is ON")
                   }
               } else {
                   print("No internet connection")
               }
           }

           monitor.start(queue: queue)
       }

       func stopMonitoring() {
           monitor.cancel()
       }
    
    
    
    //MARK: Observing the data
    func observeLimitCheckApi() {
        
        limitCheckViewModel.eventHandler = { [weak self] event in
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
                    
                    
                    if self?.limitCheckViewModel.limitCheckModel?.status ?? "" != "failed" {
                        
                        print(self?.limitCheckViewModel.limitCheckModel?.data?.bindAttemptLimit ?? 0)
                        
                        if self?.limitCheckViewModel.limitCheckModel?.data?.bindAttemptLimit ?? 0 != 0{
                            
                            
                            self?.configuration()
                            
                        }
                        
                    }else{
                        
                        self?.showErrorAlert(self?.limitCheckViewModel.limitCheckModel?.message ?? "")
                        
                    }
                    
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }
    
    
    
    
    func getSIMInformation() {
        
        
        //        let sub = CTSubscriberInfo.subscriber()
        //
        //        if let token = sub.carrierToken {
        //            let carrierToken:NSString? = NSString(data: token, encoding: NSUTF8StringEncoding)
        //
        //            print(carrierToken)
        //
        //        }
        //        return
        
        
        let info = CTTelephonyNetworkInfo()
        
        
        // Access the serviceSubscriberCellularProviders dictionary to get the current carrier information
        if let carriers = info.serviceSubscriberCellularProviders {
            for (_, carrier) in carriers {
                // Access the carrier details
                let mobileCountryCode = carrier.mobileCountryCode
                let carrierName = carrier.carrierName
                let isoCountryCode = carrier.isoCountryCode
                let mobileNetworkCode = carrier.mobileNetworkCode
                
                // Output the carrier details
                print("Mobile Country Code: \(mobileCountryCode ?? "N/A")")
                print("Carrier Name: \(carrierName ?? "N/A")")
                print("ISO Country Code: \(isoCountryCode ?? "N/A")")
                print("Mobile Network Code: \(mobileNetworkCode ?? "N/A")")
            }
        }
        
        // Set up a notifier to track changes to the serviceSubscriberCellularProviders dictionary
        info.serviceSubscriberCellularProvidersDidUpdateNotifier = { carriers in
            DispatchQueue.main.async {
                print("User did change SIM")
            }
        }
    }
}

extension BhimUPVC {
    
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
            simSelectionViewModel.loginChecksumCall(Common.shared.phoneNo ?? "", Common.shared.getDeviceID())
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
