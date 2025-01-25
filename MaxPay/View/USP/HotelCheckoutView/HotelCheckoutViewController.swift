//
//  HotelCheckoutViewController.swift
//  MaxPay
//
//  Created by Admin on 06/06/24.
//

import UIKit

class HotelCheckoutViewController: UIViewController {
    
    private var bookHotel_ViewModel = BookHotel_ViewModel()

    var RoomhotelsData : Hotellist?

    
    @IBOutlet weak var viewTopGreenBack: UIView!
    
   var hotelName = ""
    var hotelLocation = ""
    
    var checkInDate = ""
    var checkOutDate = ""
    var nightsStr = ""
    
    var adultsChildStr = ""
    var roomTypeStr = ""
    
    var selectedCity = ""
    var guestcountstr = ""
    
    var pricestr = ""
    
    @IBOutlet weak var lblHotelsName: UILabel!
    
    @IBOutlet weak var lblHotelLocation: UILabel!
    
    
    @IBOutlet weak var lblCheckIn: UILabel!
    
    @IBOutlet weak var lblCheckout: UILabel!
    
    @IBOutlet weak var lblRoomType: UILabel!
    
    @IBOutlet weak var lblAdultsChild: UILabel!
    
    
    
    @IBOutlet weak var txtFirstName: UITextField!
    
    
    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var txtEmailId: UITextField!
    
    @IBOutlet weak var txtMobileNo: UITextField!
    
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblNights: UILabel!
    
   
    
    @IBOutlet private var multiRadioButton: [UIButton]!{
        didSet{
            multiRadioButton.forEach { (button) in
                button.setImage(UIImage(named:"circle-boarding-notselected"), for: .normal)
                button.setImage(UIImage(named:"circle-boarding-selected"), for: .selected)
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewTopGreenBack.layer.applyCornerRadiusShadow()
        
        lblHotelsName.text = hotelName
        
        lblCheckIn.text = checkInDate
        lblCheckout.text = checkOutDate
        
        lblHotelLocation.text = hotelLocation
        lblHotelLocation.text = hotelLocation
        
        lblNights.text = nightsStr
        
        lblRoomType.text = roomTypeStr
        
        
    }
    
    
    //Handle with single Action
    @IBAction private func guestRadioAction(_ sender: UIButton){
        uncheck()
        sender.checkboxAnimation {
            print(sender.titleLabel?.text ?? "")
            print(sender.isSelected)
        }
        
        // NOTE:- here you can recognize with tag weather it is `Male` or `Female`.
        print(sender.tag)
    }
    
    func uncheck(){
        multiRadioButton.forEach { (button) in
            button.isSelected = false
        }
    }
    
    
    
    
    
    @IBAction func btnBackClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func btnBookClicked(_ sender: UIButton) {
        
        validateFields()
        
       // HotelPaymentVC
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HotelPaymentVC") as! HotelPaymentVC
        
//        vc.SelectedRoomhotelsData = SelectedhotelsData
//        vc.checkInDate = lblcheckInDate.text ?? ""
//        vc.checkOutDate = lblCheckoutDate.text ?? ""
//        vc.nightsStr = lblNightcount.text ?? ""
//        vc.guestcountstr = guestcountstr
//        vc.selectedCity =  selectedCity
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    
    
    @objc func validateFields() {
           if isValidName(txtFirstName.text) &&
              isValidName(txtLastName.text) &&
              isValidEmail(txtEmailId.text) &&
              isValidMobile(txtMobileNo.text) {
               
               // Proceed with booking
               
               HotelBookingApi()
               
           } else {
               // Show validation error
               showAlert("Please enter valid information in all fields.")
           }
       }
       
       func isValidName(_ name: String?) -> Bool {
           guard let name = name else { return false }
           return name.count >= 1 // Add more specific validation if needed
       }
       
       func isValidEmail(_ email: String?) -> Bool {
           guard let email = email else { return false }
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailPred.evaluate(with: email)
       }
       
       func isValidMobile(_ mobile: String?) -> Bool {
           guard let mobile = mobile else { return false }
           let mobileRegEx = "^[0-9]{10}$"
           let mobilePred = NSPredicate(format: "SELF MATCHES %@", mobileRegEx)
           return mobilePred.evaluate(with: mobile)
       }
       
       func showAlert(_ message: String) {
           let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           present(alert, animated: true)
       }
    
    
    
    func HotelBookingApi() {
        
        
        
       //let hotelReservInfo =
       // let AdultDetails
        // let ChildDetails
        
        // Create hotelReservationInfo dictionary
        let hotelReservationInfo = createHotelReservationInfo(email: txtEmailId.text ?? "", homePhone: txtMobileNo.text ?? "", workPhone: txtMobileNo.text ?? "")

        let createHotelReservationInfo = createHotelReservationInfo(ageStr: "34", pasTypeStr: "0", prefixStr: "Mr", firstNameStr: "Chandan", lastNameStr: "Mishra")
        
        
        bookHotel_ViewModel.GetHotelBookApiCall(skeyStr: "AVJQIdwn79iR0zlP0iKNKumME", city: selectedCity, CheckInDate: checkInDate, CheckOutDate: checkOutDate, RoomCount: 1, hotelID: RoomhotelsData?.hotelID ?? "", engineID: RoomhotelsData?.engineType ?? 0, eMTCommonID: RoomhotelsData?.eMTCommonID ?? "", hotelName: RoomhotelsData?.hotelName ?? "", Adults: 2, Child: 0, Nights: 1, MealTypeStr: "Room Only", chargeableRateStr: 1771, RateCodeStr: "0002239716", RateKeyStr: "0002239716", RoomType: "Single Room Only", RoomTypeCode: "0000456306", CancellationPolicy: "Free Cancellation", hotelReservInfo: hotelReservationInfo, adultsDetails: createHotelReservationInfo, ChildDetails: [0])
        
        

        
    }
    
    
    // Function to create hotelReservationInfo dynamically
    func createHotelReservationInfo(email: String, homePhone: String, workPhone: String) -> [String: Any] {
        return [
            "Email": email,
            "homePhone": homePhone,
            "workPhone": workPhone
        ]
    }
    
    // Function to create AdultDetails dynamically
    
    func createHotelReservationInfo(ageStr: String, pasTypeStr: String, prefixStr: String,firstNameStr: String, lastNameStr: String) -> [String: Any] {
        return [
            "Age": ageStr,
            "PaxType": pasTypeStr,
            "Prefix": prefixStr,
            "firstName": firstNameStr,
            "lastName": lastNameStr,
        ]
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

extension UIButton {
    //MARK:- Animate check mark
    func checkboxAnimation(closure: @escaping () -> Void){
        guard let image = self.imageView else {return}
        self.adjustsImageWhenHighlighted = false
        self.isHighlighted = false
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            image.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.isSelected = !self.isSelected
                //to-do
                closure()
                image.transform = .identity
            }, completion: nil)
        }
        
    }
}
