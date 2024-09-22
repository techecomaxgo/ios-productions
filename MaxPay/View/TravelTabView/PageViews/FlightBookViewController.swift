//
//  PageThreeViewController.swift
//  MaxPay
//
//  Created by Admin on 02/07/24.
//

import UIKit

class FlightBookViewController: BaseVC, cityFlightSelectedDelegate,DatePickerDelegate, popPassengerSelectedDelegate {
   
    var totalAdultsStr = 0
    var totalChildrenStr = 0
    var totalInfantsStr = 0

      
    var clickCheckedTag = 0
    
    @IBOutlet weak var btnInterchange: UIButton!
    
    var mainViewController: PageContainerViewController?
    
    @IBOutlet weak var viewForSelectionInput: UIView!
    
    @IBOutlet weak var viewDepart: UIView!
    
    @IBOutlet weak var viewReturn: UIView!
    
    @IBOutlet weak var viewPassenger: UIView!
    
    @IBOutlet weak var viewClassPrefrence: UIView!
        
    @IBOutlet weak var scrollViewBanner: UIScrollView!{
        didSet{
            scrollViewBanner.delegate = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides:[Slide] = [];
    
    
    @IBOutlet weak var lblFromCityName: UILabel!
    
    @IBOutlet weak var lblFromCityCode: UILabel!
    
    
    
    @IBOutlet weak var lblToCityName: UILabel!
    
    @IBOutlet weak var lblToCityCode: UILabel!
    
    var fromCityId = 0
    
    var toCityId = 0
    
    @IBOutlet weak var lblReturn: UILabel!
    
    @IBOutlet weak var returnDateConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imgForReutnDown: UIImageView!
    
    
    
    @IBOutlet weak var btnDeparture: UIButton!
   
    @IBOutlet weak var lblDepartDay: UILabel!
    
    @IBOutlet weak var lblDepartDateStr: UILabel!
    
    
    @IBOutlet weak var btnDateReturn: UIButton!
    
    @IBOutlet weak var lblReturnDay: UILabel!
    
    @IBOutlet weak var lblReturnDate: UILabel!
    
    
    var DepartDateStr = ""
    var ReturnDateStr = ""
    
    var strJourneyDate = ""
    
    
    var comeFromStr = ""
    
    var classPrefrenceStr = 0
    
    var selectedDepartDate = ""
    var selectedArrivalDate = ""

    
    @IBOutlet weak var btnEconomy: UIButton!
    
    @IBOutlet weak var btnBusiness: UIButton!
    
    @IBOutlet weak var btnPremEconomy: UIButton!
    
    
    
    @IBOutlet weak var btnOneWay: UIButton!
    
    @IBOutlet weak var btnRoundTrip: UIButton!
    
    @IBOutlet weak var btnMulticity: UIButton!
    
    
    
    var originBCode = ""
    var originBCity = ""
    
    var destinationBCode = ""
    var destinationBCity = ""
    
    
    @IBOutlet weak var stackOneTwo: UIStackView!
    
    
    @IBOutlet weak var stackViewMulti: UIStackView!
    
    
    @IBOutlet weak var selectionInputConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var viewContantConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var btnAddCity: UIButton!
    
    @IBOutlet weak var imgTwoWay: UIImageView!
    
    
    @IBOutlet weak var lblFromOneCitycode: UILabel!
    
    @IBOutlet weak var lblFromOneCity: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        self.comeFromStr = "OneWay"
        
        stackOneTwo.isHidden = false
        
        stackViewMulti.isHidden = true
        
        selectionInputConstraint.constant = 180
        
       viewContantConstraint.constant = 1100
        
        btnAddCity.isHidden = true
        
        imgTwoWay.isHidden = false

        
        viewReturn.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)

        
        defaultSelectedFlight()
        
        tripOneWayTypeSelect()

        viewForSelectionInput.layer.applyCornerRadiusShadow()
        
        viewClassPrefrence.layer.applyCornerRadiusShadow()
        
        viewDepart.layer.applyCornerRadiusShadow()
        viewReturn.layer.applyCornerRadiusShadow()
        viewPassenger.layer.applyCornerRadiusShadow()
        
        resetEconomyBackgrounds()
        
        btnPremEconomy.layer.applyCornerRadiusShadow()

        btnBusiness.layer.applyCornerRadiusShadow()

        
        scrollViewBanner.delegate = self
        setupAdBanner()
        
        btnDeparture.tag = 1
        btnDeparture.addTarget(self, action: #selector(didTapClickDeparture(sender:)), for: .touchUpInside)
        
        
        btnDateReturn.addTarget(self, action: #selector(didTapClickDateReturn(sender:)), for: .touchUpInside)
        btnDateReturn.tag = 2

        
        
        didTapClickDepartDate(sender: btnDeparture)

        didTapClickReturnDate(sender: btnDateReturn)
        
    }
    
    
    func defaultSelectedFlight() {
        
        
        originBCode = "DEL"
        originBCity =  "New Delhi"
        destinationBCode = "BOM"
        destinationBCity = "Mumbai"
       
        fromCityId = 2
        toCityId = 1
        
        lblFromCityCode.text = "DEL"
        lblFromCityName.text = "New Delhi"
        
        lblToCityCode.text = "BOM"
        lblToCityName.text = "Mumbai"
        
        btnDateReturn.isUserInteractionEnabled = false

        
    }
    
    
    func popPassengersSelected(totalAdults: Int, totalChildren: Int, totalInfrant: Int) {
        
        totalAdultsStr = totalAdults
        
        totalChildrenStr = totalChildren
        
        totalInfantsStr = totalInfrant
        
    }
    

    
    @objc func didTapClickDepartDate(sender: UIButton) {
       
        let date = Date()
        
        print(date)
        
        lblDepartDateStr.text = Common.shared.showHDate(date)
        
        lblDepartDay.text = Common.shared.showHDay(date)
        
        //dateForApiHit
        DepartDateStr = Common.shared.dateForApiHit(date)
        
        
        print(DepartDateStr)
        
    }
    
    
    
    @objc func didTapClickReturnDate(sender: UIButton) {
        
        let today = Date()
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)
        
        strJourneyDate = Common.shared.dateApiAllowed(tomorrow!)
//        strPrevJourneyDate = Common.shared.dateformatForPreviouslySearched(tomorrow!)
        lblReturnDay.text = Common.shared.showHDay(tomorrow!)

        ReturnDateStr = Common.shared.dateForApiHit(tomorrow!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM" // Set your desired date format

        if let tomorrowDate = tomorrow {
            
            let formattedDate = dateFormatter.string(from: tomorrowDate)
            print("Tomorrow's date is: \(formattedDate)")
            lblReturnDate.text =  formattedDate
            
           // lblCheckoutDay.text = Common.shared.showHDay(date)

            
        } else {
            
            print("Failed to calculate tomorrow's date")
            
        }
        
     
        
        
    }
    
    
//    func selectedDate(selectedDate: Date) {
//        
//        
//        lblDepartDateStr.text =  Common.shared.showHDate(selectedDate)
//        
//        lblDepartDay.text = Common.shared.showHDay(selectedDate)
//
//        
//        
//    }
    
    
    
    @objc func didTapClickDeparture(sender: UIButton) {
        
        clickCheckedTag = sender.tag
        
        MyBasics.showFlightDatePickerDropDown(PickerType: UIDatePicker.Mode.date, ParentViewC: self)
    }
    
    
    @objc func didTapClickDateReturn(sender: UIButton) {
        
        clickCheckedTag = sender.tag
      
        //clickCheckedTag =
        print(sender.titleLabel ?? "")
        
        MyBasics.showFlightDatePickerDropDown(PickerType: UIDatePicker.Mode.date, ParentViewC: self)
        
        
    }
    
    
    
    func selectedDate(selectedDate: Date) {
        
        
        if clickCheckedTag == 1{
            
            lblDepartDateStr.text =  Common.shared.showHDate(selectedDate)
            
            lblDepartDay.text = Common.shared.showHDay(selectedDate)
            
            DepartDateStr = Common.shared.dateForApiHit(selectedDate)

        //convertshowHDate
            
            
        }else if clickCheckedTag == 2{
            
            
            lblReturnDate.text =  Common.shared.showHDate(selectedDate)
            
            lblReturnDay.text = Common.shared.showHDay(selectedDate)
            
            ReturnDateStr = Common.shared.dateForApiHit(selectedDate)
            


        }
        
        
    }
    
    
    @IBAction func btnAddCityClicked(_ sender: UIButton) {
        
        
        
        
    }
    
    
    
    @IBAction func btnOrigionClicked(_ sender: UIButton) {
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SelectCityViewController") as! SelectCityViewController
        vc.delegatecityFlightSelect = self
        vc.comeFrom = "Origin"
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    
    @IBAction func btnDestinationClicked(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SelectCityViewController") as! SelectCityViewController
        vc.delegatecityFlightSelect = self
        vc.comeFrom = "To"
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
        
        
    }
    
    
    func popCityCodeSelected(cityCode: String, cityName: String, idStr: Int, comeFrom: String) {
        
        print(comeFrom)
        
        if comeFrom == "Origin" {
            
            
            lblFromCityCode.text = cityCode
            lblFromCityName.text = cityName
            fromCityId = idStr
            
            originBCode = cityCode
            originBCity = cityName
            
            
        }else{
            
            
            lblToCityName.text = cityName
            lblToCityCode.text = cityCode
            toCityId = idStr
            
            destinationBCode = cityCode
            destinationBCity = cityName
            

        }
        
    }
    
    
    @IBAction func btnCityInterchangeClicked(_ sender: UIButton) {
        
        interchngeCity()
        
    }
    
    func interchngeCity() {
        
        let temp = lblFromCityCode.text
        lblFromCityCode.text = lblToCityCode.text
        lblToCityCode.text = temp
        
//        
        let temp2 = lblToCityName.text
        lblToCityName.text = lblFromCityName.text
        lblFromCityName.text = temp2
        
    }
    
    
    @IBAction func btnDepartDateClicked(_ sender: UIButton) {
        
        
        
    }
    
    
    
    
//    @objc func didTapClickHTodatDate(sender: UIButton) {
//       
//        let date = Date()
//        
//        print(date)
//        
//        lblCheckInDate.text = Common.shared.showHDate(date)
//        
//        lblCheckInDay.text = Common.shared.showHDay(date)
//        
//        //dateForApiHit
//        checkInDateStr = Common.shared.dateForApiHit(date)
//        
//        
//        print(checkInDateStr)
//        
//    }
//    
    
    @IBAction func btnReturnClicked(_ sender: UIButton) {
        
        
        
    }
    
    @IBAction func btnPassengerClicked(_ sender: UIButton) {
        
        let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "FlightTravellerPopVC")  as! FlightTravellerPopVC

        popOverVC.view.frame = self.view.frame
        popOverVC.delegatePopPassengers = self
        
        self.view.addSubview(popOverVC.view)
        self.addChild(popOverVC)
        
        
        
        
    }
    
    
    @IBAction func btnEconomyClicked(_ sender: UIButton) {
        
        resetEconomyBackgrounds()
        
        classPrefrenceStr  = 0
        
    }
    
    func resetEconomyBackgrounds() {
        
        
        btnEconomy.backgroundColor = UIColor.clear
        btnBusiness.backgroundColor = UIColor.clear
        btnPremEconomy.backgroundColor = UIColor.clear
 
        
        btnEconomy.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        btnPremEconomy.backgroundColor = UIColor.white
        btnBusiness.backgroundColor = UIColor.white
        
        btnEconomy.setTitleColor(UIColor.white, for: .normal)
        
        btnEconomy.layer.applyCornerRadiusShadow()
        
        
        btnPremEconomy.setTitleColor(UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00), for: .normal)
        btnBusiness.setTitleColor(UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00), for: .normal)
       
        
        }
    
    
    @IBAction func btnBusinessClicked(_ sender: UIButton) {
        
        resetBusinessBackgrounds()
        
        classPrefrenceStr  = 2

        
        
    }
    
