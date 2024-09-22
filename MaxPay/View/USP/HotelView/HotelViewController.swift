//
//  HotelViewController.swift
//  MaxPay
//
//  Created by Admin on 01/06/24.
//

import UIKit

class HotelViewController: UIViewController,DatePickerDelegate, CustomSearchDelegate {
   
    
    func selectedDateonscroll(selectedSDate: Date) {
        print(selectedSDate)
    }
    
   
    
    
    
    var selectAddress:Int?
    
    var arrCity = [String]()
    
    
    @IBOutlet weak var btnSearchall: UIButton!
    
    
    @IBOutlet weak var viewCheckIn: UIView!
    
    @IBOutlet weak var viewCheckOut: UIView!
    
    @IBOutlet weak var viewCheckGuest: UIView!
    
    
    @IBOutlet weak var collectionPreviousViewed: UICollectionView!
    
    
    @IBOutlet weak var scrollViewHotelBanner: UIScrollView!{
        didSet{
            scrollViewHotelBanner.delegate = self
        }
    }
    
    
    @IBOutlet weak var pageHotelControl: UIPageControl!
    
    var slidesHotel:[Slide] = []

   // var arrPreviouslyViewedList = []()

    
    @IBOutlet weak var btnCheckIn: UIButton!
    
    @IBOutlet weak var lblCheckInDay: UILabel!
    
    @IBOutlet weak var lblCheckInDate: UILabel!
    
    
    @IBOutlet weak var btnCheckout: UIButton!
    
    @IBOutlet weak var lblCheckOurDate: UILabel!
    
    @IBOutlet weak var lblCheckoutDay: UILabel!
    
    var strJourneyDate = ""
    
    @IBOutlet weak var btnGuestCount: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewCheckIn.layer.applyCornerRadiusShadow()
        viewCheckOut.layer.applyCornerRadiusShadow()
        viewCheckGuest.layer.applyCornerRadiusShadow()
        
        
        setupAdBanner()
        
        
        btnCheckIn.addTarget(self, action: #selector(didTapClickCheckIn(sender:)), for: .touchUpInside)

        btnSearchall.addTarget(self, action: #selector(didTapSearchClickFrom(sender:)), for: .touchUpInside)

       // btnCheckout.addTarget(self, action: #selector(didTapClickHTomorrowDate(sender:)), for: .touchUpInside)

        
        didTapClickTodatDate(sender: btnCheckIn)

        didTapClickHTomorrowDate(sender: btnCheckout)
        
    }
    
    
    @objc func didTapSearchClickFrom(sender: UIButton) {
        selectAddress = 0
        showSearch()
    }
    

    @IBAction func btnGuestCountClicked(_ sender: UIButton) {
        
        
        
    }
    
    

    @objc func didTapClickCheckIn(sender: UIButton) {
        
        MyBasics.showDatePickerDropDown(PickerType: UIDatePicker.Mode.date, ParentViewC: self)
    }
    
    
    
    
    func setupSlideScrollView(slides : [Slide]) {
        
//        scrollViewBanner.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollViewHotelBanner.contentSize = CGSize(width: (view.frame.width-32) * CGFloat(slides.count), height: view.frame.height)
        scrollViewHotelBanner.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: (view.frame.width-32) * CGFloat(i), y: 0, width: view.frame.width-54, height: view.frame.height)
            scrollViewHotelBanner.addSubview(slides[i])
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
    
    
    
    

    
    
    @objc func didTapClickTodatDate(sender: UIButton) {
       
        let date = Date()
        
        lblCheckInDate.text = Common.shared.showHDate(date)
        
        lblCheckInDay.text = Common.shared.showHDay(date)
        
        
        
    }
    
    
    @objc func didTapClickHTomorrowDate(sender: UIButton) {
        
        let today = Date()
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)
        
        strJourneyDate = Common.shared.dateApiAllowed(tomorrow!)
//        strPrevJourneyDate = Common.shared.dateformatForPreviouslySearched(tomorrow!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM" // Set your desired date format

        if let tomorrowDate = tomorrow {
            
            let formattedDate = dateFormatter.string(from: tomorrowDate)
            print("Tomorrow's date is: \(formattedDate)")
            lblCheckOurDate.text =  formattedDate
            
        } else {
            
            print("Failed to calculate tomorrow's date")
            
        }
        
     
        
        
    }
    
    
    
    func selectedDate(selectedDate: Date) {
        
        
        lblCheckInDate.text =  Common.shared.showHDate(selectedDate)
        
        lblCheckInDay.text = Common.shared.showHDay(selectedDate)

        
        
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
            
//            sourceID =  self.busSearchCityViewModel.cityModel?.cities?[selectedIndex].id ?? 0
//            btnFrom.setTitle(strCityName, for: .normal)
//            strFromCity = strCityName
            
        }else{
            
//            btnTo.setTitle(strCityName, for: .normal)
//            destinationID = self.busSearchCityViewModel.cityModel?.cities?[selectedIndex].id ?? 0
//            strToCity = strCityName
            
            
        }
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


extension HotelViewController: UIScrollViewDelegate {
    
    func setupAdBanner() {
        
        slidesHotel = createSlides()
        setupSlideScrollView(slides: slidesHotel)
        
        pageHotelControl.numberOfPages = slidesHotel.count
        pageHotelControl.currentPage = 0
        view.bringSubviewToFront(pageHotelControl)
        
        // disable vertical scroll
        scrollViewHotelBanner.contentSize.height = 1.0

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView != scrollViewHotelBanner {
            return
        }
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageHotelControl.currentPage = Int(pageIndex)
    }
    
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
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
    }
}
