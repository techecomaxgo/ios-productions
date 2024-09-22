//
//  SelectSeatsVC.swift
//  MaxPay
//
//  Created by india on 05/12/23.
//
struct GreenModel{
    let isGreen:Bool
}
struct ModelSeat{
    let strSeatColor1:String
    let strSeatColor2:String
    let strSeatNil:String
    let strSeatColor3:String
    let strSeatColor4:String
    
}

import UIKit
import SwiftLoader
import SwiftyJSON

class SelectSeatsVC: BaseVC {

    @IBOutlet weak var lblBusType: UILabel!
    @IBOutlet weak var lblBusName: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblSeatSelectedCount: UILabel!
    @IBOutlet weak var viewLowerCollectionBg: UIView!
    @IBOutlet weak var viewUpperCollectionBg: UIView!
//    @IBOutlet weak var vwTop: UIView!
    @IBOutlet weak var vwBook: UIView!
    @IBOutlet weak var collectionViewLowerSeats: UICollectionView!
    @IBOutlet weak var collectionViewUpperSeats: UICollectionView!
    
    @IBOutlet weak var btnBusSeat: UIButton!
    @IBOutlet weak var btnPickup: UIButton!
    @IBOutlet weak var btnDrop: UIButton!

    @IBOutlet weak var vwBusSeat: UIImageView!
    @IBOutlet weak var vwPickup: UIImageView!
    @IBOutlet weak var vwDrop: UIImageView!

    @IBOutlet weak var imgBusSeat: UIImageView!
    @IBOutlet weak var imgPickup: UIImageView!
    @IBOutlet weak var imgDrop: UIImageView!

    
    @IBOutlet weak var lblTotalHrs: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblStartLocation: UILabel!
    @IBOutlet weak var lblEndLocation: UILabel!
    
    @IBOutlet weak var tableSeatsView: UITableView!
    @IBOutlet weak var tablePickupDropoff: UITableView!
    @IBOutlet weak var btnContinue: UIButton!
    
//    var dictSelectedPickup = JSON()
//    var dictSelectedDropoff = JSON()
    var selectedBoardingIndex = -1
    var selectedDropIndex = -1
    
    var arrBoardingPointData:[JSON] = []
    var selectedTab = 0
    
    var strBusDuration = "",strBoardingTime = "",strDropingTime = "", strPrice = ""
    var cancelPolicyList = [JSON]()
    var sourceID:Int?
    var destinationID:Int?
    var engineID:Int?
    var seater:Bool?
    var slepper:Bool?
    var totalSeatPrice:Double?
    var serviceTaxAbsolute:Double?
    var baseFare: Double?
    private var seatDetailsViewModel = SeatDetailsViewModel()
//    var arrangeSeats = JSON()
    var arrLowerSeats = [[JSON]]()
    var arrUpperSeats = [[JSON]]()
//    var arrSeats = [[Any]]()
    var arrSeatSelected = [JSON]()
    
    var strCityTo = "",strFromCity = "",strJourneyDate = "",tripID = "",routeId = "",boarding_date = "",droping_date  = "",busid="",strDuration = "",boardingId = "",boardingLoc = "",boardingLandmark = "",boardingContactNo = "",dropingPointId = "",dropingPointLoc = "",busName = "",busType = "",strArrivalDate = "",strDepatureDate = "",strDOJ = "",dropingLandMark = "",DropingContact = "",strTraveller = "",strBoardingPointName = "",strDropingPointName = "", strSelectedBoardingTime = "", strSelectedDropingTime = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        lblTotalHrs.text = strBusDuration
        
        lblStartTime.text = Common.shared.convertTo12HourFormatIfNeeded(strBoardingTime)
        lblEndTime.text = Common.shared.convertTo12HourFormatIfNeeded(strDropingTime)

