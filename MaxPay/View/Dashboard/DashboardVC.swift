//
//  DashboardVC.swift
//  MaxPay
//
//  Created by india on 09/11/23.
//


import UIKit
import ProgressHUD
import OlivePayLibrary
import SwiftLoader
import MessageUI

class DashboardVC: BaseVC {
    
    var primBalance = 0.00
    var secondBalance = 0.00
    var sumBalance = 0.00

    @IBOutlet weak var lblQuizeTime: UILabel!
    @IBOutlet weak var vwTop: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblExpiryDate: UILabel!
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var imgTransfer: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblPrimaryWalletAmt: UILabel!
    @IBOutlet weak var lblSecondaryWalletAmt: UILabel!
    @IBOutlet weak var lblRank: UILabel!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var imgUser: UIImageView!

//    @IBOutlet weak var vwBackWalletBalance: UIView!
    @IBOutlet weak var vwBackBalance: UIView!
//    @IBOutlet weak var imgCardBlackWallet: UIImageView!
//    @IBOutlet weak var vwDebitCardBackBlackConstant: NSLayoutConstraint!
    
    @IBOutlet weak var vwDebitCardBack: NSLayoutConstraint!
    @IBOutlet weak var collVWCard: UICollectionView!
    @IBOutlet weak var viewWalletBg: UIView!
    @IBOutlet weak var viewStatusBg: UIView!
    @IBOutlet weak var imgShowHideWallet: UIImageView!
    
    @IBOutlet weak var lblUpiStatus: UILabel!
    @IBOutlet weak var lblUpiId: UILabel!
    @IBOutlet weak var viewUPIOptionsGg: UIView!
    
    @IBOutlet weak var lblFogo: UILabel!
    private var checksumViewModel = SIMSelectionViewModel()
    private var validateUpiOTPViewModel = ValidateUpiOTPViewModel()
    var strTagForCardMenuSelection: String = ""
    var btnTagForCardMenuSelection: UIButton?
    var lblBalance = UILabel()
    
    
    //
    private let totalLimitLabel = UILabel()
    private let totalLimitAmountLabel = UILabel()
    private let editButton = UIButton()
    private let donutChartView = DonutChartViewss()
    private var rankVM =  RankViewModel()
    
    private let totalSpentContainer = UIView()
    private let totalSpentLabel = UILabel()
    private let totalSpentAmountLabel = UILabel()
    private let availableBalanceContainer = UIView()
    private let availableBalanceLabel = UILabel()
    private let availableBalanceAmountLabel = UILabel()
    

