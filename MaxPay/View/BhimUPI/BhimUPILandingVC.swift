//
//  BhimUPILandingVC.swift
//  MaxPay
//
//  Created by Ios Developer on 17/02/24.
//

import UIKit
import SwiftLoader
import OlivePayLibrary
import SwiftLoader
import MessageUI


class BhimUPILandingCell: UITableViewCell {
    @IBOutlet weak var imgOption: UIImageView!
    @IBOutlet weak var lblOption: UILabel!
}

class BhimUPILandingVC: BaseVC {

    private var checksumViewModel = SIMSelectionViewModel()

    var accountDetails: AccountDetailsOnIIN?

    @IBOutlet weak var scrollViewBanner: UIScrollView!{
        didSet{
            scrollViewBanner.delegate = self
        }
    }
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    var slides:[Slide] = [];

    @IBOutlet weak var tableUpiOptions: UITableView!
//    var arrUpiOptions = ["Send Money to Contact or UPI ID", "Send Money to Bank Account", "Request Money", "UPI Autopay", "Manage UPI ID", "Manage UPI Number", "Transaction History"]
    
    var arrUpiOptions = ["Send Money to Contact or UPI ID", "Send Money to Bank Account", "Request Money", "UPI Autopay", "DeRegister UPI","Manage UPI Number", "Transaction History","Remove All Cache"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

     //   setupAdBanner()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
   
    
    
    
    func deRegisterUpi() {
        
        showAlertMessageWithActionButton(title: "MaxUPI", message: "Are you sure you want to deregister?", actionButtonText: "Ok", cancelActionButtonText: "Cancel", vc: self) { status in
            
            if status == 1 { // Ok
                
                DispatchQueue.main.async {
                    SwiftLoader.show(animated: true)
                }
                
                DispatchQueue.global(qos: .background).async {
                    
                  //  OliveUpiManager.getAddress(address: <#T##String#>, callback: <#T##(Any?, NSError?) -> Void#>)
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
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false

    }
    
}

extension BhimUPILandingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUpiOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BhimUPILandingCell") as! BhimUPILandingCell
        cell.selectionStyle = .none
        
        cell.lblOption.text = arrUpiOptions[indexPath.row]
        cell.imgOption.image = UIImage(named: arrUpiOptions[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let option = arrUpiOptions[indexPath.row]
        
        if option == "Send Money to Contact or UPI ID" {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "BhimUpi", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "SendMoneyVC") as! SendMoneyVC
            vc.accountDetails = accountDetails
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if option == "Send Money to Bank Account" {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "BhimUpi", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "TransferVC") as! TransferVC
            vc.sendOption = "bank"
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if option == "Request Money" {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "BhimUpi", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "RequestLandingVC") as! RequestLandingVC
            vc.accountDetails = accountDetails
            self.navigationController?.pushViewController(vc, animated: true)
            
        } 
        
        else if option == "UPI Autopay" {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MandateListVC") as! MandateListVC
            vc.accountDetails = accountDetails
            self.navigationController?.pushViewController(vc, animated: true)
            
        } 
        
        
        
        
        
        else if option == "Manage UPI ID" {
            
            
        } 
        
        
        
        else if option == "DeRegister UPI" {
            
            deRegisterUpi()
            
        } else if option == "Manage UPI Number"{
            
            
                        let storyBoard: UIStoryboard = UIStoryboard(name: "BhimUpi", bundle: nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "ManageUPIVC") as! ManageUPIVC
                            vc.accountDetails = accountDetails
                        self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
        
        else if option == "Transaction History" {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "BhimUPIHistoryVC") as! BhimUPIHistoryVC
            vc.accountDetails = accountDetails
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if option == "Remove All Cache" {
            
            OliveUpiManager.removeKeychainData()
            
        }
                    
        
        
    }
}

extension BhimUPILandingVC: UIScrollViewDelegate {
    
//    func setupAdBanner() {
//        
//        slides = createSlides()
//        setupSlideScrollView(slides: slides)
//        
//        pageControl.numberOfPages = slides.count
//        pageControl.currentPage = 0
//        view.bringSubviewToFront(pageControl)
//        
//        // disable vertical scroll
//        scrollViewBanner.contentSize.height = 1.0
//    }
//    
//    func createSlides() -> [Slide] {
//
//        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//        slide1.imageView.image = UIImage(named: "ic_onboarding_1")
//        
//        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//        slide2.imageView.image = UIImage(named: "ic_onboarding_1")
//        
//        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//        slide3.imageView.image = UIImage(named: "ic_onboarding_1")
//        
//        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//        slide4.imageView.image = UIImage(named: "ic_onboarding_1")
//        
//        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//        slide5.imageView.image = UIImage(named: "ic_onboarding_1")
//        
//        return [slide1, slide2, slide3, slide4, slide5]
//    }
    
//    func setupSlideScrollView(slides : [Slide]) {
//        scrollViewBanner.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
//        scrollViewBanner.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
//        scrollViewBanner.isPagingEnabled = true
//        
//        for i in 0 ..< slides.count {
//            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
//            scrollViewBanner.addSubview(slides[i])
//        }
//    }

//  
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView != scrollViewBanner {
//            return
//        }
//        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
//        pageControl.currentPage = Int(pageIndex)
//        
//        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
//        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
//        
//        // vertical
//        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
//        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
//        
//        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
//        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
//        
//     
//        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
//        
//        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
//            
//            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
//            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
//            
//        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
//            slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
//            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
//            
//        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
//            slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
//            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
//            
//        } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
//            slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
//            slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
//        }
//    }
    
    
//    
//    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
//        if scrollView != scrollViewBanner {
//            return
//        }
//        if(pageControl.currentPage == 0) {
//            //Change background color to toRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1
//            //Change pageControl selected color to toRed: 103/255, toGreen: 58/255, toBlue: 183/255, fromAlpha: 0.2
//            //Change pageControl unselected color to toRed: 255/255, toGreen: 255/255, toBlue: 255/255, fromAlpha: 1
//            
//            let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
//            pageControl.pageIndicatorTintColor = pageUnselectedColor
//            
//            
//            let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
//            slides[pageControl.currentPage].backgroundColor = bgColor
//            
//            let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
//            pageControl.currentPageIndicatorTintColor = pageSelectedColor
//        }
//        
//        
//        func fade(fromRed: CGFloat,
//                  fromGreen: CGFloat,
//                  fromBlue: CGFloat,
//                  fromAlpha: CGFloat,
//                  toRed: CGFloat,
//                  toGreen: CGFloat,
//                  toBlue: CGFloat,
//                  toAlpha: CGFloat,
//                  withPercentage percentage: CGFloat) -> UIColor {
//            
//            let red: CGFloat = (toRed - fromRed) * percentage + fromRed
//            let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
//            let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
//            let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
//            
//            // return the fade colour
//            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
//        }
//    }
}


extension BhimUPILandingVC: MFMessageComposeViewControllerDelegate {
    
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
