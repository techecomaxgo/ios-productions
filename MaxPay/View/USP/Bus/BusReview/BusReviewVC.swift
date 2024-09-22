//
//  BusReviewVC.swift
//  MaxPay
//
//  Created by india on 06/12/23.
//

struct ContactPerson: Codable {
    let mobile: Int
    let email: String
}

struct BusDetail: Codable {
    let busid: String
    let busType: String
    let arravialTime: String
    let departureTime: String
    let duration: String
    let travelName: String
}

struct BoardingPoint: Codable {
    let boardingName: String
    let boardingId: String
    let boardingLoc: String
    let boardingPoint: String
    let boardingTime: String
    let boardingLandmark: String
    let boardingContactNo: String
}

struct DropingPoint: Codable {
    let dropingPointId: String
    let dropingPointName: String
    let dropingPointLoc: String
    let dropingPointTime: String
}

struct Traveller: Codable {
    let title: String
    let fName: String
    let lName: String
    let seatNo: String
    let seatId: String
    let seatType: String
    let seatFare: Int
    let age: Int
    let gender: String
}

struct CancelPolicy: Codable {
    let timeFrom: Int
    let timeTo: Int
    let percentageCharge: Int
    let flatCharge: Int
    let isFlat: Bool
    let seatno: String?
    let Message: String?
}

struct TripDetails: Codable {
    let skey: String
    let sourceId: Int
    let sourceCity: String
    let destinationId: Int
    let destinationCity: String
    let journeyDate: String
    let tripId: String
    let routeId: String
    let engineId: Int
    let contact_person: ContactPerson
    let bus_detail: BusDetail
    let boarding_point: BoardingPoint
    let droping_point: DropingPoint
    let markup: String
    let commission: String
    let discount: String
    let travellers: [Traveller]
    let cancelPolicyList: [CancelPolicy]
    let boarding_date: String
    let droping_date: String
}

import UIKit
import SwiftyJSON
import SwiftLoader
//import OlivePayLibrary
import MessageUI
import ObjectMapper

class BusReviewVC: BaseVC {

    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPromoCode: UITextField!
    @IBOutlet weak var btnNotInsureance: UIButton!
    @IBOutlet weak var btnSecureTrip: UIButton!
    @IBOutlet weak var lblSourceDate: UILabel!
    @IBOutlet weak var lblDestinationTimeTitle: UILabel!
    @IBOutlet weak var lblSourceTimeTitle: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblSource: UILabel!
    @IBOutlet weak var lblTwoDestination: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSourceToDestination: UILabel!
    @IBOutlet weak var lblBusType: UILabel!
    @IBOutlet weak var lblBusOperator: UILabel!
    @IBOutlet weak var lblTotalSeat: UILabel!
    @IBOutlet weak var lblDropingTime: UILabel!
    @IBOutlet weak var lblBoardingTime: UILabel!
    @IBOutlet weak var lblDroping: UILabel!
    @IBOutlet weak var lblBoarding: UILabel!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var vwPromoCodeHeightConstarint: NSLayoutConstraint!
    @IBOutlet weak var tblPromoCode: UITableView!
    @IBOutlet weak var btnRemove: DesignableButton!
    @IBOutlet weak var lblDestinationDate: UILabel!
    @IBOutlet weak var collVWClaim: UICollectionView!
    var intCount = 170
    let arrPromoCode = [1]
    var arrBoardingPointData:[String] = []
    var isBoarding:Bool?
    var strBusName = "",strBusType = "",strBoardingTime = "",strDropingTime = ""
    var engineId:Int?
    var strCityTo = "",strFromCity = "",strJourneyDate = "",tripID = "",routeId = "",boarding_date = "",droping_date  = "",busid="",strDuration = "",boardingId = "",boardingLoc = "",boardingLandmark = "",boardingContactNo = "",dropingPointId = "",dropingPointLoc = "",busName = "",busType = "",strArrivalDate = "",strDepatureDate = "",strDOJ = "",dropingLandMark = "",DropingContact = "",strTraveller = "",strBoardingPointName = "",strDropingPointName = ""
    var sourceID:Int?
    var destinationID:Int?
    var engineID:Int?
    var arrSeatSelected = [JSON]()
    var canceleLationPolicy = [JSON]()
    var arrCancelPolicy = [CancelPolicy]()
    var arrTraveller = [Traveller]()
    