    @IBOutlet weak var scrollViewBanner: UIScrollView!{
        didSet{
            scrollViewBanner.delegate = self
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var cardViewlistData: CardView!
    
    
    var slides:[Slide] = [];

    
    private var dashboardViewModel = DashboardViewModel()
    private var doubleBalance = 0.00
    
    var timer: Timer?
    var seconds = 0
    var isShowHideWallet = true
    private var cardsArr:[AccountDetailsOnIIN] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // piechart
        
//        totalLimitAmountLabel.text = "₹27,500"
//        totalSpentAmountLabel.text = "₹25,000"
//        availableBalanceAmountLabel.text = "₹2,500"
        
        
      //  lblFogo.layer.shadowPath = shadowPath0.cgPath
        lblFogo.layer.shadowColor = UIColor(red: 0.742, green: 0.732, blue: 0.732, alpha: 1).cgColor
        lblFogo.layer.shadowOpacity = 1
        lblFogo.layer.shadowRadius = 2
        lblFogo.layer.shadowOffset = CGSize(width: 0, height: 0)
      //  lblFogo.layer.bounds = shadows.bounds


       
        
//        imgCardBlackWallet.clipsToBounds = true
//        imgCardBlackWallet.layer.cornerRadius = 8
//        vwDebitCardBackBlackConstant.constant = 0
//        vwBackWalletBalance.isHidden = true
        
        scrollView.delegate = self
        scrollViewBanner.delegate = self
//        startTimer()
        setUIData()
        configuration()
//        setupOvalView()
        setupAdBanner()
        
 /*
        // validation for User, should be able to add 3 accounts in a day, after 12am object will be reseted
        if Common.shared.deviceBindingLimit != nil {
            if Common.shared.deviceBindingLimit! >= DEVICE_BINDING_LIMIT  {
                // Schedule the function to run periodically (e.g., every minute)
                let timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
                    self.removeObjectAtMidnight()
                }
                RunLoop.current.add(timer, forMode: .common)
                self.removeObjectAtMidnight()
            }
        }

        // validation for Collect Request, should be able to request 5 accounts in a day, after 12am object will be reseted
        if Common.shared.collectRequestLimit != nil {
            if Common.shared.collectRequestLimit! >= COLLECT_REQUEST_LIMIT_PERDAY  {
                // Schedule the function to run periodically (e.g., every minute)
                let timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
                    self.removeCollectRequestObjectAtMidnight()
                }
                RunLoop.current.add(timer, forMode: .common)
                self.removeCollectRequestObjectAtMidnight()
            }
        }
      */
        
        setupUILayouts()
        setupConstraintsLayouts()
       // setupCollectionView()
        
    }
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0 //as per your requirement
        layout.minimumInteritemSpacing = 0 //as per your requirement
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: self.collVWCard.frame.width / 2, height: self.collVWCard.frame.height - 100)
        self.collVWCard.collectionViewLayout = layout
    }
    
    @IBAction func btnSecoundaryTapped(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard?.instantiateViewController(withIdentifier: "WalletDetailsViewController") as! WalletDetailsViewController
      //  vc.data = dashboardViewModel
        vc.data = dashboardViewModel.balanceDetailsModel?.messageBalance?.card_number ?? ""
      
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func btnPrimaryTapped(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard?.instantiateViewController(withIdentifier: "WalletPrimaryViewController") as! WalletPrimaryViewController
        vc.data = dashboardViewModel.balanceDetailsModel?.messageBalance?.card_number ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    func setupUILayouts(){
        self.lblRank.text = "Rank \(self.rankVM.rankModelBase?.data?.myrank?.rank ?? 0)"
        
        view.backgroundColor = .white
        
        // Total Limit Label
                totalLimitLabel.text = "Total Limit"
                totalLimitLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
                totalLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(totalLimitLabel)

                // Total Limit Amount Label
                totalLimitAmountLabel.text = "₹ -----"
                totalLimitAmountLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
                totalLimitAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(totalLimitAmountLabel)

                // Edit Button
                editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
                editButton.tintColor = .systemGreen
                editButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(editButton)
        
        // Donut Chart View
          donutChartView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(donutChartView)
        
        
        // Total Spent Container
               totalSpentContainer.translatesAutoresizingMaskIntoConstraints = false
               totalSpentContainer.layer.cornerRadius = 10
               totalSpentContainer.backgroundColor = UIColor(white: 0.95, alpha: 1)
        scrollView.addSubview(totalSpentContainer)

               // Total Spent Label
               totalSpentLabel.text = "Total Spent"
               totalSpentLabel.font = UIFont.systemFont(ofSize: 14)
               totalSpentLabel.textColor = .darkGray
               totalSpentLabel.translatesAutoresizingMaskIntoConstraints = false
               totalSpentContainer.addSubview(totalSpentLabel)

               // Total Spent Amount Label
               totalSpentAmountLabel.text = "₹ -----"
               totalSpentAmountLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
               totalSpentAmountLabel.translatesAutoresizingMaskIntoConstraints = false
               totalSpentContainer.addSubview(totalSpentAmountLabel)

               // Available Balance Container
               availableBalanceContainer.translatesAutoresizingMaskIntoConstraints = false
               availableBalanceContainer.layer.cornerRadius = 10
               availableBalanceContainer.backgroundColor = UIColor(white: 0.95, alpha: 1)
               view.addSubview(availableBalanceContainer)

               // Available Balance Label
               availableBalanceLabel.text = "Available Balance"
               availableBalanceLabel.font = UIFont.systemFont(ofSize: 14)
               availableBalanceLabel.textColor = .darkGray
               availableBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
               availableBalanceContainer.addSubview(availableBalanceLabel)

               // Available Balance Amount Label
               availableBalanceAmountLabel.text = "₹ -----"
               availableBalanceAmountLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
               availableBalanceAmountLabel.textColor = UIColor(red: 0.32, green: 0.78, blue: 0.47, alpha: 1.00)
               availableBalanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
               availableBalanceContainer.addSubview(availableBalanceAmountLabel)
        
        scrollViewBanner.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(scrollViewBanner)
        
        cardViewlistData.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(cardViewlistData)
    }

    
    private func setupConstraintsLayouts() {
        NSLayoutConstraint.activate([
            // Total Limit Label Constraints
            totalLimitLabel.topAnchor.constraint(equalTo: viewStatusBg.bottomAnchor, constant: 20),
            totalLimitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            // Total Limit Amount Label Constraints
            totalLimitAmountLabel.centerYAnchor.constraint(equalTo: totalLimitLabel.centerYAnchor),
            totalLimitAmountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),

            // Edit Button Constraints
            editButton.centerYAnchor.constraint(equalTo: totalLimitAmountLabel.centerYAnchor),
            editButton.leadingAnchor.constraint(equalTo: totalLimitAmountLabel.trailingAnchor, constant: 8),
            editButton.heightAnchor.constraint(equalToConstant: 20),
            editButton.widthAnchor.constraint(equalTo: editButton.heightAnchor),
            
            // Donut Chart View Constraints
                     donutChartView.topAnchor.constraint(equalTo: totalLimitLabel.bottomAnchor, constant: 0),
                     donutChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                     donutChartView.widthAnchor.constraint(equalToConstant: 220),
                     donutChartView.heightAnchor.constraint(equalTo: donutChartView.widthAnchor),

            
            
            // Total Spent Container Constraints
                      totalSpentContainer.topAnchor.constraint(equalTo: donutChartView.topAnchor, constant: 20),
                      totalSpentContainer.leadingAnchor.constraint(equalTo: donutChartView.trailingAnchor, constant: 20),
                      totalSpentContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                      totalSpentContainer.heightAnchor.constraint(equalToConstant: 60),

                      // Total Spent Label Constraints
                      totalSpentLabel.topAnchor.constraint(equalTo: totalSpentContainer.topAnchor, constant: 8),
                      totalSpentLabel.leadingAnchor.constraint(equalTo: totalSpentContainer.leadingAnchor, constant: 12),

                      // Total Spent Amount Label Constraints
                      totalSpentAmountLabel.topAnchor.constraint(equalTo: totalSpentLabel.bottomAnchor, constant: 2),
                      totalSpentAmountLabel.leadingAnchor.constraint(equalTo: totalSpentLabel.leadingAnchor),

                      // Available Balance Container Constraints
                      availableBalanceContainer.topAnchor.constraint(equalTo: totalSpentContainer.bottomAnchor, constant: 12),
                      availableBalanceContainer.leadingAnchor.constraint(equalTo: totalSpentContainer.leadingAnchor),
                      availableBalanceContainer.trailingAnchor.constraint(equalTo: totalSpentContainer.trailingAnchor),
                      availableBalanceContainer.heightAnchor.constraint(equalToConstant: 60),

                      // Available Balance Label Constraints
                      availableBalanceLabel.topAnchor.constraint(equalTo: availableBalanceContainer.topAnchor, constant: 8),
                      availableBalanceLabel.leadingAnchor.constraint(equalTo: availableBalanceContainer.leadingAnchor, constant: 12),

                      // Available Balance Amount Label Constraints
                      availableBalanceAmountLabel.topAnchor.constraint(equalTo: availableBalanceLabel.bottomAnchor, constant: 2),
                      availableBalanceAmountLabel.leadingAnchor.constraint(equalTo: availableBalanceLabel.leadingAnchor),
            
            
            scrollViewBanner.topAnchor.constraint(equalTo: donutChartView.bottomAnchor, constant: 30), // Adjust spacing as needed
            scrollViewBanner.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
           scrollViewBanner.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollViewBanner.heightAnchor.constraint(equalToConstant: 200),
            
            
          
            
            cardViewlistData.topAnchor.constraint(equalTo: scrollViewBanner.bottomAnchor, constant: -20), // Adjust spacing as needed
            cardViewlistData.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            cardViewlistData.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            cardViewlistData.heightAnchor.constraint(equalToConstant: 252)
            
            
            
            
            
            // Adj
        ])
    }

    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func btnSideMenuClicked(_ sender: UIButton) {
        
        if (sender.tag == 10)
        {
            // To Hide Menu If it already there
            self.sideMenuItemSelectedAtIndex(-1);
            sender.tag = 0;
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3,
                           animations: {    () -> Void in
                            var frameMenu : CGRect = viewMenuBack.frame
                            frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                            viewMenuBack.frame = frameMenu
                            viewMenuBack.layoutIfNeeded()
                            viewMenuBack.backgroundColor = UIColor.clear
            },
                           completion: { (finished) -> Void in viewMenuBack.removeFromSuperview()}
            )
            return;
        }
        
        sender.isEnabled = false
        sender.tag = 10
        
        let VC : VCSideMenu = self.storyboard!.instantiateViewController(withIdentifier: "VCSideMenu") as! VCSideMenu
        VC.btnMenu = sender
        VC.delegate = self
        
        //self.view.addSubview(VC.view)
        UIApplication.shared.keyWindow?.addSubview(VC.view)
        self.addChild(VC)
        VC.view.layoutIfNeeded()
        
        // Get the menu items(options) list from side menu panel
        self.menuItems = VC.arrayMenuOptions
        
        let scrnDim = UIScreen.main.bounds.size
        VC.view.frame=CGRect(x:0 - scrnDim.width, y:0, width:scrnDim.width, height: scrnDim.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            VC.view.frame=CGRect(x: 0, y: 0, width: scrnDim.width, height: scrnDim.height);
            sender.isEnabled = true
        }, completion:nil)
        
    }
    

    
    func setupAdBanner() {
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        // disable vertical scroll
        scrollViewBanner.contentSize.height = 1.0

    }
    
    func setUIData(){
        self.imgUser.layer.cornerRadius = imgUser.frame.width / 2
        self.imgUser.layer.masksToBounds = true
        
//        let image =  defaults.object(forKey:"UserImage")
//        let UserName =  defaults.object(forKey:"UserName")
//       // imgUser..setImage(with: "SHJAa")

        self.imgUser.sd_setImage(with: URL(string: "\(Common.shared.UserProfileImage ?? "")") , placeholderImage: UIImage(named: "placeholder.png"))
        lblCustomerName.text = "\(Common.shared.userFirstName ?? "") \(Common.shared.userLastName ?? "")"
        setCardNumber(label: lblCardNumber)
    }
    
    
    func setCardNumber(label: UILabel) {
        
        // Auto layout, variables, and unit scale are not yet supported
        let shadows = UIView()
        shadows.frame = label.frame
        shadows.clipsToBounds = false

        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0.742, green: 0.732, blue: 0.732, alpha: 1).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 2
        layer0.shadowOffset = CGSize(width: 0, height: 0)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)

        let shadowPath1 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
        let layer1 = CALayer()
        layer1.shadowPath = shadowPath1.cgPath
        layer1.shadowColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 0.5).cgColor
        layer1.shadowOpacity = 1
        layer1.shadowRadius = 1
        layer1.shadowOffset = CGSize(width: 1, height: 1)
        layer1.bounds = shadows.bounds
        layer1.position = shadows.center
        shadows.layer.addSublayer(layer1)

    }
    
    func startTimer() {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    @objc func updateTimer() {
            seconds += 1
            let timeString = timeFormatted(seconds)
            lblQuizeTime.text = timeString
        }
        
        func timeFormatted(_ totalSeconds: Int) -> String {
            let hours = totalSeconds / 3600
            let minutes = (totalSeconds % 3600) / 60
            let seconds = totalSeconds % 60
            
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//    
    
        
        

    override func viewWillAppear(_ animated: Bool) {
        // Fetch card array from user defaults
        
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            rankVM.RankModelApiCall(skeyStr: "")
            
        }else{
            
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
            
        }
      
        
        cardsArr = []

        if let decoded = Common.shared.myCards {
            do {
                
                let cardList: [AccountDetailsOnIIN] = try JSONDecoder().decode([AccountDetailsOnIIN].self, from: decoded)
                
                for card in cardList {
                    cardsArr.append(card)
                }
                
                if cardsArr.count > 0 {
                    
                    lblUpiStatus.text =  cardsArr.first?.status == "A" ? "ACTIVE" : "INACTIVE"
                    lblUpiId.text =  cardsArr.first?.vpa ?? ""
                }
                
                
                for card in cardsArr {
                    
                    
                    if card.maskedAccnumber == Common.shared.primaryAccNo {
                                            
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                
                                                do {
                                                    let encoder = JSONEncoder()
                                                    let data = try encoder.encode(card)
                                                    NotificationCenter.default.post(name: .accountNotification, object: nil, userInfo: ["accountDetails": data])
                                                } catch {
                                                    print("Failed to encode account details: \(error)")
                                                }
                                                
                                            }
                        
                       // break
                        
                    }else{
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                
                                                do {
                                                    let encoder = JSONEncoder()
                                                    let data = try encoder.encode(card)
                                                    NotificationCenter.default.post(name: .accountNotification, object: nil, userInfo: ["accountDetails": data])
                                                } catch {
                                                    print("Failed to encode account details: \(error)")
                                                }
                                                
                                            }
                    
                        
                    }
                }
                
                
            } catch {
                print(error.localizedDescription)
            }
        }
       //Nitin
        if cardsArr.count == 0 {
            viewUPIOptionsGg.isHidden = cardsArr.count == 0
            viewUPIOptionsGg.frame.size.height = 0
        }
        collVWCard.reloadData()
        
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
      //  viewStatusBg.roundCornersNew([.bottomLeft, .bottomRight], radius: 20.0)
