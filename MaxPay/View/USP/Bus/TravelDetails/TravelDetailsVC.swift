//
//  TravelDetailsVC.swift
//  MaxPay
//
//  Created by india on 06/12/23.
//

import UIKit
import SwiftyJSON
import SwiftLoader

class TravelDetailsVC: BaseVC {
    
    @IBOutlet weak var lblDOJ: UILabel!
    @IBOutlet weak var lblFromToLocation: UILabel!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnGST: UIButton!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var vwAdultBack: UIView!
    @IBOutlet weak var vwAdultBackHeight: NSLayoutConstraint!
    @IBOutlet weak var tblAdultList: UITableView!
    @IBOutlet weak var stackVW: UIStackView!
    @IBOutlet weak var txtVWtearms: UITextView!
    @IBOutlet weak var vwCondition: UIView!
    @IBOutlet weak var vwGST: UIView!
    @IBOutlet weak var vwMobileNumber: UIView!
    @IBOutlet weak var vwAddAdult: UIView!
    @IBOutlet weak var vwWay: UIView!
    @IBOutlet weak var vwContinueBooking: UIView!
    @IBOutlet weak var vwPayment: UIView!
    @IBOutlet weak var lblGrandTotal: UILabel!
    var arrSeatSelected = [JSON]()
    var arrTraveller = [Traveller]()
    private var busReviewViewModel = BusReviewViewModel()
    var strBusName = "",strBusType = "",strBoardingTime = "",strDropingTime = ""
    var engineId:Int?
    var strCityTo = "",strFromCity = "",strJourneyDate = "",tripID = "",routeId = "",boarding_date = "",droping_date  = "",busid="",strDuration = "",boardingId = "",boardingLoc = "",boardingLandmark = "",boardingContactNo = "",dropingPointId = "",dropingPointLoc = "",busName = "",busType = "",strArrivalDate = "",strDepatureDate = "",strDOJ = "",strEmail = "",strBoardingName = "",strDropingName = "",dropingLandMark = "",DropingContact = "",strTraveller = "",strDropingPointName = "",strBoardingPointName = ""
    var sourceID:Int?
    var destinationID:Int?
    var engineID:Int?
    var canceleLationPolicy = [JSON]()
    var arrCancelPolicy = [CancelPolicy]()
    var jsonStringbooking:String?
    var totalSeatPrice:Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblGrandTotal.text = "Grand Total\n5467"
        let firstTitleString = "I accept "
         let secondTitleString = "T&C and Privecy Policy."
         let finishTitleString = firstTitleString + secondTitleString
         let attributedString = NSMutableAttributedString(string: finishTitleString)
         attributedString.addAttribute(.link, value: "https://stackoverflow.com", range: NSRange(location: firstTitleString.count, length: secondTitleString.count))
         
        txtVWtearms.attributedText = attributedString
        txtVWtearms.textContainerInset = .zero
        txtVWtearms.linkTextAttributes = [
             .foregroundColor: UIColor(hexString: "32ADE6"),
             .underlineStyle: NSUnderlineStyle.single.isEmpty
         ]
        txtVWtearms.font = .systemFont(ofSize: 16)
        txtVWtearms.textColor = UIColor.black

        vwWay.layer.applyCornerRadiusShadow()
        vwWay.layer.cornerRadius = 4
        vwWay.layer.borderColor = UIColor.lightGray.cgColor
        vwWay.layer.borderWidth = 1
        
        vwCondition.layer.applyCornerRadiusShadow()
        vwCondition.layer.cornerRadius = 4
        vwCondition.layer.borderColor = UIColor.lightGray.cgColor
        vwCondition.layer.borderWidth = 1
        
        vwGST.layer.applyCornerRadiusShadow()
        vwGST.layer.cornerRadius = 4
        vwGST.layer.borderColor = UIColor.lightGray.cgColor
        vwGST.layer.borderWidth = 1
        
        vwMobileNumber.layer.applyCornerRadiusShadow()
        vwMobileNumber.layer.cornerRadius = 4
        vwMobileNumber.layer.borderColor = UIColor.lightGray.cgColor
        vwMobileNumber.layer.borderWidth = 1
        
        
        
        vwPayment.layer.applyCornerRadiusShadow()
        vwPayment.layer.cornerRadius = 4
        vwPayment.layer.borderColor = UIColor.lightGray.cgColor
        vwPayment.layer.borderWidth = 1
        
        vwAdultBack.layer.applyCornerRadiusShadow()
        vwAdultBack.layer.cornerRadius = 4
        vwAdultBack.layer.borderColor = UIColor.lightGray.cgColor
        vwAdultBack.layer.borderWidth = 1
        