    var jsonStringbooking:String?
    var totalSeatPrice:Double?
    override func viewDidLoad() {
        super.viewDidLoad()

        btnRemove.layer.borderColor = UIColor.black.cgColor
        intCount = intCount+(arrPromoCode.count*45)
        vwPromoCodeHeightConstarint.constant = CGFloat(intCount)
        tblHeightConstraint.constant = CGFloat((arrPromoCode.count*45)+15)
        lblDate.text = strJourneyDate
        lblSourceToDestination.text = "\(strFromCity) - \(strCityTo)"
        lblSource.text = strFromCity
        lblDestination.text = strCityTo
        lblBusOperator.text = busName
        lblBusType.text = busType
        lblTotalSeat.text = "Selected Seat\n   \(arrSeatSelected.count)"
        lblSourceTimeTitle.text = strBoardingTime
        lblDropingTime.text = strDropingTime
        lblSourceDate.text = Common.shared.dateFormaterShow(strArrivalDate)
        lblDestinationDate.text = Common.shared.dateFormaterShow(strDepatureDate)
        lblDate.text = Common.shared.dateFormaterShow(strDOJ)
        lblTotalPrice.text = "₹\(totalSeatPrice ?? 0)"
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSecureAction(_ sender: Any) {
        
    }
    @IBAction func btnNotInsuranceAction(_ sender: Any) {
        
    }
    
    @IBAction func btnDroppointAction(_ sender: Any) {
        isBoarding = false
        arrBoardingPointData.removeAll()
        var arrBoardingPoint = dictBusSeatList["data"]["seatDetails"]["listBoardingPoint"].arrayValue
        for var i in 0..<arrBoardingPoint.count{
            let model = arrBoardingPoint[i]
            arrBoardingPointData.append(model["bdLongName"].stringValue)
        }
        MyBasics.showListDropDown(Items:arrBoardingPointData , ParentViewC: self)
    }
    @IBAction func btnBoardingpointAction(_ sender: Any) {
        isBoarding = true
        arrBoardingPointData.removeAll()
        var arrBoardingPoint = dictBusSeatList["data"]["seatDetails"]["listDropPoint"].arrayValue
        for var i in 0..<arrBoardingPoint.count{
            let model = arrBoardingPoint[i]
            arrBoardingPointData.append(model["dpName"].stringValue)
        }
        MyBasics.showListDropDown(Items:arrBoardingPointData , ParentViewC: self)
    }
    @IBAction func btnContinueBookAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TravelDetailsVC") as! TravelDetailsVC
        vc.sourceID = sourceID
        vc.strFromCity = strFromCity
        vc.destinationID = destinationID
        vc.strCityTo = strCityTo
        vc.strJourneyDate = strJourneyDate
        vc.tripID = tripID
        vc.routeId = routeId
        vc.engineID = engineID
        vc.busName = busName
        vc.busType = busType
        vc.arrSeatSelected = arrSeatSelected
        vc.strBoardingTime = strBoardingTime
        vc.strDropingTime = lblDropingTime.text!
        vc.strArrivalDate = strArrivalDate
        vc.strDepatureDate = strDepatureDate
        vc.totalSeatPrice = totalSeatPrice
        vc.strBoardingName = lblBoarding.text!
        vc.strDropingName = lblDroping.text!
        vc.strEmail = txtEmail.text!
        vc.boardingId = boardingId
        vc.boardingLoc  = boardingLoc
        vc.boardingContactNo = boardingContactNo
        vc.boardingId = boardingId
        vc.boardingLandmark =  boardingLandmark
        vc.dropingPointId = dropingPointId
        vc.dropingPointLoc = dropingPointLoc
        vc.dropingLandMark = dropingLandMark
        vc.DropingContact = DropingContact
        vc.strTraveller = strTraveller
        vc.strDuration = strDuration
        vc.strBoardingPointName = strBoardingPointName
        vc.strDropingPointName = strDropingPointName
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
}
extension BusReviewVC:UITextFieldDelegate,CustomListDelegate{
    func GetSelectedPickerItemIndex(Index: Int) {
        if isBoarding ?? false{
            lblBoarding.text = arrBoardingPointData[Index]
            
            if dictBusSeatList["data"]["seatDetails"]["listBoardingPoint"].arrayValue.count > 0{
                lblBoardingTime.text =  dictBusSeatList["data"]["seatDetails"]["listBoardingPoint"][Index]["time"].stringValue
                boardingId  =  dictBusSeatList["data"]["seatDetails"]["listBoardingPoint"][Index]["bdid"].stringValue
                boardingLoc   =  dictBusSeatList["data"]["seatDetails"]["listBoardingPoint"][Index]["bdlocation"].stringValue
                boardingLandmark   =  dictBusSeatList["data"]["seatDetails"]["listBoardingPoint"][Index]["landmark"].stringValue
                boardingContactNo   =  dictBusSeatList["data"]["seatDetails"]["listBoardingPoint"][Index]["contactNumber"].stringValue
                strBoardingPointName   =  dictBusSeatList["data"]["seatDetails"]["listBoardingPoint"][Index]["bdPoint"].stringValue
               
                
            }
        }else{
            if dictBusSeatList["data"]["seatDetails"]["listDropPoint"].arrayValue.count > 0{
                lblDroping.text = arrBoardingPointData[Index]
                lblDropingTime.text =  dictBusSeatList["data"]["seatDetails"]["listDropPoint"][Index]["dpTime"].stringValue
                dropingPointId  =  dictBusSeatList["data"]["seatDetails"]["listDropPoint"][Index]["dpId"].stringValue
                dropingPointLoc   =  dictBusSeatList["data"]["seatDetails"]["listDropPoint"][Index]["locatoin"].stringValue
                dropingLandMark   =  dictBusSeatList["data"]["seatDetails"]["listDropPoint"][Index]["landmark"].stringValue
                DropingContact   =  dictBusSeatList["data"]["seatDetails"]["listDropPoint"][Index]["contactNumber"].stringValue
                strDropingPointName = dictBusSeatList["data"]["seatDetails"]["listDropPoint"][Index]["dpName"].stringValue
            }
            
        }
        
    }
}
extension BusReviewVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollVWClaimCell", for: indexPath) as! CollVWClaimCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10.0
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "BBPS", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CatagoryListVC") as! CatagoryListVC
        self.navigationController?.pushViewController(vc,animated: true)
    }
}
extension BusReviewVC:UITabBarDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPromoCode.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "PromoCodeCell", for: indexPath) as! PromoCodeCell
        cell.selectionStyle = .none
        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "TravelDetailsVC") as! TravelDetailsVC
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
}
class PromoCodeCell:UITableViewCell{
    
}