//        viewStatusBg.layer.shadowColor = UIColor(red: 0.742, green: 0.732, blue: 0.732, alpha: 1).cgColor
//        viewStatusBg.layer.shadowOpacity = 1
//        viewStatusBg.layer.shadowRadius = 20
//        viewStatusBg.layer.shadowOffset = CGSize(width: 0, height: 0)
//        
        let shadowPath = UIBezierPath(rect: viewStatusBg.bounds)
            viewStatusBg.layer.shadowPath = shadowPath.cgPath
            
            // Apply shadow properties
            viewStatusBg.layer.shadowColor = UIColor(red: 0.742, green: 0.732, blue: 0.732, alpha: 1).cgColor
            viewStatusBg.layer.shadowOpacity = 1
            viewStatusBg.layer.shadowRadius = 20
            viewStatusBg.layer.shadowOffset = CGSize(width: 0, height: 0)
            viewStatusBg.clipsToBounds = false
        
        viewStatusBg.layer.cornerRadius = 4 // Adjust the value as needed
        viewStatusBg.layer.masksToBounds = true // Ensure the view clips its content to its rounded corners

        
    }
    
    @IBAction func btnShowHideWallet(_ sender: Any) {
        
        isShowHideWallet = !isShowHideWallet
        
        viewWalletBg.isHidden = !isShowHideWallet
        
//        imgShowHideWallet.transform = CGAffineTransformMakeRotation(.pi - 3.14159)
        
    }
    
    @IBAction func btnFlipWalletAction(_ sender: Any) {
        
//        vwBackBalance.isHidden = false
//        vwBackWalletBalance.isHidden = true
//        self.vwDebitCardBack.constant = 220
//        self.vwDebitCardBackBlackConstant.constant =  0
//        UIView.animate(withDuration: 0.3, animations: {
//            self.vwDebitCardBack.constant = 220
//            self.vwDebitCardBackBlackConstant.constant =  0
//
//            self.view.layoutIfNeeded()
//        })
        
    }
    
    @IBAction func btnBalanceBackAction(_ sender: Any) {
        
//        vwBackWalletBalance.isHidden = false
//        vwBackBalance.isHidden = true
//        self.vwDebitCardBack.constant = 0
//        self.vwDebitCardBackBlackConstant.constant =  240
//        UIView.animate(withDuration: 0.3, animations: {
//            self.vwDebitCardBack.constant = 0
//            self.vwDebitCardBackBlackConstant.constant =  240
//
//            self.view.layoutIfNeeded()
//        })
//        showBalance()
        
    }
    
    @IBAction func btnNavigateAction(_ sender: UIButton) {
        
        var primaryAccount: AccountDetailsOnIIN?

        if cardsArr.count <= 0 {
            
            //return
            
        } else {
            
            for card in cardsArr {
                
                
                if card.maskedAccnumber == Common.shared.primaryAccNo {
                                        
                    primaryAccount = card
                    Common.shared.primaryAccRefNumber = primaryAccount?.accRefNumber ?? ""
                    
                    
                   // break
                    
                }else{
                    
                    primaryAccount = card
                    Common.shared.primaryAccRefNumber = primaryAccount?.accRefNumber ?? ""

                
                    
                }
            }
        }
        
        
        switch sender.tag {
            
        case 100:
            if cardsArr.count > 0 {
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "BhimUpi", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "SendMoneyVC") as! SendMoneyVC
                vc.accountDetails = primaryAccount
              
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "BhimUPVC") as! BhimUPVC
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        case 101:
//            if cardsArr.count > 0 {
//                let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier: "SendAndReceiveVC") as! SendAndReceiveVC
//                if cardsArr.count > 0 {
//                    vc.accountDetails = cardsArr.first
//                }
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "BhimUpi", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "RequestLandingVC") as! RequestLandingVC
            
            vc.accountDetails = primaryAccount
            
            self.navigationController?.pushViewController(vc, animated: true)

            
        case 102: // My QR Code
            if cardsArr.count > 0 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "MyQRCodeVC") as! MyQRCodeVC
                vc.accountDetails = primaryAccount
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.showErrorAlert("First you have to add your Bank account.")
            }
            
            
            
        case 103: // Scan QR Code
            if cardsArr.count > 0 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "ScanQRVC") as! ScanQRVC
                vc.accountDetails = primaryAccount
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.showErrorAlert("First you have to add your Bank account.")
            }
            
        case 200:
            print("1")
            // navigate to Transfer screen
            
        case 201:
            if cardsArr.count > 0 {
                // Go to UPI Options
//                let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier: "BhimUPIVC") as! BhimUPIVC
//                vc.accountDetails = cardsArr.first
//                self.navigationController?.pushViewController(vc, animated: true)
                let storyBoard: UIStoryboard = UIStoryboard(name: "BhimUpi", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "BhimUPILandingVC") as! BhimUPILandingVC
                vc.accountDetails = primaryAccount
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                // add New Account
                let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "BhimUPVC") as! BhimUPVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        case 202:
           
            let storyBoard: UIStoryboard = UIStoryboard(name: "BBPS", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PayBillListVC") as! PayBillListVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 203:
            
//            let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier: "TravelVC") as! TravelVC
//            self.navigationController?.pushViewController(vc, animated: true)
//            
            
            //TravelTabViewController
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "TravelTabViewController") as! TravelTabViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        case 204:
            
            print("Share Idea")
            //HotelViewController
