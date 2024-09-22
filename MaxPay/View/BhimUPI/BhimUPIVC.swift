//
//  BhimUPIVC.swift
//  MaxPay
//
//  Created by india on 13/11/23.
//

import UIKit
import OlivePayLibrary
import SwiftLoader
import MessageUI

struct ModelBhimUPI {
    let strName:String?
    let strImage:String?
}

class BhimUPIVC: BaseVC {

    @IBOutlet weak var collVWBhim: UICollectionView!
    var accountDetails: AccountDetailsOnIIN?
    private var checksumViewModel = SIMSelectionViewModel()

    let arrModelBhimUPI = [ModelBhimUPI(strName: "Request", strImage: "swap_arrow"),ModelBhimUPI(strName: "Pay", strImage: "ic_baseline_transfer"),ModelBhimUPI(strName: "Beneficiary", strImage: "ic_baseline_people_alt_24"),ModelBhimUPI(strName: "History", strImage: "ic_baseline_history_24"),ModelBhimUPI(strName: "My Qr", strImage: "ic_baseline_qr_code_24"),ModelBhimUPI(strName: "Mandate", strImage: "wealth"),ModelBhimUPI(strName: "Block", strImage: "ic_baseline_block_24"),ModelBhimUPI(strName: "Deregister", strImage: "logout_main")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func deRegisterUpi() {
        
        showAlertMessageWithActionButton(title: "MaxUPI", message: "Are you sure you want to deregister?", actionButtonText: "Ok", cancelActionButtonText: "Cancel", vc: self) { status in
            
            if status == 1 { // Ok
                
                DispatchQueue.main.async {
                    SwiftLoader.show(animated: true)
                }
                
                DispatchQueue.global(qos: .background).async {
                    
                    // Working Properly
                    OliveUpiManager.deRegister { data, error in
                        
                        if let err = error {
                            if err.code == 102 { // VPA not allowed for this customer
                                DispatchQueue.main.async {
                                    self.showErrorAlert(err.localizedDescription)
                                }
                            } else if err.code == 401 || err.code == 107 {
                                
                                self.configuration()
                                return
                                
                            }
                            DispatchQueue.main.async {
                                SwiftLoader.hide()
                            }
                            
                        } else {
                            
                            Common.shared.myCards = nil
                            Common.shared.isDeregistered = true
                            
                            DispatchQueue.main.async {
                                SwiftLoader.hide()
                                self.showToast(message: "De-Registered Successfully")
                                for controller in self.navigationController!.viewControllers as Array {
                                    if controller.isKind(of: DashboardVC.self) {
                                        self.navigationController!.popToViewController(controller, animated: true)
                                        break
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
            
        }

    }
    
}

extension BhimUPIVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrModelBhimUPI.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collVWBhim.dequeueReusableCell(withReuseIdentifier: "CollBhimUPICell", for: indexPath) as! CollBhimUPICell
        let model = arrModelBhimUPI[indexPath.row]
        cell.lblName.text = model.strName
        cell.imgBhim.image = UIImage(named: model.strImage ?? "")
        cell.imgBhim.tintColor = UIColor.white
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "SendAndReceiveVC") as! SendAndReceiveVC
            vc.bolIsPay = true
            vc.accountDetails = accountDetails
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PaymentReceivedVC") as! PaymentReceivedVC
//            vc.bolIsPay = true
            vc.accountDetails = accountDetails
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "BeneficiaryListVC") as! BeneficiaryListVC
            vc.accountDetails = accountDetails
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 { //
            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "BhimUPIHistoryVC") as! BhimUPIHistoryVC
            vc.accountDetails = accountDetails
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 4 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MyQRCodeVC") as! MyQRCodeVC
            vc.accountDetails = accountDetails
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 5 { //
            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MandateListVC") as! MandateListVC
            vc.accountDetails = accountDetails
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 6 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "BlockUPIListVC") as! BlockUPIListVC
            vc.accountDetails = accountDetails
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 7 {
            deRegisterUpi()
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 5.0
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 4

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size , height: size + 30)
    }
}

extension BhimUPIVC: MFMessageComposeViewControllerDelegate {
    
    func configuration() {
        initViewModel()
        observeEvent()
    }
    
    //MARK Network checking
    func initViewModel() {
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            checksumViewModel.loginChecksumCall(Common.shared.phoneNo ?? "", Common.shared.token ?? "")
        }else{
            DispatchQueue.main.async {
                SwiftLoader.hide()
                self.showErrorAlert("Please check your internet connection.")
            }
            
        }
    }
    
    //MARK: Observing the data
    func observeEvent() {
        
        checksumViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")

            case .dataLoaded:
                print("Data loaded...")

                if self?.checksumViewModel.checksumModel?.result == "Success" {
                    Common.shared.merchantauthtoken = self?.checksumViewModel.checksumModel?.data?.merchantauthtoken ?? ""
                    self?.performMerchantHandshake()
                }else{
                    DispatchQueue.main.async {
                        self?.showErrorAlert(self?.checksumViewModel.checksumModel?.result ?? "")
                    }
                }
                
            case .error(let error):
                print(error!)
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                }
            }
        }
    }
    
    func performMerchantHandshake(){
        
        let sdkHandShake = SDKHandshake(emailId: "", merchId: MerchantId, merchChanId: MerchantId, submerchantid: SubMerchantId, mcccode: MCC, unqCustId: "91\(Common.shared.phoneNo ?? "")", mobileNo: "91\(Common.shared.phoneNo ?? "")", deviceid: Common.shared.getDeviceID(), appid: appId, custname: "MAX", merchantauthtoken: Common.shared.merchantauthtoken ?? "", unqTxnId:SDKHandshake.shared.generateRandomDigits(12))
        
        let jsonString = sdkHandShake.jsonString(sdkHandShake)
        
        OliveUpiManager.initiateSDK(sdkHandshake: jsonString,view: self , delegate: self) { (data, err) in
            print("The data is:\(String(describing: data))")
            self.deRegisterUpi()
        }
    }
    
    public func messageComposeViewController(_ controller: MFMessageComposeViewController,didFinishWith didFinishWithresult: MessageComposeResult) {
        controller.dismiss(animated: true, completion: {})
        switch didFinishWithresult {
        case .cancelled:
            print("Cancelled")
        case .sent:
            print("Message Sent")
            OliveUpiManager.sendMobileBindReqst(callback: { (data, err) in
                if let er = err{
                    DispatchQueue.main.async {
                        self.showToast(message: "SMS Sent failed", font: .systemFont(ofSize: 12))
                        SwiftLoader.hide()
                    }
                } else {
                    self.deRegisterUpi()
                    DispatchQueue.main.async {
                        self.showToast(message: "SMS Delivered", font: .systemFont(ofSize: 12))
                    }
                }
            })
            break
        default:
            break
        }
    }
}
