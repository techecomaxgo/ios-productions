//
//  BusSearchListVC.swift
//  MaxPay
//
//  Created by india on 05/12/23.
//

import UIKit
import SwiftyJSON

class BusSearchListVC: BaseVC {
    
    @IBOutlet weak var lblNoOfBus: UILabel!
    @IBOutlet weak var lblProvider: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var vwLocation: UIView!
    @IBOutlet weak var vwTop: UIView!
    
    var strCityTo = "",strFromCity = "",strJourneyDate = "",tripID = "",routeId = ""
    var sourceID:Int?
    var destinationID:Int?
    var engineID:Int?
    var seater:Bool?
    var slepper:Bool?
    var arrBusList = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrBusList = dictBusList["buslist"]["AvailableTrips"].arrayValue
        
        vwTop.layer.applyCornerRadiusShadow()
        vwTop.layer.cornerRadius = 4
        vwTop.layer.borderColor = UIColor.black.cgColor
        vwTop.layer.borderWidth = 1
        
        lblDate.text = strJourneyDate
        lblTitle.text = "\(strFromCity)   →   \(strCityTo)"
        lblNoOfBus.text = "Bus \(arrBusList.count)"
        lblPrice.text = "₹\(dictBusList["buslist"]["MinPrice"].stringValue) - ₹\(dictBusList["buslist"]["MaxPrice"].stringValue)"
    }
    
    @IBAction func btnModifySearchBusAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        return
        
//        let vw = ModificationSearchBus()
//        vw.frame = UIScreen.main.bounds
//        vw.cities = (busSearchCityViewModel.cityModel?.cities)!
//        vw.delegate = self
//        vw.arrCity = arrCity
//        vw.setupUI()
//        view.addSubview(vw)
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension BusSearchListVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBusList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusListCell", for: indexPath) as! BusListCell
        cell.selectionStyle = .none
        
        cell.lblBusName.text = arrBusList[indexPath.row]["Travels"].stringValue
        cell.lblBusType.text = arrBusList[indexPath.row]["busType"].stringValue
        cell.lblStartTime.text = Common.shared.convertTo12HourFormatIfNeeded(arrBusList[indexPath.row]["departureTime"].stringValue)
        cell.lblEndTime.text = Common.shared.convertTo12HourFormatIfNeeded(arrBusList[indexPath.row]["ArrivalTime"].stringValue)
        cell.lblTotalHrs.text = arrBusList[indexPath.row]["duration"].stringValue
        
        cell.lblTotalSeat.text = "\(arrBusList[indexPath.row]["AvailableSeats"].stringValue) Seats Left"
        cell.lblTotalSeat.textColor = (arrBusList[indexPath.row]["AvailableSeats"].floatValue < 5) ? UIColor.init(named: "text-red-color") : UIColor.init(named: "primary-green")
        
        cell.lblTotalPrice.text = "₹\(arrBusList[indexPath.row]["price"].stringValue)/-"
        
        if arrBusList[indexPath.row]["rt"] != "" && arrBusList[indexPath.row]["rt"] != JSON.null {
            cell.vwRate.isHidden = false
            cell.lblBusRate.text = "★\(arrBusList[indexPath.row]["rt"].stringValue)"
            cell.vwRate.backgroundColor = (arrBusList[indexPath.row]["rt"].floatValue < 3) ? UIColor.init(named: "text-red-color") : UIColor.init(named: "primary-green")
        } else {
            cell.vwRate.isHidden = true
        }
        
        cell.lblStartLocation.text = strFromCity
        cell.lblEndLocation.text = strCityTo
        
        cell.btnCancellationPolicy.tag = indexPath.row
        cell.btnCancellationPolicy.addTarget(self, action: #selector(btnCancellationPolicy(_:)), for: .touchUpInside)
        
        cell.btnBoardingPoint.tag = indexPath.row
        cell.btnBoardingPoint.addTarget(self, action: #selector(btnBoardingPoint(_:)), for: .touchUpInside)
        
        cell.btnDroppingPoint.tag = indexPath.row
        cell.btnDroppingPoint.addTarget(self, action: #selector(btnDroppingPoint(_:)), for: .touchUpInside)
        
        cell.lstAmenities = arrBusList[indexPath.row]["lstamenities"].arrayValue
        cell.collectionAmenities.reloadData()
        
        
//        if arrBusList[indexPath.row]["duration"].boolValue {
//            cell.lblFreeCancellation.isHidden = false
//        }else{
//            cell.lblFreeCancellation.isHidden = true
//        }
//        if arrBusList[indexPath.row]["liveTrackingAvailable"].boolValue {
//            cell.lblLiveTracking.isHidden = false
//        }else{
//            cell.lblFreeCancellation.isHidden = true
//        }
//        if arrBusList[indexPath.row]["isCancellable"].boolValue {
//            cell.lblFreeCancellation.isHidden = false
//        }else{
//            cell.lblFreeCancellation.isHidden = true
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SelectSeatsVC") as! SelectSeatsVC
        
        vc.strFromCity = strFromCity
        vc.strCityTo = strCityTo
        vc.sourceID = sourceID
        vc.destinationID = destinationID
        vc.strJourneyDate = strJourneyDate
        vc.engineID = arrBusList[indexPath.row]["engineId"].intValue
        vc.seater = arrBusList[indexPath.row]["seater"].boolValue
        vc.slepper = arrBusList[indexPath.row]["sleeper"].boolValue
        vc.tripID = arrBusList[indexPath.row]["id"].stringValue
        vc.routeId = arrBusList[indexPath.row]["routeId"].stringValue
        vc.busName = arrBusList[indexPath.row]["Travels"].stringValue
        vc.busType = arrBusList[indexPath.row]["busType"].stringValue
        vc.strBusDuration = arrBusList[indexPath.row]["duration"].stringValue
        vc.strBoardingTime = arrBusList[indexPath.row]["departureTime"].stringValue
        vc.strDropingTime = arrBusList[indexPath.row]["ArrivalTime"].stringValue
        vc.strArrivalDate = arrBusList[indexPath.row]["arrivalDate"].stringValue
        vc.strDepatureDate = arrBusList[indexPath.row]["departureDate"].stringValue
        vc.strDOJ = arrBusList[indexPath.row]["doj"].stringValue
        vc.strTraveller = arrBusList[indexPath.row]["Travels"].stringValue
        vc.cancelPolicyList = arrBusList[indexPath.row]["cancelPolicyList"].arrayValue
        vc.strPrice = arrBusList[indexPath.row]["price"].stringValue
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnCancellationPolicy(_ sender: UIButton) {
        let vw = BusCancallation()
        vw.frame = UIScreen.main.bounds
        vw.arrCancallationPolicyList = arrBusList[sender.tag]["cancelPolicyList"].arrayValue
        vw.setupUI()
        vw.price = arrBusList[sender.tag]["price"].stringValue
        view.addSubview(vw)
    }
    
    @objc func btnBoardingPoint(_ sender: UIButton) {
        let arrdpPoints = arrBusList[sender.tag]["bdPoints"].arrayValue
        let vw = BoardingDropOff()
        vw.frame = UIScreen.main.bounds
        vw.arrPoints = arrdpPoints
        vw.setupUI()
        vw.isBoarding = true
        view.addSubview(vw)
    }
    
    @objc func btnDroppingPoint(_ sender: UIButton) {
        let arrdpPoints = arrBusList[sender.tag]["dpPoints"].arrayValue
        let vw = BoardingDropOff()
        vw.frame = UIScreen.main.bounds
        vw.arrPoints = arrdpPoints
        vw.setupUI()
        view.addSubview(vw)
    }
    
}