//            
//            let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier: "HotelViewController") as! HotelViewController
//            self.navigationController?.pushViewController(vc, animated: true)
            
            //ManageUPIVC
            
            //MandateNewReqVC
            
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "MandateNewReqVC") as! MandateNewReqVC
                        self.navigationController?.pushViewController(vc, animated: true)
            
            
            
        case 205:
            
           // print("1")
            
            
            // LostAndFoundViewController
            
//            let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier: "HotelDetailsViewController") as! HotelDetailsViewController
//            self.navigationController?.pushViewController(vc, animated: true)

            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "LostAndFoundViewController") as! LostAndFoundViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            
        case 206:
            print("1")
            self.showToast(message: "coming Soon")
            //RechargeViewController
            
//            let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier: "RechargeViewController") as! RechargeViewController
//            self.navigationController?.pushViewController(vc, animated: true)
            
        case 207:
            let storyBoard: UIStoryboard = UIStoryboard(name: "Complaint", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "TransactionHistoryForComplaintVC") as! TransactionHistoryForComplaintVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
           return
        }
    }
    
    func showBalance(){
        let vw = WalletShow()
        vw.frame = UIScreen.main.bounds
        vw.setupUI("")
        view.addSubview(vw)
    }

    @IBAction func btnNotification(_ sender: Any) {
        let vc = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "NotificationListVC") as! NotificationListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func removeObjectAtMidnight() {
      
        //let userDefaults = UserDefaults.standard
        
        // Check if there's an object to remove
        if let _ = Common.shared.deviceBindingLimit {
            let calendar = Calendar.current
            let now = Date()
            
            // Get the current date components
            let components = calendar.dateComponents([.hour, .minute, .second], from: now)
            
            // Check if it's midnight (00:00:00)
//            if components.hour! > 0 {
            if components.hour! > 0 {
                // Remove the object from UserDefaults
                Common.shared.deviceBindingLimit = nil
                print("Object removed from UserDefaults at midnight.")
                self.timer?.invalidate()
            }
        }
    }
    
    func removeCollectRequestObjectAtMidnight() {
        let userDefaults = UserDefaults.standard
        
        // Check if there's an object to remove
        if let _ = Common.shared.collectRequestLimit {
            let calendar = Calendar.current
            let now = Date()
            
            // Get the current date components
            let components = calendar.dateComponents([.hour, .minute, .second], from: now)
            
            // Check if it's midnight (00:00:00)
//            if components.hour! > 0 {
            if components.hour! > 0 {
                // Remove the object from UserDefaults
                Common.shared.collectRequestLimit = nil
                print("Object removed from UserDefaults at midnight.")
                self.timer?.invalidate()
            }
        }
    }
}

