

import UIKit
import SwiftLoader
//import Kingfisher

class TravelVC: BaseVC, DatePickerDelegate, popRoomsSelectedDelegate {
    
    let datePickerView = DateNPickerView()

    var totalTVCRoomsStr = 0
    var totalTVCAdultsStr = 0
    var totalTVCChildrenStr = 0
    
    var checkOutDateStr = ""
    var checkInDateStr = ""
    
    
    @IBOutlet weak var lblGuestCount: UILabel!
    
    @IBOutlet weak var lblShortGuestcount: UILabel!
    

    @IBOutlet weak var travelTableView: UITableView!
   
    @IBOutlet weak var travelFlightView: UITableView!
   
    @IBOutlet weak var travelUiView: UIView!
    
    
    var clickCheckedTag = 0
    
    @IBOutlet weak var btnBus: UIButton!
    @IBOutlet weak var btnFlight: UIButton!
    @IBOutlet weak var btnHotel: UIButton!

    @IBOutlet weak var vwLineBus: UIView!
    @IBOutlet weak var vwLineFlight: UIView!
    @IBOutlet weak var vwLineHotel: UIView!

    @IBOutlet weak var vwBusSeat: UIImageView!
    @IBOutlet weak var vwFlight: UIImageView!
    @IBOutlet weak var vwHotel: UIImageView!
    
    @IBOutlet weak var imgLineBus: UIImageView!
    @IBOutlet weak var imgLineFlight: UIImageView!
    @IBOutlet weak var imgLineHotel: UIImageView!

    @IBOutlet weak var btnTomorrowDate: UIButton!
    @IBOutlet weak var btnTodayDate: UIButton!
    @IBOutlet weak var btnDepatureDate: UIButton!
    @IBOutlet weak var btnTo: UIButton!
    @IBOutlet weak var btnFrom: UIButton!
    @IBOutlet weak var btnSearchBus: UIButton!
    @IBOutlet weak var collectionPreviousViewed: UICollectionView!
    @IBOutlet weak var lblPreviousViewed: UILabel!
    
    @IBOutlet weak var lblFromCelcious: UILabel!
    @IBOutlet weak var imgFromWeather: UIImageView!
    @IBOutlet weak var lblToCelcious: UILabel!
    @IBOutlet weak var imgToWeather: UIImageView!
    
    @IBOutlet weak var scrollViewBanner: UIScrollView!{
        didSet{
            scrollViewBanner.delegate = self
        }
    }
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    var slides:[Slide] = []

    var arrPreviouslyViewedList = [PreviousViewed]()
    
    private var busSearchCityViewModel = BusSearchCityViewModel()
    var arrCity = [String]()
    var strFromCity = "",strToCity = ""
    var selectAddress:Int?
    var sourceID:Int?,destinationID:Int?
    var strJourneyDate = ""
//    var strPrevJourneyDate = ""
    var isBolCity = true

    var selectedTab = 0
    
    
    // Hotel
    
    var slidesHotel:[Slide] = []
    
    
    @IBOutlet weak var btnSearchall: UIButton!

    
    @IBOutlet weak var viewCheckIn: UIView!
    
    @IBOutlet weak var viewCheckOut: UIView!
    
    @IBOutlet weak var viewCheckGuest: UIView!
    
    
    
    @IBOutlet weak var btnCheckIn: UIButton!

    
    @IBOutlet weak var hotelTableView: UITableView!
    
    @IBOutlet weak var lblCheckInDay: UILabel!
    
    @IBOutlet weak var lblCheckInDate: UILabel!
    
    
    @IBOutlet weak var btnCheckout: UIButton!
    
    @IBOutlet weak var lblCheckOurDate: UILabel!
    
    @IBOutlet weak var lblCheckoutDay: UILabel!
    
//    var strJourneyDate = ""
    
    @IBOutlet weak var btnGuestCount: UIButton!
    
    
    
    @IBOutlet weak var scrollViewHotelBanner: UIScrollView!{
        didSet{
            scrollViewHotelBanner.delegate = self
        }
    }
    
    
    @IBOutlet weak var pageHotelControl: UIPageControl!
    