    func resetBusinessBackgrounds() {
        
        
        btnEconomy.backgroundColor = UIColor.clear
        btnBusiness.backgroundColor = UIColor.white
        btnPremEconomy.backgroundColor = UIColor.clear
 
        
        btnBusiness.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        btnEconomy.backgroundColor = UIColor.white
        btnPremEconomy.backgroundColor = UIColor.white
        
        btnBusiness.layer.applyCornerRadiusShadow()

        btnBusiness.setTitleColor(UIColor.white, for: .normal)

        
        btnEconomy.setTitleColor(UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00), for: .normal)
        btnPremEconomy.setTitleColor(UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00), for: .normal)

        
        }
    
    @IBAction func btnPremiumClicked(_ sender: UIButton) {
        
        resetPremEconomyBackgrounds()
        
        classPrefrenceStr  = 1

    }
    
    func resetPremEconomyBackgrounds() {
        
        
        btnEconomy.backgroundColor = UIColor.clear
        btnBusiness.backgroundColor = UIColor.clear
        btnPremEconomy.backgroundColor = UIColor.clear
 
        
        btnPremEconomy.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        btnEconomy.backgroundColor = UIColor.white
        btnBusiness.backgroundColor = UIColor.white
        
        btnPremEconomy.layer.applyCornerRadiusShadow()

        btnPremEconomy.setTitleColor(UIColor.white, for: .normal)

        btnBusiness.setTitleColor(UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00), for: .normal)
        btnEconomy.setTitleColor(UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00), for: .normal)
        
        

        
        }
    
    
    
    
    
    
    @IBAction func btnOneWayClicked(_ sender: UIButton) {
        
        viewReturn.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
        btnDateReturn.isUserInteractionEnabled = false
        
        tripOneWayTypeSelect()
        
        btnDateReturn.isUserInteractionEnabled = false
        
        
        comeFromStr = "OneWay"
        

        stackOneTwo.isHidden = false
        
        stackViewMulti.isHidden = true
        
        selectionInputConstraint.constant = 180
        
       viewContantConstraint.constant = 1100
        
        btnAddCity.isHidden = true

        
        
     
        
    }
    
    
    func tripOneWayTypeSelect (){
        
        btnOneWay.backgroundColor = UIColor.clear
        btnRoundTrip.backgroundColor = UIColor.clear
        btnMulticity.backgroundColor = UIColor.clear
 
        
        btnOneWay.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        btnRoundTrip.backgroundColor = UIColor.white
        btnMulticity.backgroundColor = UIColor.white
        
        btnOneWay.setTitleColor(UIColor.white, for: .normal)
        
        btnOneWay.layer.applyCornerRadiusShadow()
        
        
        btnRoundTrip.setTitleColor(UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00), for: .normal)
        btnRoundTrip.layer.applyCornerRadiusShadow()

        
        btnMulticity.setTitleColor(UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00), for: .normal)
        btnMulticity.layer.applyCornerRadiusShadow()
        
        
       
        
    }

    
    @IBAction func btnRoundClicked(_ sender: UIButton) {
        
        
        viewReturn.backgroundColor =  UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)

        
        btnDateReturn.isUserInteractionEnabled = true

        
        btnOneWay.backgroundColor = UIColor.clear
        btnRoundTrip.backgroundColor = UIColor.clear
        btnMulticity.backgroundColor = UIColor.clear
 
        
        btnRoundTrip.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        btnOneWay.backgroundColor = UIColor.white
        btnMulticity.backgroundColor = UIColor.white
        
        btnRoundTrip.setTitleColor(UIColor.white, for: .normal)
        
        btnRoundTrip.layer.applyCornerRadiusShadow()
        
        
        btnMulticity.setTitleColor(UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00), for: .normal)
        btnOneWay.setTitleColor(UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00), for: .normal)
        
        comeFromStr = "TwoWay"
        
        stackOneTwo.isHidden = false
        
        stackViewMulti.isHidden = true
        
        selectionInputConstraint.constant = 180
        
        viewContantConstraint.constant = 1100
        
        btnAddCity.isHidden = true
        
        imgTwoWay.isHidden = false
        
    }
    
    @IBAction func btnMulticityClicked(_ sender: UIButton) {
        
        
        btnDateReturn.isUserInteractionEnabled = true

        
        btnOneWay.backgroundColor = UIColor.clear
        btnRoundTrip.backgroundColor = UIColor.clear
        btnMulticity.backgroundColor = UIColor.clear
 
        
        btnMulticity.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        btnRoundTrip.backgroundColor = UIColor.white
        btnOneWay.backgroundColor = UIColor.white
        
        btnMulticity.setTitleColor(UIColor.white, for: .normal)
        
        btnMulticity.layer.applyCornerRadiusShadow()
        
        
        btnOneWay.setTitleColor(UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00), for: .normal)
        btnRoundTrip.setTitleColor(UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00), for: .normal)
        
        comeFromStr = "MultiWay"
        
        stackOneTwo.isHidden = true
        
        stackViewMulti.isHidden = false
        
        selectionInputConstraint.constant = 460
        
        viewContantConstraint.constant = 1300
        
        btnAddCity.isHidden = false
        
        imgTwoWay.isHidden = true
        
        
    }
    
    
    
    
    @IBAction func btnSearchFlightClicked(_ sender: UIButton) {
        
        
       // comeFromStr = "TwoWay"
        
        //FlightOneWayViewController
        
        
        if comeFromStr == "OneWay" {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "FlightOnwWayViewController") as! FlightOnwWayViewController
            
            vc.originCode = originBCode
            vc.originCity = originBCity
            
            vc.destinationCode = destinationBCode
            vc.destinationCity = destinationBCity
            
            vc.fromCityIdStr = fromCityId
            vc.toCityIdStr = toCityId
            vc.travelFDateStr = DepartDateStr
            vc.travelDateDispStr = lblDepartDateStr.text ?? ""
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }else if comeFromStr == "TwoWay" {
            
            
//            if  DepartDateStr == ReturnDateStr {
//                DispatchQueue.main.async {
//                    self.showErrorAlert(err.localizedDescription)
//                }
//                return
//            }
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "FlightTwoWayViewController") as! FlightTwoWayViewController
            
            vc.originCode = originBCode
            vc.originCity = originBCity
            
            vc.destinationCode = destinationBCode
            vc.destinationCity = destinationBCity
            
            vc.fromCityIdStr = fromCityId
            vc.toCityIdStr = toCityId
            
            vc.departTwoDateStr = DepartDateStr
            vc.returnTwoDateStr = ReturnDateStr

            
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        } else if comeFromStr == "MultiWay" {
            
            
            
        }
        
  
        
        
        
        //FlightTwoWayViewController
        
        
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
    
    
    
    
}


