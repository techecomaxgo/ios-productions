//
//  ReviewBookingVC.swift
//  MaxPay
//
//  Created by Ios Developer on 11/02/24.
//

import UIKit
import SwiftyJSON
import SwiftLoader

class ReviewBookingCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    
}

class ReviewBookingVC: BaseVC {

    @IBOutlet weak var lblTotalHrs: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblStartLocation: UILabel!
    @IBOutlet weak var lblEndLocation: UILabel!
    @IBOutlet weak var tableSeatsView: UITableView!
    @IBOutlet weak var txtGST: UITextField!
    @IBOutlet weak var viewGSTLine: UIView!
    @IBOutlet weak var btnBookNow: UIButton!
    @IBOutlet weak var btnTravelTime: UIButton!
    @IBOutlet weak var txtPromoCode: UITextField!
    @IBOutlet weak var txtEmailId: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblSeatSelectedCount: UILabel!
    @IBOutlet weak var lblSeatSelectedCount2: UILabel!
    @IBOutlet weak var lblSeatSelectedType: UILabel!
    @IBOutlet weak var constraintTablePassengerHeight: NSLayoutConstraint!
    @IBOutlet weak var lblBusType: UILabel!
    @IBOutlet weak var lblBusName: UILabel!
    @IBOutlet weak var viewSuperView: UIView!

    var strBusDuration = ""
    var arrPassengers = [Passenger]()
    var cancelPolicyList = [JSON]()
    var strPrice = ""
    
    var arrSeatSelected = [JSON]()
    var arrTraveller = [Traveller]()
    private var busReviewViewModel = BusReviewViewModel()
    var strBoardingTime = "",strDropingTime = ""
    var engineId:Int?
    var strCityTo = "",strFromCity = "",strJourneyDate = "",tripID = "",routeId = "",boarding_date = "",droping_date  = "",busid="",strDuration = "",boardingId = "",boardingLoc = "",boardingLandmark = "",boardingContactNo = "",dropingPointId = "",dropingPointLoc = "",busName = "",busType = "",strArrivalDate = "",strDepatureDate = "",strDOJ = "",strBoardingName = "",strDropingName = "",dropingLandMark = "",DropingContact = "",strTraveller = "",strDropingPointName = "",strBoardingPointName = ""
    var sourceID:Int?
    var destinationID:Int?
    var engineID:Int?
    var canceleLationPolicy = [JSON]()
    var arrCancelPolicy = [CancelPolicy]()
    var jsonStringbooking:String?
    var totalSeatPrice:Double?
    var serviceTaxAbsolute: Double?
    var baseFare: Double?

    var termConditionFlag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblTotalHrs.text = strBusDuration
        
        lblStartTime.text = Common.shared.convertTo12HourFormatIfNeeded(strBoardingTime)
        lblEndTime.text = Common.shared.convertTo12HourFormatIfNeeded(strDropingTime)

        lblStartLocation.text = strFromCity
        lblEndLocation.text = strCityTo

        lblBusName.text = busName
        lblBusType.text = busType

        lblTotalPrice.text = "₹\(totalSeatPrice ?? 0.00)"
        lblSeatSelectedCount.text = "Seats Selected \(arrSeatSelected.count)"
        
        var seqNo = [String]()
        var seatStyle = [String]()
        for seat in arrSeatSelected {
            seqNo.append(seat["seqNo"].stringValue)
            seatStyle.append(seat["seatStyle"].stringValue)
        }
        
        let sleeperSeater = (seatStyle.contains("SL") && seatStyle.contains("ST")) ? "Sleeper & Seater" : seatStyle.contains("SL") ? "Sleeper" : "Seater"
        
        lblSeatSelectedCount2.text = "Seats Selected \(arrSeatSelected.count) \(sleeperSeater)"
        lblSeatSelectedType.text = seqNo.joined(separator: ", ")
        