    var inOutDateStr = ""
    var receivedTag: Int?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        selectedTab = 0
        if let tag = receivedTag {
            selectedTab = tag
                }
        // Usage
        
        let currentWeekDates = getCurrentWeekDates()
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"

         for date in currentWeekDates {
             print(dateFormatter.string(from: date))
         }
        
       
        if receivedTag == 1{
            setDefautTabs(button: btnBus, lineView: vwBusSeat, imgView: imgLineBus)
            setDefautTabs(button: btnFlight, lineView: vwFlight, imgView: imgLineFlight,isSelected: true)
            setDefautTabs(button: btnHotel, lineView: vwHotel, imgView: imgLineHotel)
        }else if receivedTag == 2{
            setDefautTabs(button: btnBus, lineView: vwBusSeat, imgView: imgLineBus)
            setDefautTabs(button: btnFlight, lineView: vwFlight, imgView: imgLineFlight)
            setDefautTabs(button: btnHotel, lineView: vwHotel, imgView: imgLineHotel,isSelected: true)
        }else {
            setDefautTabs(button: btnBus, lineView: vwBusSeat, imgView: imgLineBus,isSelected: true)
            setDefautTabs(button: btnFlight, lineView: vwFlight, imgView: imgLineFlight)
            setDefautTabs(button: btnHotel, lineView: vwHotel, imgView: imgLineHotel)
        }
        
        
        btnSearchBus.addTarget(self, action: #selector(didTapBusSearchButton(sender:)), for: .touchUpInside)
        btnFrom.addTarget(self, action: #selector(didTapClickFrom(sender:)), for: .touchUpInside)
        btnTo.addTarget(self, action: #selector(didTapClickTo(sender:)), for: .touchUpInside)
        
        btnDepatureDate.addTarget(self, action: #selector(didTapClickDepature(sender:)), for: .touchUpInside)
        
        btnTodayDate.addTarget(self, action: #selector(didTapClickTodatDate(sender:)), for: .touchUpInside)
        btnTomorrowDate.addTarget(self, action: #selector(didTapClickTomorrowDate(sender:)), for: .touchUpInside)
        
        // get city list api
        configurationForCity()
        
        didTapClickTodatDate(sender: btnTodayDate)
        
        
        
        // Hotel's View
        
        viewCheckIn.layer.applyCornerRadiusShadow()
        
        viewCheckOut.layer.applyCornerRadiusShadow()
        
        viewCheckGuest.layer.applyCornerRadiusShadow()
        
        
        setupAdHBanner()
        
        setupAdBanner()

        
        btnCheckIn.tag = 1
        btnCheckIn.addTarget(self, action: #selector(didTapClickCheckIn(sender:)), for: .touchUpInside)

        btnSearchall.addTarget(self, action: #selector(didTapSearchClickFrom(sender:)), for: .touchUpInside)

        btnCheckout.addTarget(self, action: #selector(didTapClickCheckOut(sender:)), for: .touchUpInside)
        btnCheckout.tag = 2
        
        didTapClickHTodatDate(sender: btnCheckIn)

        didTapClickHTomorrowDate(sender: btnCheckout)
        
      
        
        let storyboard = UIStoryboard(name: "USP", bundle: nil)
                if let secondVC = storyboard.instantiateViewController(withIdentifier: "FlightBookViewController") as? FlightBookViewController {
                    
                    // Add the FlightBookViewController as a child view controller
                    self.addChild(secondVC)
                    
                    // Set the frame of `secondVC.view` to match the bounds of `travelUiView`
                    secondVC.view.frame = travelUiView.bounds
                    
                    // Add `secondVC.view` as a subview of `travelUiView`
                    travelUiView.addSubview(secondVC.view)
                    
                    // Notify the `FlightBookViewController` that it's now a child view controller
                    secondVC.didMove(toParent: self)
                }
        
    
    }
    
    
    func popRoomsSelected(totalRooms: Int, totalAdults: Int, totalChildren: Int) {
        
        totalTVCAdultsStr = totalAdults
        totalTVCRoomsStr = totalRooms
        totalTVCChildrenStr = totalChildren
        
        //2 Adults, 1 Child
        // 2+1
        lblGuestCount.text = "\(totalAdults) Adults, \(totalChildren) Child"
        
        lblShortGuestcount.text = "\(totalAdults)+\(totalChildren)"
        
    }
    
    @IBAction func btnGuestRoomClicked(_ sender: UIButton) {
        
        
        let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "RoomsGuestPopVC")  as! RoomsGuestPopVC
        
        //popOverVC.userName = contracterData.name ?? ""
        //popOverVC.ContractorPassData = contracterData
        
        popOverVC.delegatePopupRoomsSelected = self

        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        self.addChild(popOverVC)
        
        
    }
    
    
    @IBAction func btnSearchResultClicked(_ sender: UIButton) {
        
        //HotelSearchViewController
        
       // print(btnSearchall.titleLabel?.text )
        
        
        inOutDateStr = "\(lblCheckInDate.text ?? "") - \(lblCheckOurDate.text ?? "") | \(lblGuestCount.text ?? "")"
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HotelSearchViewController") as! HotelSearchViewController
      
        // vc.accountDetails = primaryAccount
        
        vc.totalHSRoomsStr = totalTVCRoomsStr
        vc.totalHSAdultsStr = totalTVCAdultsStr
        vc.totalHSChildrenStr =  totalTVCChildrenStr
        vc.selectedCity = btnSearchall.titleLabel?.text ?? ""
        vc.guestcountstr = inOutDateStr
        vc.checkInDateStr = checkInDateStr
        vc.checkOutDateStr = checkOutDateStr
        

        
        self.navigationController?.pushViewController(vc, animated: true)
        
            
    }
    
    
    @objc func didTapClickHTodatDate(sender: UIButton) {
       
        let date = Date()
        
        print(date)
        
        lblCheckInDate.text = Common.shared.showHDate(date)
        
        lblCheckInDay.text = Common.shared.showHDay(date)
        
        //dateForApiHit
        checkInDateStr = Common.shared.dateForApiHit(date)
        
        
        print(checkInDateStr)
        
    }
    
    @objc func didTapClickCheckIn(sender: UIButton) {
        
        clickCheckedTag = sender.tag
        MyBasics.showDatePickerDropDown(PickerType: UIDatePicker.Mode.date, ParentViewC: self)
    }
    
    
    @objc func didTapClickCheckOut(sender: UIButton) {
        
        clickCheckedTag = sender.tag
        //clickCheckedTag =
        print(sender.titleLabel ?? "")
        MyBasics.showDatePickerDropDown(PickerType: UIDatePicker.Mode.date, ParentViewC: self)
    }
    
    
    @objc func didTapSearchClickFrom(sender: UIButton) {
        selectAddress = 0
        showSearch()
    }
    
    
    
    @objc func didTapClickHTomorrowDate(sender: UIButton) {
        
        let today = Date()
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)
        
        strJourneyDate = Common.shared.dateApiAllowed(tomorrow!)
//        strPrevJourneyDate = Common.shared.dateformatForPreviouslySearched(tomorrow!)
        lblCheckoutDay.text = Common.shared.showHDay(tomorrow!)

        checkOutDateStr = Common.shared.dateForApiHit(tomorrow!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM" // Set your desired date format

        if let tomorrowDate = tomorrow {
            
            let formattedDate = dateFormatter.string(from: tomorrowDate)
            print("Tomorrow's date is: \(formattedDate)")
            lblCheckOurDate.text =  formattedDate
            
           // lblCheckoutDay.text = Common.shared.showHDay(date)

            
        } else {
            
            print("Failed to calculate tomorrow's date")
            
        }
        
     
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true

        
        arrPreviouslyViewedList = []
        
        if let decoded = Common.shared.travelBusSearches {
            do {
                let prevViewed: [PreviousViewed] = try JSONDecoder().decode([PreviousViewed].self, from: decoded)
                
                for prev in prevViewed {
                    arrPreviouslyViewedList.append(prev)
                }
                collectionPreviousViewed.reloadData()
                lblPreviousViewed.isHidden = arrPreviouslyViewedList.count <= 0
            } catch {
                print(error.localizedDescription)
            }
        }

    }
    
    @IBAction func btnTabAction(_ sender: UIButton) {
        
        print(sender.tag)
        selectedTab = sender.tag
        
        setDefautTabs(button: btnBus, lineView: vwBusSeat, imgView: imgLineBus)
        setDefautTabs(button: btnFlight, lineView: vwFlight, imgView: imgLineFlight)
        setDefautTabs(button: btnHotel, lineView: vwHotel, imgView: imgLineHotel)
        
        setDefautTabs(button: selectedTab == 0 ? btnBus : selectedTab == 1 ? btnFlight : btnHotel, lineView: selectedTab == 0 ? vwBusSeat : selectedTab == 1 ? vwFlight : vwHotel, imgView: selectedTab == 0 ? imgLineBus : selectedTab == 1 ? imgLineFlight : imgLineHotel, isSelected: true)
    }

    func setDefautTabs(button: UIButton, lineView: UIImageView, imgView: UIImageView,   isSelected: Bool = false) {
        
        print(selectedTab)
        lineView.isHidden = !isSelected
        
        button.setTitleColor(isSelected ? UIColor(hexString: "9FC438") : UIColor(hexString: "808080"), for: .normal)
        button.backgroundColor = .clear
        
        imgView.tintColor = isSelected ? UIColor(hexString: "9FC438") : UIColor(hexString: "808080")
        
        if selectedTab == 0 {
            
            selectedTab = 0
            travelTableView.isHidden = false
            travelFlightView.isHidden = true
            
            hotelTableView.isHidden =  true
            
        }else if selectedTab == 1{
            
            selectedTab = 1
            travelFlightView.isHidden = false
            travelTableView.isHidden = true
            hotelTableView.isHidden =  true
            
        }else if selectedTab == 2{
            
            selectedTab = 2
            travelFlightView.isHidden = true
            travelTableView.isHidden = true
            hotelTableView.isHidden =  false
            
            
        }else{
            
            
        }
    }
    
    
    @IBAction func btnBusAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchBusVC") as! SearchBusVC
        self.navigationController?.pushViewController(vc,animated: true)
    }
    @IBAction func btnFlightAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FlightBookViewController") as! FlightBookViewController
        self.navigationController?.pushViewController(vc,animated: true)
    }
    @IBAction func btnHotelAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HotelSearchVC") as! HotelSearchVC
        self.navigationController?.pushViewController(vc,animated: true)
        
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func getCurrentWeekDates() -> [Date] {
        var calendar = Calendar.current
        calendar.firstWeekday = 1 // Set the first day of the week (Sunday: 1, Monday: 2, ...)

        // Get today's date
        let today = Date()

        // Find the start and end of the current week
        var weekStartDate: Date = Date()
        var interval: TimeInterval = 0
        _ = calendar.dateInterval(of: .weekOfYear, start: &weekStartDate, interval: &interval, for: today)

        let weekEndDate = weekStartDate.addingTimeInterval(interval - 1) // Subtract one second to get the end of the week

        // Create an array of dates for the current week
        var datesInWeek: [Date] = []
        var currentDate = weekStartDate
        while currentDate <= weekEndDate {
            datesInWeek.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }

        return datesInWeek
    }
}

extension TravelVC: CustomSearchDelegate { // Bus
    
    @objc func didTapBusSearchButton(sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "BusSearchListVC") as! BusSearchListVC
        self.navigationController?.pushViewController(vc, animated: true)
        
        isBolCity = false
        configurationForCity()
    }
   
    @objc func didTapClickFrom(sender: UIButton) {
        selectAddress = 0
        showSearch()
    }
    
    @objc func didTapClickTo(sender: UIButton) {
        selectAddress = 1
        showSearch()
    }
   
    @objc func didTapClickDepature(sender: UIButton) {
        
        MyBasics.showDatePickerDropDown(PickerType: UIDatePicker.Mode.date, ParentViewC: self)
    }
    
    
    
    func selectedDateonscroll(selectedSDate: Date) {
        
        
        if selectedTab == 0 {
            
            btnDepatureDate.setTitle(Common.shared.showDate(selectedSDate), for: .normal)
            
            strJourneyDate = Common.shared.dateApiAllowed(selectedSDate)
            
        }else if selectedTab == 1{
            
            
        }else if selectedTab == 2{
            
            
            if clickCheckedTag == 1{
                
                lblCheckInDate.text =  Common.shared.showHDate(selectedSDate)
                
                lblCheckInDay.text = Common.shared.showHDay(selectedSDate)
                
                checkInDateStr = Common.shared.dateForApiHit(selectedSDate)

                
            }else if clickCheckedTag == 2{
                
                
                lblCheckOurDate.text =  Common.shared.showHDate(selectedSDate)
                
                lblCheckoutDay.text = Common.shared.showHDay(selectedSDate)
                
                checkOutDateStr = Common.shared.dateForApiHit(selectedSDate)

            }
            
        }else{
            
            
        }
        
       
        
    }
    
    
    func selectedDate(selectedDate: Date) {
        
        
        if selectedTab == 0 {
            
            btnDepatureDate.setTitle(Common.shared.showDate(selectedDate), for: .normal)
            
            strJourneyDate = Common.shared.dateApiAllowed(selectedDate)
            
        }else if selectedTab == 1{
            
            
        }else if selectedTab == 2{
            
            
            if clickCheckedTag == 1{
                
                lblCheckInDate.text =  Common.shared.showHDate(selectedDate)
                
                lblCheckInDay.text = Common.shared.showHDay(selectedDate)
                
                checkInDateStr = Common.shared.dateForApiHit(selectedDate)

                
            }else if clickCheckedTag == 2{
                
                
                lblCheckOurDate.text =  Common.shared.showHDate(selectedDate)
                
                lblCheckoutDay.text = Common.shared.showHDay(selectedDate)
                
                checkOutDateStr = Common.shared.dateForApiHit(selectedDate)

            }
            
        }else{
            
            
        }
   
        
    }
    
    @objc func didTapClickTodatDate(sender: UIButton) {
        
        
        let date = Date()
        btnDepatureDate.setTitle(Common.shared.showDate(date), for: .normal)
        strJourneyDate = Common.shared.dateApiAllowed(date)
        
//        checkInDateStr = Common.shared.dateForApiHit(date)
//        strPrevJourneyDate = Common.shared.dateformatForPreviouslySearched(date)
        
        sender.setTitleColor(UIColor.init(named: "white-color"), for: .normal)
        sender.backgroundColor = UIColor.init(named: "primary-green")
        btnTomorrowDate.setTitleColor(UIColor.init(named: "card-number-color"), for: .normal)
        btnTomorrowDate.backgroundColor = UIColor.clear
    
    }
    
    @objc func didTapClickTomorrowDate(sender: UIButton) {
        let today = Date()
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)
        strJourneyDate = Common.shared.dateApiAllowed(tomorrow!)
        checkOutDateStr = Common.shared.dateForApiHit(tomorrow!)

//        strPrevJourneyDate = Common.shared.dateformatForPreviouslySearched(tomorrow!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy" // Set your desired date format

        if let tomorrowDate = tomorrow {
            let formattedDate = dateFormatter.string(from: tomorrowDate)
            print("Tomorrow's date is: \(formattedDate)")
            btnDepatureDate.setTitle(formattedDate, for: .normal)
        } else {
            print("Failed to calculate tomorrow's date")
        }
        
        sender.setTitleColor(UIColor.init(named: "white-color"), for: .normal)
        sender.backgroundColor = UIColor.init(named: "primary-green")
        btnTodayDate.setTitleColor(UIColor.init(named: "card-number-color"), for: .normal)
        btnTodayDate.backgroundColor = UIColor.clear
    }
    

    func showSearch(){
        let vw = CustomSearch()
        vw.frame = UIScreen.main.bounds
        //vw.cities = (busSearchCityViewModel.cityModel?.cities)!
        vw.delegate = self
        vw.arrCity = arrCity
        vw.setupUI()
        view.addSubview(vw)
    }
    
    func clickCity(_ selectedIndex: Int, _ strCityName: String) {

        if selectAddress == 0{
            
            if selectedTab == 0 {
                
                sourceID =  self.busSearchCityViewModel.cityModel?.cities?[selectedIndex].id ?? 0
                btnFrom.setTitle(strCityName, for: .normal)
                strFromCity = strCityName
                
                configurationForWeather(city: strCityName, label: lblFromCelcious, imageView: imgFromWeather)

                       
                       
                   }else if selectedTab == 1{
                       
                       
                   }else if selectedTab == 2{
                       
                       
                       sourceID =  self.busSearchCityViewModel.cityModel?.cities?[selectedIndex].id ?? 0
                       btnSearchall.setTitle(strCityName, for: .normal)
                       //strFromCity = strCityName
                       

                       
                   }else{
                       
                       
                   }
            
        }else{
            btnTo.setTitle(strCityName, for: .normal)
            destinationID = self.busSearchCityViewModel.cityModel?.cities?[selectedIndex].id ?? 0
            strToCity = strCityName
            
            configurationForWeather(city: strCityName, label: lblToCelcious, imageView: imgToWeather)
        }
    }

    
    
    
    func createSlides() -> [Slide] {

        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageView.image = UIImage(named: "ic_onboarding_1")
        slide1.imageView.layer.cornerRadius = 12
        slide1.imageView.layer.masksToBounds = true
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: "ic_onboarding_1")
        slide2.imageView.layer.cornerRadius = 12
        slide2.imageView.layer.masksToBounds = true
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageView.image = UIImage(named: "ic_onboarding_1")
        slide3.imageView.layer.cornerRadius = 12
        slide3.imageView.layer.masksToBounds = true
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.imageView.image = UIImage(named: "ic_onboarding_1")
        slide4.imageView.layer.cornerRadius = 12
        slide4.imageView.layer.masksToBounds = true
        
        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.imageView.image = UIImage(named: "ic_onboarding_1")
        slide5.imageView.layer.cornerRadius = 12
        slide5.imageView.layer.masksToBounds = true
        
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    func createHSlides() -> [Slide] {

        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageView.image = UIImage(named: "ic_onboarding_1")
        slide1.imageView.layer.cornerRadius = 12
        slide1.imageView.layer.masksToBounds = true
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: "ic_onboarding_1")
        slide2.imageView.layer.cornerRadius = 12
        slide2.imageView.layer.masksToBounds = true
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageView.image = UIImage(named: "ic_onboarding_1")
        slide3.imageView.layer.cornerRadius = 12
        slide3.imageView.layer.masksToBounds = true
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.imageView.image = UIImage(named: "ic_onboarding_1")
        slide4.imageView.layer.cornerRadius = 12
        slide4.imageView.layer.masksToBounds = true
        
        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.imageView.image = UIImage(named: "ic_onboarding_1")
        slide5.imageView.layer.cornerRadius = 12
        slide5.imageView.layer.masksToBounds = true
        
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    
    
    func setupSlideScrollView(slides : [Slide]) {
        
        
        if selectedTab == 0 {
                   
            
    //        scrollViewBanner.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            scrollViewBanner.contentSize = CGSize(width: (view.frame.width-32) * CGFloat(slides.count), height: view.frame.height)
            scrollViewBanner.isPagingEnabled = true
            
            for i in 0 ..< slides.count {
                slides[i].frame = CGRect(x: (view.frame.width-32) * CGFloat(i), y: 0, width: view.frame.width-54, height: view.frame.height)
                scrollViewBanner.addSubview(slides[i])
            }
                   
               }else if selectedTab == 1{
                   
                   
               }else if selectedTab == 2{
                   
                   
                   scrollViewHotelBanner.contentSize = CGSize(width: (view.frame.width-32) * CGFloat(slides.count), height: view.frame.height)
                   scrollViewHotelBanner.isPagingEnabled = true
                   
                   for i in 0 ..< slides.count {
                       slides[i].frame = CGRect(x: (view.frame.width-32) * CGFloat(i), y: 0, width: view.frame.width-54, height: view.frame.height)
                       scrollViewHotelBanner.addSubview(slides[i])
                   }
                   
                   
               }else{
                   
                   
               }
        
        
        
    }
    

}

extension TravelVC {
    //MARK: API Calling
    func configurationForCity() {
        SwiftLoader.show(animated: true)
        initViewModel()
        observeEvent()
    }
    //MARK Network checking
    func initViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            if isBolCity {
                
                busSearchCityViewModel.cityCall()
                
            } else {
                
                if btnFrom.titleLabel?.text != "Origin" && btnTo.titleLabel?.text != "Destination" {
                    busSearchCityViewModel.busListCall(sourceID!, destinationID!, strJourneyDate)
                } else {
                    SwiftLoader.hide()
                    self.showErrorAlert("Please add your journey address.")
                }
            }
            
        } else {
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internetconnection.")
        }
    }
    //MARK: Observing the data
    func observeEvent() {
        busSearchCityViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                SwiftLoader.hide()
            case .dataLoaded:
                print("Data loaded...")
                if self?.isBolCity == true{
                    
                    if self?.busSearchCityViewModel.cityModel?.status == "success" {
                        for i in 0..<(self?.busSearchCityViewModel.cityModel?.cities?.count ?? 0) {
                            self?.arrCity.append(self?.busSearchCityViewModel.cityModel?.cities?[i].name ?? "")
                        }
                        
                    }else{
                        self?.showErrorAlert(self?.busSearchCityViewModel.cityModel?.message ?? "Error")
                    }
                    
                }else{
                    
                    
                    /* Store locally */

                    let prevViewed = PreviousViewed(origin: self?.strFromCity, destination: self?.strToCity, journeyDate: self?.strJourneyDate, sourceID: self?.sourceID, destinationID: self?.destinationID)
                    
                    if (self?.arrPreviouslyViewedList.count)! > 10 {
                        self?.arrPreviouslyViewedList.removeLast()
                    }
                    self?.arrPreviouslyViewedList.insert(prevViewed, at: 0)
                    do {
                        let categoryData = try JSONEncoder().encode(self?.arrPreviouslyViewedList)
                        Common.shared.travelBusSearches = categoryData
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    /* --- Store locally --- */

                    DispatchQueue.main.async {
                        if self?.busSearchCityViewModel.busListModel?.status == "sucess" {
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
                            let vc = storyBoard.instantiateViewController(withIdentifier: "BusSearchListVC") as! BusSearchListVC
                            vc.strFromCity = self?.strFromCity ?? ""
                            vc.strCityTo = self?.strToCity ?? ""
                            vc.strJourneyDate = self?.strJourneyDate ?? ""
                            vc.sourceID = self?.sourceID
                            vc.destinationID = self?.destinationID
                            self?.navigationController?.pushViewController(vc, animated: true)
                        }else{
                            self?.showErrorAlert(self?.busSearchCityViewModel.busListModel?.message ?? "Error")
                        }
                    }
                    
                }
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                }
                
            case .error(let error):
                print(error!)
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                }
            }
        }
    }
    
    
    // Weather api
    func configurationForWeather(city: String, label: UILabel, imageView: UIImageView) {
        initViewWeatherModel(city: city, label: label, imageView: imageView)
        observeWeatherEvent(city: city, label: label, imageView: imageView)
    }
    
    //MARK Network checking
    
    func initViewWeatherModel(city: String, label: UILabel, imageView: UIImageView) {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            busSearchCityViewModel.weatherApiCall(city: city)
        } else {
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internetconnection.")
        }
    }
    //MARK: Observing the data
    func observeWeatherEvent(city: String, label: UILabel, imageView: UIImageView) {
        busSearchCityViewModel.eventHandler = { [weak self] event in
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
                
                label.text = "\(self?.busSearchCityViewModel.weatherModel?.current?.tempC ?? 0)° C"
                if let strUrl = self?.appendHTTPSIfNeeded(to: self?.busSearchCityViewModel.weatherModel?.current?.condition?.icon ?? "") {
                    self?.loadImageFromURL(urlString: strUrl, imageView: imageView)
                }
                
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }
    
    func appendHTTPSIfNeeded(to url: String) -> String {
        if url.lowercased().hasPrefix("http://") || url.lowercased().hasPrefix("https://") {
            // URL already starts with "http://" or "https://"
            return url
        } else {
            // Append "https://" to the URL
            return "https:" + url
        }
    }
    
    func loadImageFromURL(urlString: String, imageView: UIImageView) {
        
        // Create a URL object from the string
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Create a URLSessionDataTask to fetch the data from the URL
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Check for errors
            if let error = error {
                print("Error fetching image: \(error)")
                return
            }
            
            // Check if data is received
            guard let imageData = data else {
                print("No data received")
                return
            }
            
            // Create an image from the received data
            if let image = UIImage(data: imageData) {
                // Update UI on the main thread
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } else {
                print("Unable to create image from data")
            }
        }.resume() // Start the data task
    }
}