extension FlightBookViewController {
   
//    //MARK: API Calling
//    func configuration() {
//       // ProgressHUD.showSucceed()
//        initViewModel()
//        observeEvent()
//    }
//    //MARK Network checking
//    func initViewModel() {
//        let isConnected = ReachabilityClass.isConnectedToNetwork()
//        
//        if isConnected == true {
//            
//            dashboardViewModel.getBalanceDetailsCall()
//            dashboardViewModel.getSecondaryWalletBalanceDetailsCall()
//            
//        }else{
//            ProgressHUD.remove()
//            self.showErrorAlert("Please check your internet connection.")
//            
//        }
//    }
//    //MARK: Observing the data
//    func observeEvent() {
//        dashboardViewModel.eventHandler = { [weak self] event in
//            guard self != nil else { return }
//
//            switch event {
//            case .loading:
//                
//                print("loading....")
//                
//            case .stopLoading:
//                
//                print("Stop loading...")
//                ProgressHUD.remove()
//            case .dataLoaded:
//                print("Data loaded...")
//                DispatchQueue.main.async {
//                    if self?.dashboardViewModel.balanceDetailsModel?.status == "succes" {
////                        self?.lblExpiryDate.text = "Expiry \(self?.dashboardViewModel.balanceDetailsModel?.messageBalance?.card_expiry ?? "")"
//                        if self?.dashboardViewModel.balanceDetailsModel?.messageBalance?.card_number!
//                            .count ?? 0 >= 4  {
//                            let str = self?.dashboardViewModel.balanceDetailsModel?.messageBalance?.card_number ?? ""
//                            let index = str.index(str.endIndex, offsetBy: -4)
//                            let lastFour = String(str.suffix(from: index))
//                            let components = str.components(separatedBy: " ").joined(separator: "     ")
//                            
//                            self?.lblCardNumber.text = "\(components)"
//                        }
//                        
//                        let balance  = self?.dashboardViewModel.balanceDetailsModel?.messageBalance?.primary_wallet_balance ?? ""
//                        self?.doubleBalance = Double(balance) ?? 0.00
//                        Common.shared.primary_wallet_balance = balance
//                        
//                        self?.lblPrice.text = "\(String(self?.doubleBalance ?? 0.00))"
//                        self?.lblPrimaryWalletAmt.text = "\(String(self?.doubleBalance ?? 0.00))"
//                        
//
//
//                    }else{
////                        self?.showErrorAlert("")
//                    }
//                }
//                DispatchQueue.main.async {
//                    if self?.dashboardViewModel.secondaryWalletBalance?.status == "success" {
//                        print((self?.dashboardViewModel.secondaryWalletBalance?.secondaryBalanceData?.secondary_wallet_balance ?? ""))
//                        
//                        let StrSecondaryBalance = self?.dashboardViewModel.secondaryWalletBalance?.secondaryBalanceData?.secondary_wallet_balance ?? ""
//                        let doubleSecondaryBal  = Double(StrSecondaryBalance) ?? 0.00
//                        self?.doubleBalance = Double((self?.doubleBalance ?? 0.00) + doubleSecondaryBal)
//                        Common.shared.secondary_wallet_balance = StrSecondaryBalance
//
//                        self?.lblPrice.text = "\(String(self?.doubleBalance ?? 0.00))"
//                        self?.lblSecondaryWalletAmt.text = "\(String(doubleSecondaryBal))"
//
//                    }else{
//                       // self?.showErrorAlert("")
//                    }
//                }
//            case .error(let error):
//                print(error!)
//                ProgressHUD.remove()
//            }
//        }
//    }

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


extension FlightBookViewController: UIScrollViewDelegate {
    
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