        DispatchQueue.main.async {
            self.constraintTablePassengerHeight.constant = self.tableSeatsView.contentSize.height
        }

    }
    
    @IBAction func btnPriceBreakup(_ sender: UIButton) {
        let vw = PriceBreakup()
        vw.frame = UIScreen.main.bounds
        vw.strPassengersNo = "\(arrSeatSelected.count)"
        vw.strTotalBaseFare = "\(baseFare ?? 0.00)"
        vw.strGstOperatorFees = "\(serviceTaxAbsolute ?? 0.00)"
        vw.strDiscount = "₹0"
        vw.strInsurence = "₹0"
        vw.strGrandTotal = "₹\(totalSeatPrice ?? 0.00)"
        vw.setupUI()
        view.addSubview(vw)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnEditPassengerAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnCancellationPolicy(_ sender: UIButton) {
        let vw = BusCancallation()
        vw.frame = UIScreen.main.bounds
        vw.arrCancallationPolicyList = cancelPolicyList
        vw.setupUI()
        vw.price = strPrice
        view.addSubview(vw)
    }

    
    @IBAction func btnBookTravelRadio(_ sender: UIButton) {
        txtPromoCode.text = sender.titleLabel?.text ?? ""
        
        btnBookNow.setImage(UIImage(named: "circle-boarding-notselected"), for: .normal)
        btnTravelTime.setImage(UIImage(named: "circle-boarding-notselected"), for: .normal)
        
        sender.setImage(UIImage(named: "circle-boarding-selected"), for: .normal)
    }
    

    @IBAction func btnTermConditionCHeckboxAction(_ sender: UIButton) {
        sender.setImage(sender.tag == 0 ? UIImage(named: "check") : UIImage(named: "uncheck"), for: .normal)
        sender.tag = sender.tag == 0 ? 1 : 0
        termConditionFlag = sender.tag
    }

    @IBAction func btnGST(_ sender: UIButton) {
        
        sender.setImage(sender.tag == 0 ? UIImage(named: "check") : UIImage(named: "uncheck"), for: .normal)
        
        txtGST.isHidden = sender.tag == 0 ? false : true
        viewGSTLine.isHidden = sender.tag == 0 ? false : true
        
        sender.tag = sender.tag == 0 ? 1 : 0
    }

    @IBAction func brnTC(_ sender: Any) {
        openURL("https://maxpaywallet.com/term.html")
    }
    @IBAction func brnPrivacyPolicy(_ sender: Any) {
        openURL("https://maxpaywallet.com/privacy.html")
    }
    
    func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Check if the URL can be opened
        if UIApplication.shared.canOpenURL(url) {
            // Open the URL
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Cannot open URL")
        }
    }
    
    @IBAction func btnProceedAction(_ sender: Any) {
//        let vc = UIStoryboard(name: "USP", bundle: nil).instantiateViewController(withIdentifier: "BusTicketPaymentVC") as! BusTicketPaymentVC
//        self.navigationController?.pushViewController(vc, animated: true)
        
        if txtEmailId.text == "" {
            self.showErrorAlert("Enter email id")
            return
        } else if !MyBasics.validateEmail(enteredEmail: txtEmailId.text ?? "") {
            self.showErrorAlert("Enter valid Email Id")
            return
        } else if txtMobileNo.text == "" {
            self.showErrorAlert("Enter mobile number")
            return
        } else if !MyBasics.isValidPhoneNumber(numberStr: txtMobileNo.text ?? "") {
            self.showErrorAlert("Enter valid Mobile No.")
            return
        } else if termConditionFlag == 0 {
            self.showErrorAlert("Accept Term Condition and Privacy Policy")
            return
        }
        
        createJsonString()
        configuration()
    }

    func createJsonString(){
        arrTraveller.removeAll()
        for i in 0..<arrSeatSelected.count{
//            let index = IndexPath(row:i, section: 0)
//            let cell: TravellerNameCell = self.tblAdultList.cellForRow(at: index) as! TravellerNameCell
            
            
            if arrSeatSelected[i]["isGreen"].boolValue{
                let model = arrSeatSelected[i]
                arrTraveller.append(Traveller(title: "Mr",
                                              fName: arrPassengers[i].firstName ?? "",  //cell.txtFirstaName.text!,
                                              lName: arrPassengers[i].lastName ?? "", //cell.txtLastName.text!,
                                              seatNo: model["name"].stringValue,
                                              seatId: model["id"].stringValue,
                                              seatType: model["seatType"].stringValue,
                                              seatFare: model["fare"].intValue,
                                              age: Int(arrPassengers[i].age ?? "") ?? 0, //Int(cell.txtAge.text!) ?? 0,
                                              gender: model["gender"].stringValue))
            }
        }
        print(arrTraveller)
        let arrCancel = dictBusSeatList["data"]["seatDetails"]["cancelPolicyList"].arrayValue
        for i in 0..<arrCancel.count{
            arrCancelPolicy.append(CancelPolicy(timeFrom: arrCancel[i]["timeFrom"].intValue,
                                                timeTo: arrCancel[i]["timeTo"].intValue,
                                                percentageCharge: arrCancel[i]["percentageCharge"].intValue,
                                                flatCharge: arrCancel[i]["flatCharge"].intValue,
                                                isFlat: arrCancel[i]["isFlat"].boolValue,
                                                seatno: arrCancel[i]["seatno"].stringValue,
                                                Message: arrCancel[i]["Message"].stringValue))
        }
        let contactPerson = ContactPerson(mobile:Int(txtMobileNo.text ?? "") ?? 0, email: txtEmailId.text ?? "")
        
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

extension ReviewBookingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPassengers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ReviewBookingCell
        cell.selectionStyle = .none
        
        cell.lblName.text = ((arrPassengers[indexPath.row].gender ?? "") == "Male" ? "Mr." : "Mrs.") + " " + (arrPassengers[indexPath.row].firstName ?? "") + " " + (arrPassengers[indexPath.row].lastName ?? "")
        
        cell.lblAge.text = "Age \(arrPassengers[indexPath.row].age ?? "0") yrs"
        
        return cell
    }
    
    
}