        lblStartLocation.text = strFromCity
        lblEndLocation.text = strCityTo
        
//        vwBook.addShadow(location: .top)
//        vwTop.addShadow(location: .bottom)
        lblBusName.text = busName
        lblBusType.text = busType
        lblTotalPrice.text = "0.00"
        lblSeatSelectedCount.text = ""
        
        // get-seat-details api call
        configuration()
        
        setDefautTabs(button: btnBusSeat, lineView: vwBusSeat, imgView: imgBusSeat, isSelected: true)
        setDefautTabs(button: btnPickup, lineView: vwPickup, imgView: imgPickup)
        setDefautTabs(button: btnDrop, lineView: vwDrop, imgView: imgDrop)

        tableSeatsView.isHidden = false
        tablePickupDropoff.isHidden = true
        
    }
    
    @IBAction func btnTabAction(_ sender: UIButton) {
        selectedTab = sender.tag
        btnContinue.tag = sender.tag
        
        setDefautTabs(button: btnBusSeat, lineView: vwBusSeat, imgView: imgBusSeat)
        setDefautTabs(button: btnPickup, lineView: vwPickup, imgView: imgPickup)
        setDefautTabs(button: btnDrop, lineView: vwDrop, imgView: imgDrop)
        
        setDefautTabs(button: selectedTab == 0 ? btnBusSeat : selectedTab == 1 ? btnPickup : btnDrop, lineView: selectedTab == 0 ? vwBusSeat : selectedTab == 1 ? vwPickup : vwDrop, imgView: selectedTab == 0 ? imgBusSeat : selectedTab == 1 ? imgPickup : imgDrop, isSelected: true)
        
        tableSeatsView.isHidden = sender.tag != 0
        tablePickupDropoff.isHidden = sender.tag == 0
        
        
        if sender.tag == 0 {
        
            btnContinue.setTitle("Next", for: .normal)
            
        } else if sender.tag == 1 {
            
            btnContinue.setTitle("Next", for: .normal)
            arrBoardingPointData = dictBusSeatList["data"]["seatDetails"]["listBoardingPoint"].arrayValue
            tablePickupDropoff.reloadData()
            
        } else if sender.tag == 2 {
            
            btnContinue.setTitle("Proceed", for: .normal)
            arrBoardingPointData = dictBusSeatList["data"]["seatDetails"]["listDropPoint"].arrayValue
            tablePickupDropoff.reloadData()
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
    
    @IBAction func btnContinueAction(_ sender: UIButton) {
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "BusReviewVC") as! BusReviewVC
//        vc.sourceID = sourceID
//        vc.strFromCity = strFromCity
//        vc.destinationID = destinationID
//        vc.strCityTo = strCityTo
//        vc.strJourneyDate = strJourneyDate
//        vc.tripID = tripID
//        vc.routeId = routeId
//        vc.engineID = engineID
//        vc.busName = busName
//        vc.busType = busType
//        vc.arrSeatSelected = arrSeatSelected
//        vc.strBoardingTime = strBoardingTime
//        vc.strDropingTime = strDropingTime
//        vc.strArrivalDate = strArrivalDate
//        vc.strDepatureDate = strDepatureDate
//        vc.totalSeatPrice = totalSeatPrice
//        vc.strTraveller = strTraveller
//        vc.strDuration = strBusDuration
//        self.navigationController?.pushViewController(vc, animated: true)
        
        if sender.tag == 0 {
            btnTabAction(btnPickup)
            sender.tag = 1
        } else if sender.tag == 1 {
            btnTabAction(btnDrop)
            sender.tag = 2
            sender.setTitle("Proceed", for: .normal)
        } else {
            
            if arrSeatSelected.count == 0 {
                self.showErrorAlert("Please Select Seat.")
                return
            } else if selectedBoardingIndex == -1 || selectedDropIndex == -1 {
                self.showErrorAlert("Please Select Pickup and Drop Point both.")
                return
            }
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "AddPassengerDetailsVC") as! AddPassengerDetailsVC
            vc.strBusDuration = strBusDuration
            vc.strBoardingTime = strBoardingTime
            vc.strDropingTime = strDropingTime
            vc.strFromCity = strFromCity
            vc.strCityTo = strCityTo
            vc.cancelPolicyList = cancelPolicyList
            vc.strPrice = strPrice
            vc.serviceTaxAbsolute = serviceTaxAbsolute
            vc.baseFare = baseFare
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
            vc.strDropingTime = strDropingTime
            vc.strArrivalDate = strArrivalDate
            vc.strDepatureDate = strDepatureDate
            vc.totalSeatPrice = totalSeatPrice
            vc.strTraveller = strTraveller
            vc.strDuration = strBusDuration
            
//            vc.strSelectedDropingTime = strSelectedDropingTime
            vc.dropingPointId = dropingPointId
            vc.dropingPointLoc = dropingPointLoc
            vc.dropingLandMark = dropingLandMark
            vc.DropingContact = DropingContact
            vc.strDropingPointName = strDropingPointName
//            vc.strSelectedBoardingTime = strSelectedBoardingTime
            vc.boardingId = boardingId
            vc.boardingLoc = boardingLoc
            vc.boardingLandmark = boardingLandmark
            vc.boardingContactNo = boardingContactNo
            vc.strBoardingPointName = strBoardingPointName
            
            
            
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func addSeat(){
        
        if dictBusSeatList["data"]["seatDetails"]["LowerShow"].boolValue == true {
            
            let firstColumn = dictBusSeatList["data"]["seatDetails"]["Lower"]["firstColumn"].arrayValue
            let secondColumn = dictBusSeatList["data"]["seatDetails"]["Lower"]["SecondColumn"].arrayValue
            let thirdColumn = dictBusSeatList["data"]["seatDetails"]["Lower"]["ThirdColumn"].arrayValue
            let fourColumn = dictBusSeatList["data"]["seatDetails"]["Lower"]["FourthColumn"].arrayValue
            let fiveColumn = dictBusSeatList["data"]["seatDetails"]["Lower"]["FifthColumn"].arrayValue
            let sixColumn = dictBusSeatList["data"]["seatDetails"]["Lower"]["SixthColumn"].arrayValue
            let sevenColumn = dictBusSeatList["data"]["seatDetails"]["Lower"]["seventhColumn"].arrayValue
            let eightColumn = dictBusSeatList["data"]["seatDetails"]["Lower"]["eightColumn"].arrayValue
            let nineColumn = dictBusSeatList["data"]["seatDetails"]["Lower"]["ninethColumn"].arrayValue
            let tenColumn = dictBusSeatList["data"]["seatDetails"]["Lower"]["tenthColumn"].arrayValue
            let elevenColumn = dictBusSeatList["data"]["seatDetails"]["Lower"]["eleventhColumn"].arrayValue
            let twelveColumn = dictBusSeatList["data"]["seatDetails"]["Lower"]["tevelthColumn"].arrayValue
            let thirtheenColumn = dictBusSeatList["data"]["seatDetails"]["Lower"]["thirteenColumn"].arrayValue
            let fourththeenColumn = dictBusSeatList["data"]["seatDetails"]["Lower"]["fourteenColumn"].arrayValue
            
            arrLowerSeats.append(firstColumn)
            arrLowerSeats.append(secondColumn)
            arrLowerSeats.append(thirdColumn)
            arrLowerSeats.append(fourColumn)
            arrLowerSeats.append(fiveColumn)
            arrLowerSeats.append(sixColumn)
            arrLowerSeats.append(sevenColumn)
            arrLowerSeats.append(eightColumn)
            arrLowerSeats.append(nineColumn)
            arrLowerSeats.append(tenColumn)
            arrLowerSeats.append(elevenColumn)
            arrLowerSeats.append(twelveColumn)
            arrLowerSeats.append(thirtheenColumn)
            arrLowerSeats.append(fourththeenColumn)
            
            viewLowerCollectionBg.isHidden = false
            collectionViewLowerSeats.reloadData()

        } else {
            viewLowerCollectionBg.isHidden = true
        }
        
        if dictBusSeatList["data"]["seatDetails"]["UpperShow"].boolValue == true {
            
            
            let firstColumnUpper = dictBusSeatList["data"]["seatDetails"]["Upper"]["firstColumn"].arrayValue
            let secondColumnUpper = dictBusSeatList["data"]["seatDetails"]["Upper"]["SecondColumn"].arrayValue
            let thirdColumnUpper = dictBusSeatList["data"]["seatDetails"]["Upper"]["ThirdColumn"].arrayValue
            let fourColumnUpper = dictBusSeatList["data"]["seatDetails"]["Upper"]["FourthColumn"].arrayValue
            let fiveColumnUpper = dictBusSeatList["data"]["seatDetails"]["Upper"]["FifthColumn"].arrayValue
            let sixColumnUpper = dictBusSeatList["data"]["seatDetails"]["Upper"]["SixthColumn"].arrayValue
            let sevenColumnUpper = dictBusSeatList["data"]["seatDetails"]["Upper"]["seventhColumn"].arrayValue
            let eightColumnUpper = dictBusSeatList["data"]["seatDetails"]["Upper"]["eightColumn"].arrayValue
            let nineColumnUpper = dictBusSeatList["data"]["seatDetails"]["Upper"]["ninethColumn"].arrayValue
            let tenColumnUpper = dictBusSeatList["data"]["seatDetails"]["Upper"]["tenthColumn"].arrayValue
            let elevenColumnUpper = dictBusSeatList["data"]["seatDetails"]["Upper"]["eleventhColumn"].arrayValue
            let twelveColumnUpper = dictBusSeatList["data"]["seatDetails"]["Upper"]["tevelthColumn"].arrayValue
            let thirtheenColumnUpper = dictBusSeatList["data"]["seatDetails"]["Upper"]["thirteenColumn"].arrayValue
            let fourththeenColumnUpper = dictBusSeatList["data"]["seatDetails"]["Upper"]["fourteenColumn"].arrayValue
            
            arrUpperSeats.append(firstColumnUpper)
            arrUpperSeats.append(secondColumnUpper)
            arrUpperSeats.append(thirdColumnUpper)
            arrUpperSeats.append(fourColumnUpper)
            arrUpperSeats.append(fiveColumnUpper)
            arrUpperSeats.append(sixColumnUpper)
            arrUpperSeats.append(sevenColumnUpper)
            arrUpperSeats.append(eightColumnUpper)
            arrUpperSeats.append(nineColumnUpper)
            arrUpperSeats.append(tenColumnUpper)
            arrUpperSeats.append(elevenColumnUpper)
            arrUpperSeats.append(twelveColumnUpper)
            arrUpperSeats.append(thirtheenColumnUpper)
            arrUpperSeats.append(fourththeenColumnUpper)
            
            viewUpperCollectionBg.isHidden = false
            collectionViewUpperSeats.reloadData()

        } else {
            viewUpperCollectionBg.isHidden = true
        }
        
    }
    
    
    func setDefautTabs(button: UIButton, lineView: UIImageView, imgView: UIImageView, isSelected: Bool = false) {
        
        lineView.isHidden = !isSelected
        
        button.setTitleColor(isSelected ? UIColor(hexString: "9FC438") : UIColor(hexString: "808080"), for: .normal)
        button.backgroundColor = .clear
        
        imgView.tintColor = isSelected ? UIColor(hexString: "9FC438") : UIColor(hexString: "808080")
    }
    
}

extension SelectSeatsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == collectionViewLowerSeats {
            return arrLowerSeats.count
        }
        return arrUpperSeats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewLowerSeats {
            return arrLowerSeats[section].count
        }
        return arrUpperSeats[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionViewLowerSeats.dequeueReusableCell(withReuseIdentifier: "SeatsCollVWCell", for: indexPath) as! SeatsCollVWCell
        cell.backgroundColor = .clear
        
        var model = JSON()
        
        if collectionView == collectionViewLowerSeats {
            
            model = arrLowerSeats[indexPath.section][indexPath.row]
            
        } else if collectionView == collectionViewUpperSeats {
            
            model = arrUpperSeats[indexPath.section][indexPath.row]
            
        }
        
        cell.configure(with: model)
        
//        let seatHidden = model["id"].stringValue
        
//        if model["available"].boolValue {
//                        
//            if  model["isGreen"].boolValue{
//                cell.backgroundColor = UIColor(named: "primary-green")
//            } else {
//                cell.backgroundColor = UIColor(named: "card-number-color")
//            }
//            
//            cell.layer.borderColor = UIColor.clear.cgColor
//            
//        } else {
//            cell.backgroundColor = UIColor(named: "grey-chip-color")
//            cell.layer.borderColor = UIColor.clear.cgColor
//        }


//        if model["seatType"].stringValue == "booked_sleeper" {
//            // Configure cell for sleeper seat
//            cell.pillowView.isHidden = false
//        } else {
//            cell.pillowView.isHidden = true
//        }

//        if indexPath.row == 2{
//            cell.isHidden = true
//        }else{
//            cell.isHidden = false
//        }
//        cell.lblSeatNumber.text = model["name"].stringValue
        
//        cell.imgSeat.isHidden = true
        
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if arrSeatSelected.count >= 6 {
            self.showErrorAlert("Maximum 6 seats can be selected")
            return
        }

        if collectionView == collectionViewLowerSeats {
            
            print("The section is:\(indexPath.section), row is :\(indexPath.row)")
            let index = IndexPath(row:indexPath.row, section: indexPath.section)
            let cell: SeatsCollVWCell = self.collectionViewLowerSeats.cellForItem(at: index) as! SeatsCollVWCell
            var model:JSON = arrLowerSeats[indexPath.section][indexPath.row]
            
            if model["available"].boolValue{
                if  model["isGreen"].boolValue{
                    model["isGreen"].boolValue = false
                }else{
                    model["isGreen"].boolValue = true
                }
                if  model["isGreen"].boolValue{
                    
//                    cell.seatView.backgroundColor = UIColor(named: "primary-green")
                    let price =  model["baseFare"].doubleValue + model["serviceTaxAbsolute"].doubleValue
                    baseFare = (baseFare ?? 0.00) + model["baseFare"].doubleValue
                    serviceTaxAbsolute = (serviceTaxAbsolute ?? 0.00) + model["serviceTaxAbsolute"].doubleValue
                    totalSeatPrice = (totalSeatPrice ?? 0.00) + price
                    lblTotalPrice.text = "₹\(totalSeatPrice ?? 0.00)"
                    
                    arrSeatSelected.append(model)
                }else{
                    
//                    cell.seatView.backgroundColor = .clear
                    
                    let price =  model["baseFare"].doubleValue + model["serviceTaxAbsolute"].doubleValue
                    baseFare = (baseFare ?? 0.00) - model["baseFare"].doubleValue
                    serviceTaxAbsolute = (serviceTaxAbsolute ?? 0.00) - model["serviceTaxAbsolute"].doubleValue
                    totalSeatPrice = (totalSeatPrice ?? 0.00) - price
                    lblTotalPrice.text = "₹\(totalSeatPrice ?? 0.00)"
                    
                    if let index = arrSeatSelected.firstIndex(where: {$0["seqNo"].stringValue == model["seqNo"].stringValue}) {
                        arrSeatSelected.remove(at: index)
                    }
                    
                }
                
                let seqNo = (arrSeatSelected.map{$0["seqNo"].stringValue}.joined(separator: ", "))

                lblSeatSelectedCount.text = "Seats Selected \(arrSeatSelected.count) - \(seqNo)"
                
                
                
            }else{
                showToast(message: "Alreacdy seat reserved", font: .systemFont(ofSize: 12))
            }
            arrLowerSeats[indexPath.section][indexPath.row] = model
            
            collectionViewLowerSeats.reloadData()
            
        } else {
            
            print("The section is:\(indexPath.section), row is :\(indexPath.row)")
            let index = IndexPath(row:indexPath.row, section: indexPath.section)
            
            var model:JSON = arrUpperSeats[indexPath.section][indexPath.row]
            
            if model["available"].boolValue{
                if  model["isGreen"].boolValue{
                    model["isGreen"].boolValue = false
                }else{
                    model["isGreen"].boolValue = true
                }
                if  model["isGreen"].boolValue{

                    let price =  model["baseFare"].doubleValue + model["serviceTaxAbsolute"].doubleValue
                    baseFare = (baseFare ?? 0.00) + model["baseFare"].doubleValue
                    serviceTaxAbsolute = (serviceTaxAbsolute ?? 0.00) + model["serviceTaxAbsolute"].doubleValue
                    totalSeatPrice = (totalSeatPrice ?? 0.00) + price
                    lblTotalPrice.text = "₹\(totalSeatPrice ?? 0.00)"
                    
                    arrSeatSelected.append(model)
                }else{

                    let price =  model["baseFare"].doubleValue + model["serviceTaxAbsolute"].doubleValue
                    baseFare = (baseFare ?? 0.00) - model["baseFare"].doubleValue
                    serviceTaxAbsolute = (serviceTaxAbsolute ?? 0.00) - model["serviceTaxAbsolute"].doubleValue
                    totalSeatPrice = (totalSeatPrice ?? 0.00) - price
                    lblTotalPrice.text = "₹\(totalSeatPrice ?? 0.00)"
                    
                    if let index = arrSeatSelected.firstIndex(where: {$0["seqNo"].stringValue == model["seqNo"].stringValue}) {
                        arrSeatSelected.remove(at: index)
                    }
                }
                
                let seqNo = (arrSeatSelected.map{$0["seqNo"].stringValue}.joined(separator: ", "))
                
                lblSeatSelectedCount.text = "Seats Selected \(arrSeatSelected.count) - \(seqNo)"
            }else{
                showToast(message: "Alreacdy seat reserved", font: .systemFont(ofSize: 12))
            }
            arrUpperSeats[indexPath.section][indexPath.row] = model
            
            collectionViewUpperSeats.reloadData()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 5.0
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let noOfCellsInRow = /*5*/ arrLowerSeats[indexPath.section].count
//
//            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
//
//            let totalSpace = flowLayout.sectionInset.left
//                + flowLayout.sectionInset.right
//                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

//            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
//
//            return CGSize(width: size , height: size)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        var model = JSON()
//        
//        if collectionView == collectionViewLowerSeats {
//            model = arrLowerSeats[indexPath.section][indexPath.row]
//        } else if collectionView == collectionViewUpperSeats {
//            model = arrUpperSeats[indexPath.section][indexPath.row]
//        }
//        
//        if model["seatStyle"].stringValue == "SL" {
//            return CGSize(width: 24, height: 44) // Size for sleeper seat
//        } else {
//            return CGSize(width: 24, height: 24) // Size for seater seat
//        }
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 18.0 // Distance between seats
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 18.0
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // Adjust as per your layout requirements
//    }
    
}
class SeatsCollVWCell: UICollectionViewCell {
    
    @IBOutlet weak var lblSeatNumber: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgSeat: UIImageView!
    
    @IBOutlet weak var seatView: UIView!
    @IBOutlet weak var pillowView: UIView!
    
    
    func configure(with seat: JSON) {

        seatView.layer.cornerRadius = 4
        
        let seatType = seat["seatType"].stringValue
        
        switch seatType {
        case "available":
            seatView.backgroundColor = UIColor.white
            seatView.layer.borderWidth = 1
            seatView.layer.borderColor = UIColor(named: "card-number-color")?.cgColor
        case "sleeper_normal": // set
            seatView.backgroundColor = UIColor.white
            seatView.layer.borderWidth = 1
            seatView.layer.borderColor = UIColor(named: "card-number-color")?.cgColor
        case "normal": // set
            seatView.backgroundColor = UIColor.white
            seatView.layer.borderWidth = 1
            seatView.layer.borderColor = UIColor(named: "card-number-color")?.cgColor
        case "blank": // set
            seatView.backgroundColor = .clear
            seatView.layer.borderColor = UIColor.clear.cgColor
        case "booked": // set
            seatView.backgroundColor = UIColor(named: "grey-chip-color")
            seatView.layer.borderColor = UIColor.clear.cgColor
        case "booked_sleeper": // set
            seatView.backgroundColor = UIColor(named: "grey-chip-color")
            seatView.layer.borderColor = UIColor.clear.cgColor
        case "booked_sleeperBack1": // set
            seatView.backgroundColor = UIColor(named: "grey-chip-color")
            seatView.layer.borderColor = UIColor.clear.cgColor
        
            
        case "ladies": // set
            seatView.backgroundColor = .clear
            seatView.layer.borderWidth = 1
            seatView.layer.borderColor = UIColor(named: "ladies-sit- border-red-color")?.cgColor
        case "selected": // set
            seatView.backgroundColor = UIColor(named: "primary-green")
            seatView.layer.borderColor = UIColor.clear.cgColor
        
        default:
            break
        }
        
        if seat["available"].boolValue {
                        
            if  seat["isGreen"].boolValue{
                seatView.backgroundColor = UIColor(named: "primary-green")
            } else {
                seatView.backgroundColor = UIColor(named: "card-number-color")
            }
            
            seatView.layer.borderColor = UIColor.clear.cgColor
            
        } else {
            seatView.backgroundColor = UIColor(named: "grey-chip-color")
            seatView.layer.borderColor = UIColor.clear.cgColor
        }

        if seat["seatStyle"].stringValue == "SL" {
            pillowView.isHidden = false
        } else {
            pillowView.isHidden = true
        }
    }
}

extension SelectSeatsVC {
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
          //  seatDetailsViewModel.seatDetailsCall(sourceId: 595, sourceCity: "Lucknow", destinationId: 1059, destinationCity: "Delhi", journeydate: "25-10-2023", tripId: "NXS-333-7427-1005692-1005922-20231225", routeId: "7427", seater: true, sleeper: false, engineId: 13)
            
            seatDetailsViewModel.seatDetailsCall(sourceId: sourceID ?? 0, sourceCity: strFromCity, destinationId: destinationID ?? 0, destinationCity: strCityTo, journeydate: strJourneyDate, tripId:tripID, routeId: routeId, seater: seater ?? false, sleeper: slepper ?? false, engineId: engineID ?? 0)
        }else{
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internetconnection.")
            
        }
    }
    //MARK: Observing the data
    func observeEvent() {
        seatDetailsViewModel.eventHandler = { [weak self] event in
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
                    if self?.seatDetailsViewModel.seatModel?.message == "success" {
                       // print("The seat is : \(self?.seatDetailsViewModel.seatDetailsModel?.data?.seatDetails?.lower?.fifthColumn ?? [])")
                        self?.addSeat()
                    }
                    else{
                        self?.showErrorAlert(self?.seatDetailsViewModel.seatDetailsModel?.message ?? "")
                    }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }
 
}

class PickupDropoffCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgSelection: UIImageView!
    
    @IBOutlet weak var imgUpperVerticalLine: UIImageView!
    @IBOutlet weak var imgLowerVerticalLine: UIImageView!
}