        vwContinueBooking.clipsToBounds = true
        vwContinueBooking.layer.cornerRadius = 10
        vwContinueBooking.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        vwAdultBackHeight.constant = CGFloat(250*arrSeatSelected.count)
        tblAdultList.register(
            UINib(nibName: "TravellerNameCell", bundle: nil),
            forCellReuseIdentifier: "TravellerNameCell")
        lblFromToLocation.text = "\(strFromCity) - \(strCityTo)"
        lblDOJ.text = "\(strArrivalDate)"
        
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnContinueBookingAction(_ sender: Any) {
        createJsonString()
        configuration()
    }
    @IBAction func btnBusReviewAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "BusReviewVC") as! BusReviewVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnGSTNumberAction(_ sender: Any) {
        
    }
    @IBAction func btnAcceptAction(_ sender: Any) {
        
    }
    func showBookingSuccess(_ IntTrasactionID: String){
        let vw = BookingViewSuccess()
        vw.frame = UIScreen.main.bounds
        vw.delegate = self
        vw.setupUI(IntTrasactionID)
        view.addSubview(vw)
    }
    func createJsonString(){
        arrTraveller.removeAll()
        for var i in 0..<arrSeatSelected.count{
            let index = IndexPath(row:i, section: 0)
            let cell: TravellerNameCell = self.tblAdultList.cellForRow(at: index) as! TravellerNameCell
            if arrSeatSelected[i]["isGreen"].boolValue{
                let model = arrSeatSelected[i]
                arrTraveller.append(Traveller(title: "mr",
                                              fName: cell.txtFirstaName.text!,
                                              lName: cell.txtLastName.text!,
                                              seatNo: model["name"].stringValue,
                                              seatId: model["id"].stringValue,
                                              seatType: model["seatType"].stringValue,
                                              seatFare: model["fare"].intValue,
                                              age: Int(cell.txtAge.text!) ?? 0,
                                              gender: model["gender"].stringValue))
            }
        }
        print(arrTraveller)
        var arrCancel = dictBusSeatList["data"]["seatDetails"]["cancelPolicyList"].arrayValue
        for var i in 0..<arrCancel.count{
            arrCancelPolicy.append(CancelPolicy(timeFrom: arrCancel[i]["timeFrom"].intValue,
                                                timeTo: arrCancel[i]["timeTo"].intValue,
                                                percentageCharge: arrCancel[i]["percentageCharge"].intValue,
                                                flatCharge: arrCancel[i]["flatCharge"].intValue,
                                                isFlat: arrCancel[i]["isFlat"].boolValue,
                                                seatno: arrCancel[i]["seatno"].stringValue,
                                                Message: arrCancel[i]["Message"].stringValue))
        }
        let contactPerson = ContactPerson(mobile:Int(txtMobile.text!) ?? 0, email: strEmail)
        let boardingPoint = BoardingPoint(boardingName: strFromCity, boardingId: boardingId, boardingLoc: boardingLoc, boardingPoint: strBoardingPointName, boardingTime: strBoardingTime, boardingLandmark: boardingLandmark, boardingContactNo: boardingContactNo)
        let dropingPoint = DropingPoint(dropingPointId: dropingPointId, dropingPointName: strDropingPointName, dropingPointLoc: dropingPointLoc, dropingPointTime: strDropingTime)
        let busDetails = BusDetail(busid: tripID, busType: busType, arravialTime: strBoardingTime, departureTime: strDropingTime, duration: strDuration, travelName: strTraveller)
        let jsonString = TripDetails(skey:skey, sourceId: sourceID ?? 0, sourceCity: strFromCity, destinationId: destinationID ?? 0, destinationCity: strCityTo, journeyDate: strJourneyDate, tripId: tripID, routeId: routeId, engineId: engineID ?? 0, contact_person: contactPerson, bus_detail: busDetails, boarding_point: boardingPoint, droping_point: dropingPoint, markup: "0", commission: "", discount: "0", travellers: arrTraveller, cancelPolicyList: arrCancelPolicy, boarding_date: boarding_date, droping_date: droping_date)
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted // Optional: for pretty printed JSON data
            
            let jsonData = try encoder.encode(jsonString)
            // Use jsonData as needed (e.g., send it in a network request)
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Encoded JSON String:")
                print(jsonString)
                jsonStringbooking = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
    }
}
extension TravelDetailsVC:BookingViewSuccessDelegate{
    func backToHome() {
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        self.navigationController?.pushViewController(vc,animated: true)
    }
}
extension TravelDetailsVC:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSeatSelected.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "TravellerNameCell", for: indexPath) as! TravellerNameCell
        cell.selectionStyle = .none
        return cell
    }
    
}
extension TravelDetailsVC {
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
            busReviewViewModel.busReviewCall(jsonStringbooking ?? "")
        }else{
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internetconnection.")
            
        }
    }
    //MARK: Observing the data
    func observeEvent() {
        busReviewViewModel.eventHandler = { [weak self] event in
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
                    if self?.busReviewViewModel.busRevieweModel?.status == "success" {
                       // self?.showBookingSuccess(self?.busReviewViewModel.busRevieweModel?.data?.transactionid ?? 0)
                        self?.showBookingSuccess("127503310")
                    }
                    else{
                        self?.showErrorAlert(self?.busReviewViewModel.busRevieweModel?.message ?? "")
                    }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }
 
}