extension ReviewBookingVC {
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

//                        self?.showBookingSuccess(127503310)
                        
                        let vc = UIStoryboard(name: "USP", bundle: nil).instantiateViewController(withIdentifier: "BusTicketPaymentVC") as! BusTicketPaymentVC
                //        self?.busReviewViewModel.busRevieweModel?.data?.transactionScreenId
                        
                        vc.transactionId = self?.busReviewViewModel.busRevieweModel?.data?.transactionid ?? ""
                        vc.validFor = self?.busReviewViewModel.busRevieweModel?.data?.validFor ?? ""
                        vc.paymentOf = "bus"
                        vc.totalSeatPrice = self?.busReviewViewModel.busRevieweModel?.data?.totalAmount ?? 0.00
                        vc.strPassenderName = (self?.arrPassengers.first?.firstName ?? "") + " " + (self?.arrPassengers.first?.lastName ?? "")
                        vc.strTotalSeat = "\(self?.arrSeatSelected.count ?? 0)"
                        vc.strTravelDate = self?.strJourneyDate ?? ""
                        vc.discount = self?.busReviewViewModel.busRevieweModel?.data?.discount ?? 0.00
                        vc.strGst = self?.serviceTaxAbsolute ?? 0.00
                        vc.baseFare = self?.baseFare ?? 0.00
                        vc.busName = self?.busName ?? ""

                        self?.navigationController?.pushViewController(vc, animated: true)
                        
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
 
    
    
//    func showBookingSuccess(_ IntTrasactionID:Int){
//        let vw = BookingViewSuccess()
//        vw.frame = UIScreen.main.bounds
//        vw.delegate = self
//        vw.setupUI(IntTrasactionID)
//        view.addSubview(vw)
//    }
}

//extension ReviewBookingVC: BookingViewSuccessDelegate {
//    func backToHome() {
////        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
////        let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
////        self.navigationController?.pushViewController(vc,animated: true)
//        
//        let vc = UIStoryboard(name: "USP", bundle: nil).instantiateViewController(withIdentifier: "BusTicketPaymentVC") as! BusTicketPaymentVC
////        self?.busReviewViewModel.busRevieweModel?.data?.transactionScreenId
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//}