extension DashboardVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    // numberOfSections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return cardsArr.count
        }else{
            return 2
        }
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollViewCardCell", for: indexPath) as! CollViewCardCell
            cell.setValues(accountDetailsOnIIN: cardsArr[indexPath.item])
            cell.imgCardBg.image = indexPath.row == 0 ? UIImage(named: "my-card-ic") : UIImage(named: "my-card2-ic")
            
            cell.lblPrimary.isHidden = (Common.shared.primaryAccNo ?? "") != cardsArr[indexPath.item].maskedAccnumber
            
            cell.btnMenu.tag = indexPath.row
            cell.btnMenu.addTarget(self, action: #selector(btnMenu(_:)), for: .touchUpInside)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollViewAddCardCell", for: indexPath) as! CollViewAddCardCell
            return cell
        }
        
    }

    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "BhimUPVC") as! BhimUPVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // didSelectItemAt
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        if indexPath.section == 0 {
//            return CGSize(width: self.collVWCard.frame.width/1.2, height: self.collVWCard.frame.size.height)
//        }
//        
//        return CGSize(width: cardsArr.count == 0 ? self.collVWCard.frame.width/1.2 : self.collVWCard.frame.width/4.5, height: self.collVWCard.frame.size.height)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = collectionView.bounds.size.height-2
//        let width = height-20
//        return CGSize(width: width, height:height)
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let xPadding = 0
            let spacing = 0
            let rightPadding = 10
            let width = (CGFloat(UIScreen.main.bounds.size.width - 30) - CGFloat(xPadding + spacing + rightPadding))/2
            let height = CGFloat(215)

            return CGSize(width: width, height: height)
        }
    
    @objc func btnMenu(_ sender: UIButton) {
        let vw = SetMPIN()
        vw.setupUI()
        vw.frame = UIScreen.main.bounds
        vw.delegate = self
        vw.selectedMenuInde = sender.tag
        self.view.addSubview(vw)
    }
}

extension DashboardVC {
   //MARK: API Calling
    func configuration() {
       // ProgressHUD.showSucceed()
        initViewModel()
       // observeEvent()
    }
    //MARK Network checking
    func initViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            
            dashboardViewModel.getBalanceDetailsCall(phoneStr: Common.shared.phoneNo ?? "")
            dashboardViewModel.getSecondaryWalletBalanceDetailsCall(phoneStr: Common.shared.phoneNo ?? "")
            
        }else{
            ProgressHUD.remove()
            self.showErrorAlert("Please check your internet connection.")
            
        }
    }
    //MARK: Observing the data
    func observeEvent() {
        dashboardViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }

            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                ProgressHUD.remove()
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    if self?.dashboardViewModel.balanceDetailsModel?.status == "succes" {
//                        self?.lblExpiryDate.text = "Expiry \(self?.dashboardViewModel.balanceDetailsModel?.messageBalance?.card_expiry ?? "")"
                        if self?.dashboardViewModel.balanceDetailsModel?.messageBalance?.card_number!
                            
                            .count ?? 0 >= 4  {
                            let str = self?.dashboardViewModel.balanceDetailsModel?.messageBalance?.card_number ?? ""
                            
                            print(" str card_number =======>> ",self?.dashboardViewModel.balanceDetailsModel?.messageBalance?.card_number ?? "")
                            
                            
                            
                            let index = str.index(str.endIndex, offsetBy: -4)
                            let lastFour = String(str.suffix(from: index))
                            let components = str.components(separatedBy: " ").joined(separator: "     ")
                            
                            self?.lblCardNumber.text = "\(components)"
                        }
                        
                        let balance  = self?.dashboardViewModel.balanceDetailsModel?.messageBalance?.primary_wallet_balance ?? ""
                        
                        
                        self?.doubleBalance = Double(balance) ?? 0.00
                        Common.shared.primary_wallet_balance = balance
                        
                        
                        self?.lblPrice.text = "\(String(self?.doubleBalance ?? 0.00))"
                        
                        
                        self?.lblPrimaryWalletAmt.text = "\(String(self?.doubleBalance ?? 0.00))"
                        


                    }else{
//                        self?.showErrorAlert("")
                    }
                }
                DispatchQueue.main.async {
                    if self?.dashboardViewModel.secondaryWalletBalance?.status == "success" {
                        print((self?.dashboardViewModel.secondaryWalletBalance?.secondaryBalanceData?.wallet_bal ?? ""))
                        
                        
                        let StrSecondaryBalance = self?.dashboardViewModel.secondaryWalletBalance?.secondaryBalanceData?.wallet_bal ?? ""
                        
                        let doubleSecondaryBal  = Double(StrSecondaryBalance) ?? 0.00
                        self?.doubleBalance = Double((self?.doubleBalance ?? 0.00) + doubleSecondaryBal)
                        Common.shared.secondary_wallet_balance = StrSecondaryBalance

                        self?.lblPrice.text = "\(String(self?.doubleBalance ?? 0.00))"
                        self?.lblSecondaryWalletAmt.text = "\(String(doubleSecondaryBal))"

                    }else{
                       // self?.showErrorAlert("")
                    }
                }
            case .error(let error):
                print(error!)
                ProgressHUD.remove()
            }
        }
    }

    func createSlides() -> [Slide] {

        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageView.image = UIImage(named: "ic_onboarding_1")
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: "ic_onboarding_1")
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageView.image = UIImage(named: "ic_onboarding_1")
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.imageView.image = UIImage(named: "ic_onboarding_1")
        
        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.imageView.image = UIImage(named: "ic_onboarding_1")
        
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollViewBanner.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollViewBanner.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollViewBanner.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollViewBanner.addSubview(slides[i])
        }
    }

}