extension SelectSeatsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBoardingPointData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PickupDropoffCell
        cell.selectionStyle  = .none
        
        cell.imgUpperVerticalLine.isHidden = indexPath.row == 0
        cell.imgLowerVerticalLine.isHidden = indexPath.row == arrBoardingPointData.count - 1
        
        cell.lblTitle.text = selectedTab == 1 ? arrBoardingPointData[indexPath.row]["bdPoint"].stringValue : arrBoardingPointData[indexPath.row]["dpName"].stringValue
        
        cell.lblDetail.text = selectedTab == 1 ? arrBoardingPointData[indexPath.row]["bdLongName"].stringValue :  arrBoardingPointData[indexPath.row]["dpName"].stringValue
        
        cell.lblTime.text = selectedTab == 1 ? Common.shared.convertTo12HourFormatIfNeeded(arrBoardingPointData[indexPath.row]["time"].stringValue) : Common.shared.convertTo12HourFormatIfNeeded(arrBoardingPointData[indexPath.row]["dpTime"].stringValue)
        
        if selectedTab == 1 {
            cell.imgSelection.image = selectedBoardingIndex == indexPath.row ? UIImage(named: "circle-boarding-selected") : UIImage(named: "circle-boarding-notselected")
        } else if selectedTab == 2 {
            cell.imgSelection.image = selectedDropIndex == indexPath.row ? UIImage(named: "circle-boarding-selected") : UIImage(named: "circle-boarding-notselected")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedTab == 1 {
            
            if dictBusSeatList["data"]["seatDetails"]["listBoardingPoint"].arrayValue.count > 0 {
                                
                strSelectedBoardingTime =  dictBusSeatList["data"]["seatDetails"]["listBoardingPoint"][indexPath.row]["time"].stringValue
                boardingId  =  dictBusSeatList["data"]["seatDetails"]["listBoardingPoint"][indexPath.row]["bdid"].stringValue
                boardingLoc   =  dictBusSeatList["data"]["seatDetails"]["listBoardingPoint"][indexPath.row]["bdlocation"].stringValue
                boardingLandmark   =  dictBusSeatList["data"]["seatDetails"]["listBoardingPoint"][indexPath.row]["landmark"].stringValue
                boardingContactNo   =  dictBusSeatList["data"]["seatDetails"]["listBoardingPoint"][indexPath.row]["contactNumber"].stringValue
                strBoardingPointName = dictBusSeatList["data"]["seatDetails"]["listBoardingPoint"][indexPath.row]["bdPoint"].stringValue
                selectedBoardingIndex = indexPath.row
            }
            
        } else if selectedTab == 2 {
                        
            if dictBusSeatList["data"]["seatDetails"]["listDropPoint"].arrayValue.count > 0{
                strSelectedDropingTime =  dictBusSeatList["data"]["seatDetails"]["listDropPoint"][indexPath.row]["dpTime"].stringValue
                dropingPointId  =  dictBusSeatList["data"]["seatDetails"]["listDropPoint"][indexPath.row]["dpId"].stringValue
                dropingPointLoc   =  dictBusSeatList["data"]["seatDetails"]["listDropPoint"][indexPath.row]["locatoin"].stringValue
                dropingLandMark   =  dictBusSeatList["data"]["seatDetails"]["listDropPoint"][indexPath.row]["landmark"].stringValue
                DropingContact   =  dictBusSeatList["data"]["seatDetails"]["listDropPoint"][indexPath.row]["contactNumber"].stringValue
                strDropingPointName   =  dictBusSeatList["data"]["seatDetails"]["listDropPoint"][indexPath.row]["dpName"].stringValue
                selectedDropIndex = indexPath.row
            }
               
        }
        
//        if selectedTab == 1 {
//            dictSelectedPickup = arrBoardingPointData[indexPath.row]
//            
//        } else if selectedTab == 2 {
//            dictSelectedDropoff = arrBoardingPointData[indexPath.row]
//            
//        }
        tablePickupDropoff.reloadData()
        
    }
    
}
