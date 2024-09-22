//
//  AddPassengerDetailsVC.swift
//  MaxPay
//
//  Created by Ios Developer on 10/02/24.
//

import UIKit
import SwiftyJSON

class AddPassengerDetailsCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblGenderAge: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!

    func setData(object: Passenger) {
        lblName.text = (object.firstName ?? "") + " " + (object.lastName ?? "")
        lblGenderAge.text = "\(object.gender ?? ""), \(object.age ?? "")yrs age"
    }
}

struct Passenger: Codable {
    
    let firstName: String?
    let lastName: String?
    let gender: String?
    let age: String?
    
    enum CodingKeys: CodingKey {
        case firstName
        case lastName
        case gender
        case age
    }
}

class AddPassengerDetailsVC: BaseVC {

    @IBOutlet weak var tablePassenger: UITableView!
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnOther: UIButton!

    @IBOutlet weak var btnAddPassenger: UIButton!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblSeatSelectedCount: UILabel!
    
    var strBusDuration = ""
    var strBoardingTime = ""
    var strDropingTime = ""

    var strGender = ""
    var arrPassengers = [Passenger]()
    var cancelPolicyList = [JSON]()
    var strPrice = ""
    var sourceID:Int?

    var destinationID:Int?
    var engineID:Int?
    var arrSeatSelected = [JSON]()
    var canceleLationPolicy = [JSON]()
    var arrCancelPolicy = [CancelPolicy]()
    var arrTraveller = [Traveller]()
    var totalSeatPrice: Double?
    var serviceTaxAbsolute: Double?
    var baseFare: Double?

    var strCityTo = "",strFromCity = "",strJourneyDate = "",tripID = "",routeId = "",boarding_date = "",droping_date  = "",busid="",strDuration = "",boardingId = "",boardingLoc = "",boardingLandmark = "",boardingContactNo = "",dropingPointId = "",dropingPointLoc = "",busName = "",busType = "",strArrivalDate = "",strDepatureDate = "",strDOJ = "",dropingLandMark = "",DropingContact = "",strTraveller = "",strBoardingPointName = "",strDropingPointName = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        tablePassenger.tableFooterView = UIView()
        
        lblTotalPrice.text = "₹\(totalSeatPrice ?? 0.00)"
        lblSeatSelectedCount.text = "Seats Selected \(arrSeatSelected.count)"
    }
    
    @IBAction func btnGender(_ sender: UIButton) {
        
        btnMale.setImage(UIImage(named: "circle-boarding-notselected"), for: .normal)
        btnFemale.setImage(UIImage(named: "circle-boarding-notselected"), for: .normal)
        btnOther.setImage(UIImage(named: "circle-boarding-notselected"), for: .normal)
        
        sender.setImage(UIImage(named: "circle-boarding-selected"), for: .normal)
        strGender = sender.titleLabel?.text ?? ""
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func btnAddPassenger(_ sender: UIButton) {
        
        
        if txtFirstName.text == "" {
            self.showErrorAlert("Enter first name")
            return
        } else if txtLastName.text == "" {
            self.showErrorAlert("Enter last name")
            return
        } else if txtAge.text == "" {
            self.showErrorAlert("Enter age")
            return
        } else if strGender == "" {
            self.showErrorAlert("Select Gender")
            return
        }
        
        let passenger = Passenger(firstName: txtFirstName.text ?? "", lastName: txtLastName.text ?? "", gender: strGender, age: txtAge.text ?? "")
        
        if btnAddPassenger.titleLabel?.text == "Save" {
            arrPassengers[sender.tag] = passenger
        } else {
            arrPassengers.append(passenger)
        }
        
        txtFirstName.text = ""
        txtLastName.text = ""
        txtAge.text = ""
        strGender = ""

        btnMale.setImage(UIImage(named: "circle-boarding-notselected"), for: .normal)
        btnFemale.setImage(UIImage(named: "circle-boarding-notselected"), for: .normal)
        btnOther.setImage(UIImage(named: "circle-boarding-notselected"), for: .normal)
        
        tablePassenger.reloadData()
        btnAddPassenger.setTitle("Add New Passenger  +", for: .normal)
        
    }
    
    @IBAction func btnContinue(_ sender: Any) {
        
        if arrPassengers.count == 0 {
            self.showErrorAlert("Add \(arrSeatSelected.count) passengers detail.")
            return
        }
        
        if arrSeatSelected.count != arrPassengers.count {
            self.showErrorAlert("Selected seats are \(arrSeatSelected.count), but added passengers are \(arrPassengers.count). Please update it.")
            return
        }
        
        let vc = UIStoryboard(name: "USP", bundle: nil).instantiateViewController(withIdentifier: "ReviewBookingVC") as! ReviewBookingVC
        vc.strBusDuration = strBusDuration
        vc.strDropingTime = strDropingTime
        vc.arrPassengers = arrPassengers
        vc.cancelPolicyList = cancelPolicyList
        vc.strPrice = strPrice
        
        vc.baseFare = baseFare
        vc.serviceTaxAbsolute = serviceTaxAbsolute
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
        
        vc.strArrivalDate = strArrivalDate
        vc.strDepatureDate = strDepatureDate
        vc.totalSeatPrice = totalSeatPrice
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

extension AddPassengerDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPassengers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AddPassengerDetailsCell
        cell.selectionStyle = .none
        
        cell.setData(object: arrPassengers[indexPath.row])
        
        cell.btnEdit.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(btnEdit(_:)), for: .touchUpInside)
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(btnDelete(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func btnEdit(_ sender: UIButton) {
        
        btnAddPassenger.setTitle("Save", for: .normal)
        btnAddPassenger.tag = sender.tag
        
        txtFirstName.text = arrPassengers[sender.tag].firstName
        txtLastName.text = arrPassengers[sender.tag].lastName
        txtAge.text = arrPassengers[sender.tag].age
        
        strGender = arrPassengers[sender.tag].gender ?? ""
        
        btnMale.setImage(UIImage(named: "circle-boarding-notselected"), for: .normal)
        btnFemale.setImage(UIImage(named: "circle-boarding-notselected"), for: .normal)
        btnOther.setImage(UIImage(named: "circle-boarding-notselected"), for: .normal)
        
        if arrPassengers[sender.tag].gender == btnMale.titleLabel?.text {
            btnMale.setImage(UIImage(named: "circle-boarding-selected"), for: .normal)
        } else if arrPassengers[sender.tag].gender == btnFemale.titleLabel?.text {
            btnFemale.setImage(UIImage(named: "circle-boarding-selected"), for: .normal)
        } else if arrPassengers[sender.tag].gender == btnOther.titleLabel?.text {
            btnOther.setImage(UIImage(named: "circle-boarding-selected"), for: .normal)
        }
        
    }
    
    @objc func btnDelete(_ sender: UIButton) {
        arrPassengers.remove(at: sender.tag)
        tablePassenger.reloadData()
    }
    
}