extension TravelVC: UIScrollViewDelegate {
    
    
    func setupAdHBanner() {
        
        slidesHotel = createHSlides()
        setupSlideScrollView(slides: slidesHotel)
        
        pageHotelControl.numberOfPages = slidesHotel.count
        pageHotelControl.currentPage = 0
        view.bringSubviewToFront(pageHotelControl)
        
        // disable vertical scroll
        scrollViewHotelBanner.contentSize.height = 1.0
        
        
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

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if selectedTab == 0 {
                   
            if scrollView != scrollViewBanner {
                return
            }
            let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
            pageControl.currentPage = Int(pageIndex)
                   
               }
        else if selectedTab == 1{
                   
                   
               }
        else if selectedTab == 2{
                   
                   if scrollView != scrollViewHotelBanner {
                       return
                   }
                   let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
                   pageHotelControl.currentPage = Int(pageIndex)
                   
               }else{
                   
                   
               }
        
        
      
    }
    
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
        
        
        if selectedTab == 0 {
                   
            
            if scrollView != scrollViewBanner {
                return
            }
            if(pageControl.currentPage == 0) {
                
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
            
                   
               }else if selectedTab == 1{
                   
                   
               }else if selectedTab == 2{
                   
                   if scrollView != scrollViewHotelBanner {
                       return
                   }
                   if(pageHotelControl.currentPage == 0) {
                       
                       let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
                       pageHotelControl.pageIndicatorTintColor = pageUnselectedColor
                       
                       
                       let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
                       slidesHotel[pageHotelControl.currentPage].backgroundColor = bgColor
                       
                       let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
                       pageHotelControl.currentPageIndicatorTintColor = pageSelectedColor
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
                   
               }else{
                   
                   
               }
        

    }
}

extension TravelVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPreviouslyViewedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusPreviouslyViewedCell", for: indexPath) as!  BusPreviouslyViewedCell
        
        let prevObj = arrPreviouslyViewedList[indexPath.item]
        
        cell.lblOrigin.text = prevObj.origin
        cell.lblDestinmation.text = prevObj.destination
        cell.lblDateTime.text = prevObj.journeyDate
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        let prevObj = arrPreviouslyViewedList[indexPath.item]

        sourceID = prevObj.sourceID
        btnFrom.setTitle(prevObj.origin, for: .normal)
        strFromCity = prevObj.origin ?? ""

        destinationID = prevObj.destinationID
        btnTo.setTitle(prevObj.destination, for: .normal)
        strToCity = prevObj.destination ?? ""
        
        strJourneyDate = prevObj.journeyDate ?? ""
        
        btnDepatureDate.setTitle(Common.shared.convertDateforButton(strJourneyDate), for: .normal)
        
        
        configurationForWeather(city: strFromCity, label: lblFromCelcious, imageView: imgFromWeather)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.configurationForWeather(city: self.strToCity, label: self.lblToCelcious, imageView: self.imgToWeather)
        })
        
        
    }
    
}
 