extension DashboardVC: UIScrollViewDelegate {
    
    /*
     * default function called when view is scolled. In order to enable callback
     * when scrollview is scrolled, the below code needs to be called:
     * slideScrollView.delegate = self or
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView != scrollViewBanner {
            return
        }
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        
        /*
         * below code changes the background color of view on paging the scrollview
         */
//        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
        
    
        /*
         * below code scales the imageview on paging the scrollview
         */
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
            
            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
            
        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
            slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
            
        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
            slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
            
        } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
            slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
            slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
        }
    }
    
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
        if scrollView != scrollViewBanner {
            return
        }
        if(pageControl.currentPage == 0) {
            //Change background color to toRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1
            //Change pageControl selected color to toRed: 103/255, toGreen: 58/255, toBlue: 183/255, fromAlpha: 0.2
            //Change pageControl unselected color to toRed: 255/255, toGreen: 255/255, toBlue: 255/255, fromAlpha: 1
            
            let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.pageIndicatorTintColor = pageUnselectedColor
            
            
            let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            slides[pageControl.currentPage].backgroundColor = bgColor
            
            let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.currentPageIndicatorTintColor = pageSelectedColor
        }
        
        
        func fade(fromRed: CGFloat,
                  fromGreen: CGFloat,
                  fromBlue: CGFloat,
                  fromAlpha: CGFloat,
                  toRed: CGFloat,
                  toGreen: CGFloat,
                  toBlue: CGFloat,
                  toAlpha: CGFloat,
                  withPercentage percentage: CGFloat) -> UIColor {
            
            let red: CGFloat = (toRed - fromRed) * percentage + fromRed
            let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
            let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
            let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
            
            // return the fade colour
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
}

extension DashboardVC: MFMessageComposeViewControllerDelegate {
    
    func checksumConfiguration() {
        initChecksumViewModel()
        observeChecksumEvent()
    }
    
    
    //MARK Network checking
    func initChecksumViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            checksumViewModel.loginChecksumCall(Common.shared.phoneNo ?? "", Common.shared.getDeviceID())
        }else{
            DispatchQueue.main.async {
                SwiftLoader.hide()
                self.showErrorAlert("Please check your internet connection.")
            }
        }
    }
    
    //MARK: Observing the data
    func observeChecksumEvent() {
        checksumViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")

            case .dataLoaded:
                print("Data loaded...")
                
                if self?.checksumViewModel.checksumModel?.data?.result == "Success" {
                    
                    Common.shared.merchantauthtoken = self?.checksumViewModel.checksumModel?.data?.data?.merchantauthtoken ?? ""
                    
                    self?.performMerchantHandshake()
                    
                }else{
                    DispatchQueue.main.async {
                        self?.showErrorAlert(self?.checksumViewModel.checksumModel?.data?.result ?? "")
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
        
        OliveUpiManager.initiateSDK(sdkHandshake: jsonString, view: self, delegate: self) { (data, err) in

            print("The data is:\(String(describing: data))")
            
            if self.strTagForCardMenuSelection == "ChkBal" {
                
                DispatchQueue.main.async {
                
                    
                    self.btnCheckBalance(self.btnTagForCardMenuSelection!, lblBalance: self.lblBalance)

                }


            } else if self.strTagForCardMenuSelection == "SetChngMpin" {
                
                self.btnSetMpin(self.btnTagForCardMenuSelection!)
                
            } else if self.strTagForCardMenuSelection == "RmAcc" {
                
                self.btnDeleteAccount(self.btnTagForCardMenuSelection!)
                
            } else /*if self.strTagForCardMenuSelection == "fetchAccs"*/ {
                
                self.fetchMyAccounts()
                
            }

            self.strTagForCardMenuSelection = ""
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
                    print(er)
                    DispatchQueue.main.async {
                        self.showToast(message: "SMS Sent failed", font: .systemFont(ofSize: 12))
                        SwiftLoader.hide()
                    }
                }else{
                    if let dt = data{
                        print(dt)
                        if self.strTagForCardMenuSelection == "ChkBal" {
                            
                            DispatchQueue.main.async {
                                self.btnCheckBalance((self.btnTagForCardMenuSelection)!, lblBalance: self.lblBalance)
                            }
                            
                        } else if self.strTagForCardMenuSelection == "SetChngMpin" {
                            
                            self.btnSetMpin(self.btnTagForCardMenuSelection!)
                            
                        } else if self.strTagForCardMenuSelection == "RmAcc" {
                            
                            self.btnDeleteAccount(self.btnTagForCardMenuSelection!)
                            
                        } else /*if self.strTagForCardMenuSelection == "fetchAccs"*/ {
                            
                            self.fetchMyAccounts()
                            
                        }
                        
                        self.strTagForCardMenuSelection = ""
                    }
                }
            })
            break
        default:
            break
        }
    }
    
}

extension DashboardVC: SetMPINDelegate {
    
    func fetchMyAccounts() {
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            
            // Fix response model
            OliveUpiManager.fetchMyAccounts { data, error in
                
                if let err = error {
                    if err.code == 102 { // VPA not allowed for this customer
                        DispatchQueue.main.async {
                            self.showErrorAlert(err.localizedDescription)
                        }
                    } else if err.code == 401 || err.code == 107 {
                        self.strTagForCardMenuSelection = "fetchAccs"
                        self.checksumConfiguration()
                        return
                    }
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }
                } else {
                    
                    print(data ?? "")
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }
                    
                    if let json = data as? [Any] {
                        
                        if json.count > 0 {
                            
                            self.cardsArr = []
                            
                            if let data = SelectBankVC.convertToData(json) {
                                do {
                                    let myAccounts = try JSONDecoder().decode([MyAccounts].self, from: data)
                                    for account in myAccounts {
                                        for accObj in account.accounts {
                                            self.cardsArr.append(accObj)
                                        }
                                    }
                                } catch {
                                    print(error.localizedDescription)
                                }
                                
                                DispatchQueue.main.async {
                                    self.collVWCard.reloadData()
                                }
                            }
                        }
                        
                        do {
                            // Convert Arr of cards to Data
                            let placesData = try JSONEncoder().encode(self.cardsArr)
                            // Stored data of array to user defaults
                            Common.shared.myCards = placesData
                            
                            if self.cardsArr.count > 0 {
                                DispatchQueue.main.async {
                                    self.lblUpiStatus.text = self.cardsArr.first?.status == "A" ? "ACTIVE" : "INACTIVE"
                                    self.lblUpiId.text = self.cardsArr.first?.vpa ?? ""
                                }
                            }
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                    }
                }
            }
        }
    }
    
    
    func btnCheckBalance(_ sender: UIButton, lblBalance: UILabel) {
        
        //print("btnCheckBalance")
        strTagForCardMenuSelection = "ChkBal"
      
        btnTagForCardMenuSelection = sender
        self.lblBalance = lblBalance
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
     let accountDetailsTemp = self.cardsArr[sender.tag]
     
//     // Prepare the account details for encoding
//     let accountDetails = AccountCheckBalance(
//         name: accountDetailsTemp.name ?? "",
//         mmid: accountDetailsTemp.mmid ?? "",
//         aeba: accountDetailsTemp.aeba ?? "",
//         mbeba: accountDetailsTemp.mbeba ?? "",
//         accRefNumber: accountDetailsTemp.accRefNumber ?? "",
//         ifsc: accountDetailsTemp.ifsc ?? "",
//         maskedAccnumber: accountDetailsTemp.maskedAccnumber ?? "",
//         status: accountDetailsTemp.status ?? "",
//         type: accountDetailsTemp.type ?? "",
//         vpa: accountDetailsTemp.vpa ?? "",
//         dLength: accountDetailsTemp.dLength ?? "",
//         dType: accountDetailsTemp.dType ?? "",
//         balance: accountDetailsTemp.balance ?? "",
//         balTime: accountDetailsTemp.balTime ?? ""
//     )
//        
//        var jsonObjectString = ""
//        
//        do {
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
//            let jsonData = try encoder.encode(accountDetails)
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                print(jsonString)
//                jsonObjectString = jsonString
//            }
//        } catch {
//            print("Error encoding JSON: \(error)")
//        }
        
        
        if accountDetailsTemp.vpa != "" {
            
            if accountDetailsTemp.status == "R" { // Account Not active
               // call activate account function
               DispatchQueue.main.async {
                   let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                   let vc = storyboard.instantiateViewController(withIdentifier: "UPISetUPIPinVC") as! UPISetUPIPinVC
                   vc.accountDetails = accountDetailsTemp
                   self.navigationController?.pushViewController(vc, animated: true)
               }
                
            } else {
                
                DispatchQueue.global(qos: .background).async {
                    
                    // Prepare the account details for encoding
                    let accountDetails = AccountCheckBalance(
                        name: accountDetailsTemp.name ?? "",
                        mmid: accountDetailsTemp.mmid ?? "",
                        aeba: accountDetailsTemp.aeba ?? "",
                        mbeba: accountDetailsTemp.mbeba ?? "",
                        accRefNumber: accountDetailsTemp.accRefNumber ?? "",
                        ifsc: accountDetailsTemp.ifsc ?? "",
                        maskedAccnumber: accountDetailsTemp.maskedAccnumber ?? "",
                        status: accountDetailsTemp.status ?? "",
                        type: accountDetailsTemp.type ?? "",
                        vpa: accountDetailsTemp.vpa ?? "",
                        dLength: accountDetailsTemp.dLength ?? "",
                        dType: accountDetailsTemp.dType ?? "",
                        balance: accountDetailsTemp.balance ?? "",
                        balTime: accountDetailsTemp.balTime ?? ""
                    )
                       
                       var jsonObjectString = ""
                       
                       do {
                           let encoder = JSONEncoder()
                           encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
                           let jsonData = try encoder.encode(accountDetails)
                           if let jsonString = String(data: jsonData, encoding: .utf8) {
                               print(jsonString)
                               jsonObjectString = jsonString
                           }
                       } catch {
                           print("Error encoding JSON: \(error)")
                       }
                    
                    // Working Properly
                    OliveUpiManager.checkBalance(account: jsonObjectString, viewController: self) { data, error in
                        
                        if let err = error {
                            DispatchQueue.main.async {
                                SwiftLoader.hide()
                            }
                            
                            if err.code == 102 { // VPA not allowed for this customer
                                DispatchQueue.main.async {
                                    self.showErrorAlert(err.localizedDescription)
                                }
                            } else if err.code == 401 || err.code == 107 {
                                
                                self.checksumConfiguration()
                                
                            }
                            
                        } else {
                            
                            
                            let dataObject = data as! [String: Any]
                            
                            DispatchQueue.main.async {
                                SwiftLoader.hide()
                                //self.showErrorAlert("Account Balance: \(data as! String)")
                                
                                lblBalance.isHidden = false
                                lblBalance.text = "₹\(dataObject["data"] as! String)"
                                
                            }
                        }
                    }
                }
            }
            
        } else {
            
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "UPILinkUpdateVC") as! UPILinkUpdateVC
                vc.accountDetails = accountDetailsTemp
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        
    }
    
    
    
    
    
    func btnSetMpin(_ sender: UIButton) {
        
        print("btnSetMpin")
        
        strTagForCardMenuSelection = "SetChngMpin"
        btnTagForCardMenuSelection = sender
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }

        let accountDetailsTemp = cardsArr[sender.tag]

        let accountDetails = AccountCheckBalance(name: accountDetailsTemp.name ?? "", mmid: accountDetailsTemp.mmid ?? "", aeba: accountDetailsTemp.aeba ?? "", mbeba: accountDetailsTemp.mbeba ?? "", accRefNumber: accountDetailsTemp.accRefNumber ?? "", ifsc: accountDetailsTemp.ifsc ?? "", maskedAccnumber: accountDetailsTemp.maskedAccnumber ?? "", status: accountDetailsTemp.status ?? "", type: accountDetailsTemp.type ?? "", vpa: accountDetailsTemp.vpa ?? "", dLength: accountDetailsTemp.dLength ?? "", dType: accountDetailsTemp.dType ?? "", balance: accountDetailsTemp.balance ?? "", balTime: accountDetailsTemp.balTime ?? "")

        var jsonObjectString = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(accountDetails)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                jsonObjectString = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }

        
        if accountDetailsTemp.status == "R" { // upi mpin not set / not active
            
            if accountDetailsTemp.vpa == "" {
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "UPILinkUpdateVC") as! UPILinkUpdateVC
                    vc.accountDetails = accountDetailsTemp
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            } else {
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "UPISetUPIPinVC") as! UPISetUPIPinVC
                    vc.accountDetails = accountDetailsTemp
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        } else if accountDetailsTemp.status == "A" { // Account active
            
            if accountDetailsTemp.vpa != "" {
                DispatchQueue.main.async {
                    SwiftLoader.show(animated: true)
                }
                DispatchQueue.global(qos: .background).async {
                    
                    // Working Properly
                    OliveUpiManager.changeMpin(bankid: accountDetailsTemp.iin!, account: jsonObjectString, viewController: self) { data, error in
                        
                        
                        if let err = error {
                            
                            if err.code == 102 { // VPA not allowed for this customer
                                DispatchQueue.main.async {
                                    self.showErrorAlert(err.localizedDescription)
                                }
                            } else if err.code == 401 || err.code == 107 {
                                
                                self.checksumConfiguration()
                                return
                            }
                            DispatchQueue.main.async {
                                SwiftLoader.hide()
                            }
                                                        
                        } else {
                            
                            DispatchQueue.main.async {
                                print(data ?? "")
                                SwiftLoader.hide()
                                self.showErrorAlert("MPIN Set Successfully")
                                
                                self.fetchMyAccounts()
                            }
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "UPILinkUpdateVC") as! UPILinkUpdateVC
                    vc.accountDetails = accountDetailsTemp
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        }
    }
    
    func btnDeleteAccount(_ sender: UIButton) {
        
        strTagForCardMenuSelection = "RmAcc"
        btnTagForCardMenuSelection = sender
        
        let accountDetailsTemp = cardsArr[sender.tag]
                
        let accountDetails = AccountCheckBalance(name: accountDetailsTemp.name ?? "", mmid: accountDetailsTemp.mmid ?? "", aeba: accountDetailsTemp.aeba ?? "", mbeba: accountDetailsTemp.mbeba ?? "", accRefNumber: accountDetailsTemp.accRefNumber ?? "", ifsc: accountDetailsTemp.ifsc ?? "", maskedAccnumber: accountDetailsTemp.maskedAccnumber ?? "", status: accountDetailsTemp.status ?? "", type: accountDetailsTemp.type ?? "", vpa: accountDetailsTemp.vpa ?? "", dLength: accountDetailsTemp.dLength ?? "", dType: accountDetailsTemp.dType ?? "", balance: accountDetailsTemp.balance ?? "", balTime: accountDetailsTemp.balTime ?? "")

        var jsonObjectString = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(accountDetails)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                jsonObjectString = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }

        DispatchQueue.global(qos: .background).async {
            
            // Working Properly
            OliveUpiManager.accountRemove(account: jsonObjectString) { data, error in
                
                if let err = error {
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }
                    if err.code == 102 { // Customer Accounts not found
                        DispatchQueue.main.async {
                            self.showErrorAlert(err.localizedDescription)
                        }
                    } else if err.code == 401 || err.code == 107 {
                        
                        self.checksumConfiguration()
                        
                    }
                } else {
                    
                    self.cardsArr = []
                    Common.shared.myCards = nil
                    
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.collVWCard.reloadData()
                        self.showToast(message: "Account Removed", font: .systemFont(ofSize: 12))
                    }
                    
                }
            }
        }
    }
    
    
    func btnSetAsPrimary(_ sender: UIButton) {
        let accountDetailsTemp = cardsArr[sender.tag]
        Common.shared.primaryAccNo = accountDetailsTemp.maskedAccnumber
        collVWCard.reloadData()
    }
    
}


extension Notification.Name {
    static let accountNotification = Notification.Name("accountAllNotification")
}

extension UILabel {
    func apply(configuration: (UILabel) -> Void) {
        configuration(self)
    }
}
