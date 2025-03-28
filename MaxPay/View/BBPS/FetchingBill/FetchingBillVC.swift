//
//  FetchingBillVC.swift
//  MaxPay
//
//  Created by india on 20/11/23.
//
/*
 {
     "input_type": "F",
     "skey": "142418AgQWGaSEHXoQ58ae75c4",
     "biller_id": "VEEG00000ERN0L",
     "customer_params_request": { "tags": [ { "name": "Student Unique ID", "value": "DDD123344"},
     { "name": "Mobile Number of Parent", "value": "1234567890"},{ "name": "DOB of Student(DDMMYYYY)", "value": "12091995"}] },
     "biller_name": "Veegaland Bliss Apartment Owners Association",
     "biller_category": "Housing Society",
     "macAdress": null,
     "customer_mob_number": "9987675470",
     "payment_channel": "Agent",
     "device_block_tags": [ { "name": "MOBILE", "value": "9987675470" }, { "name": "GEOCODE", "value": "28.6139,78.5555" }, { "name": "POSTAL_CODE", "value": "600001" }, { "name": "TERMINAL_ID", "value": "333001" }]
 }
 */
struct Fetech:Codable{
    var name:String
    var value:String
    
}

struct CustomerParamsValue:Encodable {
    struct Tag: Encodable {
        let name: String
        var value: String
    }
    
    let tags: [Tag]
}

struct DeviceLock:Encodable{
    let name:String
    let value:String
}
struct PaymentRequest: Encodable {
    let input_type: String
    let skey: String
    let biller_id: String
    let customer_params_request: CustomerParamsValue
    let biller_name: String
    let biller_category: String
    let macAdress: String
    let customer_mob_number: String
    let payment_channel: String
    let device_block_tags:[DeviceLock]
    
}
struct PaymentRequestPayment: Encodable {
    let skey: String
    let ref_id:String
    let bill_id:String
    let payment_mode:String
    let biller_id: String
    let customer_params_request: CustomerParamsValue
    let txn_amount:Int
    let biller_name: String
    let biller_category: String
    let macAdress: String
    let customer_mob_number: String
    let payment_channel: String
    let device_block_tags:[DeviceLock]
    
}
import UIKit
import CoreLocation

class FetchingBillVC: BaseVC {

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgCatagory: UIImageView!
    @IBOutlet weak var tblFetechBill: UITableView!
    
    var strBillerID = "",strCatagoryName = "",strImg = ""
    private var fetechBillViewModel = FetechBillViewModel()
   
  
    var fetchdata: ResponseDataPayU.Biller?

    var arrTag: [String: String] = [:]
    // Create a CLLocationManager instance
    let locationManager = CLLocationManager()
    var doubleLatitude:Double?
    var doubleLongitude:Double?
    var jsonstring:String?
    var strInputType:String?
    var bolIsFetech:Bool?
    var jsonStringPayment:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bolIsFetech = true
        lblName.text = strCatagoryName
        
        fetchdata?.customerParams?.forEach({
            arrTag[$0.paramName ?? ""] = ""
        })

        imgCatagory.image = UIImage(named: strImg)
        
        // Set up the location manager
        locationManager.delegate = self // Ensure your class conforms to CLLocationManagerDelegate
        locationManager.requestWhenInUseAuthorization() // Request location access

        // Check authorization status
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        tblFetechBill.showsVerticalScrollIndicator = false
        tblFetechBill.showsHorizontalScrollIndicator = false
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         configuration()
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func FetchingBill(_ sender: UIButton) {
        guard let fetchdata else { return }
        fetechBillViewModel.fetechBillCall(arrTag, providedData: fetchdata) { [weak self] result in
            switch result {
            case .success(let success):
                let storyboard = UIStoryboard(name: "BBPS", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "BillPaymentVC") as! BillPaymentVC
                vc.providedData = success.response
                self?.navigationController?.pushViewController(vc,animated: true)
            case .failure(let failure):
                self?.showErrorAlert("Please check your internetconnection.")
            }
        }
    }
    
    
}
extension FetchingBillVC: UITextFieldDelegate {

    // This method is called when a text field is about to begin editing
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let index = IndexPath(row: textField.tag, section: 0)
        let cell: FetechingTextfieldCell = self.tblFetechBill.cellForRow(at: index) as! FetechingTextfieldCell
        let customerParam = cell.cust_params_data

        // Set the keyboard type to numeric for credit card field
        if customerParam?.dataType == "CREDIT_CARD" {
            textField.keyboardType = .numberPad  // Set numeric keyboard for credit card
            textField.placeholder = "Enter Last 4 Digits"  // Show hint for credit card
        } else if customerParam?.dataType == "NUMERIC" {
            textField.keyboardType = .numberPad  // Set numeric keyboard for numeric fields
            textField.placeholder = "Enter Numbers Only"  // Show hint for numeric fields
        } else {
            textField.keyboardType = .default  // Default keyboard for other types
            textField.placeholder = "Enter Value"  // Generic placeholder for other types
        }

        return true
    }

    // This method is called when the user has finished editing the text field
    func textFieldDidEndEditing(_ textField: UITextField) {
        let index = IndexPath(row: textField.tag, section: 0)
        let cell: FetechingTextfieldCell = self.tblFetechBill.cellForRow(at: index) as! FetechingTextfieldCell
        let customerParam = cell.cust_params_data
        
        // Min/Max length validation after editing
        guard let minLength = customerParam?.minLength, let maxLength = customerParam?.maxLength else {
            return
        }

        if let text = textField.text, text.count < minLength || text.count > maxLength {
            print("Input length is out of range")
            // Optionally, display an error message or update UI here
        }
        if let customTag = fetchdata?.customerParams?[index.row] {
            let value = textField.text ?? ""
            arrTag[customTag.paramName ?? ""] = customTag.dataType == "ALPHANUMERIC" ? value.uppercased() : value
        }
    }

    // This method handles character changes in the text field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let index = IndexPath(row: textField.tag, section: 0)
        let cell: FetechingTextfieldCell = self.tblFetechBill.cellForRow(at: index) as! FetechingTextfieldCell
        let customerParam = cell.cust_params_data

        // If the field is for a credit card number, allow only 4 digits
        if customerParam?.dataType == "CREDIT_CARD" {
            let currentText = textField.text ?? ""
            let newLength = currentText.count + string.count - range.length
            if newLength > 4 {
                return false  // Restrict the length to 4 characters for card number
            }
            return true
        }

        // For numeric fields, allow only digits
        if customerParam?.dataType == "NUMERIC" {
            let allowedCharacterSet = CharacterSet.decimalDigits
            let filtered = string.unicodeScalars.filter { allowedCharacterSet.contains($0) }
            return filtered.count == string.count  // Only allow numeric input
        }

        return true
    }

    // Helper method to validate regex patterns (if needed for any input)
    func isValidregex(_ regex: String, input: String) -> Bool {
        let regexTest = try? NSRegularExpression(pattern: regex)
        let range = NSRange(location: 0, length: input.count)
        return regexTest?.firstMatch(in: input, options: [], range: range) != nil
    }
}

extension FetchingBillVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return fetchdata?.customerParams?.count ?? 0
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FetechingTextfieldCell", for: indexPath) as! FetechingTextfieldCell
            
            if let customerParams = fetchdata?.customerParams, indexPath.row < customerParams.count {
                let selectedCustomerParam = customerParams[indexPath.row]
                cell.cust_params_data = selectedCustomerParam
                cell.setCustParamsData(cust_params_data: selectedCustomerParam)
                
                // Handle input visibility and optional fields
                if !(selectedCustomerParam.visibility ?? true) {
                    cell.txtName.isHidden = true
                    cell.txtName.isEnabled = false
                } else {
                    cell.txtName.isHidden = false
                    cell.txtName.isEnabled = true
                }

                // Set min/max length filters for numeric fields
                if selectedCustomerParam.dataType == "NUMERIC" {
                    cell.txtName.delegate = self  // Set delegate to handle text changes
                    let maxLength = selectedCustomerParam.maxLength ?? 0
                    cell.txtName.addTarget(self, action: #selector(validateLength(_:)), for: .editingChanged)
                    cell.txtName.tag = indexPath.row
                }

                // For Credit Card, handle input length of 4 digits
                if selectedCustomerParam.dataType == "CREDIT_CARD" {
                    cell.txtName.delegate = self
                    cell.txtName.tag = indexPath.row
                }
            }

            cell.txtName.tag = indexPath.row
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FetechingBillCell", for: indexPath) as! FetechingBillCell
            cell.selectionStyle = .none
           // cell.btnBillFetech.addTarget(self, action: #selector(buttonClickMethod(_:)), for: .touchUpInside)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        } else {
            return 70
        }
    }

    // Length validation method (called when text changes)
    @objc func validateLength(_ textField: UITextField) {
        let index = IndexPath(row: textField.tag, section: 0)
        let cell: FetechingTextfieldCell = self.tblFetechBill.cellForRow(at: index) as! FetechingTextfieldCell
        let customerParam = cell.cust_params_data
        
        if let text = textField.text, let maxLength = customerParam?.maxLength, text.count > maxLength {
            // Handle case when input length exceeds the maxLength
            textField.text = String(text.prefix(maxLength))  // Trim input if it exceeds max length
        }
    }



//    @objc func buttonClickMethod(_ sender: UIButton) {
//        // Uncomment and modify the next lines according to your requirements
//        let fetechRequirement = fetechBillViewModel.fetechBillModel?.response_data?.fetchRequirement ?? ""
//        let supportedValidation = fetechBillViewModel.fetechBillModel?.response_data?.supportBillValidation ?? ""
//        bolIsFetech = false
//
//        // Iterate through each text field in the customer params and collect input values
//        for i in 0..<(fetechBillViewModel.fetechBillModel?.cust_params_data?.count ?? 0) {
//            let index = IndexPath(row: i, section: 0)
//            if let cell = self.tblFetechBill.cellForRow(at: index) as? FetechingTextfieldCell {
//                print(cell.txtName.text ?? "")
//                // Handle the input text from each cell here
//                // Instead of using `arrTag[i].value`, you can directly use the text value
//            }
//        }
//
//        // Conditional logic based on fetchRequirement and supportedValidation
//        if fetechRequirement == "MANDATORY" || fetechRequirement == "OPTIONAL" {
//            print("Fetech-Pay")
//            strInputType = "F"
//            createJsonString()
//            configuration()
//        } else if supportedValidation == "MANDATORY" || supportedValidation == "OPTIONAL" {
//            print("validate-Pay")
//            strInputType = "V"
//            createJsonString()
//            configuration()
//        } else if supportedValidation == "NOT_SUPPORTED" && fetechRequirement == "NOT_SUPPORTED" {
//            print("quick-Pay")
//            bolIsFetech = true
//            createJsonStringPayment()
//            configuration()
//        }
//    }


    func createJsonStringPayment() {
//        let amount = Int(fetechBillViewModel.fetechBillValidationModel?.fetch_data?.billerResponse?.amount ?? "0") ?? 0
//        let customerParams = CustomerParamsValue(tags:arrTag)
//        let paymentRequest = PaymentRequestPayment(skey: skey, ref_id:fetechBillViewModel.fetechBillValidationModel?.fetch_data?.refId ?? "", bill_id: fetechBillViewModel.fetechBillValidationModel?.fetch_data?.billId ?? "", payment_mode: "UPI", biller_id: fetechBillViewModel.fetechBillModel?.response_data?.billerId ?? "", customer_params_request: customerParams, txn_amount:amount, biller_name: fetechBillViewModel.fetechBillModel?.response_data?.billerName ?? "", biller_category: fetechBillViewModel.fetechBillModel?.response_data?.billerCategoryName ?? "", macAdress: Common.shared.getDeviceID(), customer_mob_number: Common.shared.phoneNo ?? "", payment_channel: "Agent", device_block_tags: [DeviceLock(name: "MOBILE", value: Common.shared.phoneNo ?? ""),DeviceLock(name: "GEOCODE", value: Common.shared.getDeviceID()),DeviceLock(name: "POSTAL_CODE", value: Common.shared.getPostalCode(doubleLatitude ?? 0.00, doubleLongitude ?? 0.00)),DeviceLock(name: "TERMINAL_ID", value: "333001")])
//        do {
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted // Optional: for pretty printed JSON data
//            
//            let jsonData = try encoder.encode(paymentRequest)
//            // Use jsonData as needed (e.g., send it in a network request)
//            
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                print("Encoded JSON String:")
//                print(jsonString)
//                jsonStringPayment = jsonString
//            }
//        } catch {
//            print("Error encoding JSON: \(error)")
//        }
    }
    
    func createJsonString() {
        
//        let customerParams = CustomerParamsValue(tags:arrTag)
        
//        let paymentRequest = PaymentRequest(input_type: strInputType ?? "", skey: skey, biller_id: fetechBillViewModel.fetechBillModel?.response_data?.billerId ?? "", customer_params_request: customerParams, biller_name: fetechBillViewModel.fetechBillModel?.response_data?.billerName ?? "", biller_category:fetechBillViewModel.fetechBillModel?.response_data?.billerCategoryName ?? "", macAdress: Common.shared.getDeviceID(), customer_mob_number: Common.shared.phoneNo ?? "", payment_channel: "Agent", device_block_tags: [DeviceLock(name: "MOBILE", value: Common.shared.phoneNo ?? ""),DeviceLock(name: "GEOCODE", value: Common.shared.getDeviceID()),DeviceLock(name: "POSTAL_CODE", value: Common.shared.getPostalCode(doubleLatitude ?? 0.00, doubleLongitude ?? 0.00)),DeviceLock(name: "TERMINAL_ID", value: "333001")])
//        
//        do {
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted // Optional: for pretty printed JSON data
//            
//            let jsonData = try encoder.encode(paymentRequest)
//            // Use jsonData as needed (e.g., send it in a network request)
//            
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                print("Encoded JSON String:")
//                print(jsonString)
//                jsonstring = jsonString
//            }
//        } catch {
//            print("Error encoding JSON: \(error)")
//        }
    }
}

extension FetchingBillVC {
    //MARK: API Calling
    func configuration() {
        // ProgressHUD.showSucceed()
        initViewModel()
       // observeEvent()
    }
    //MARK Network checking
    func initViewModel() {
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true && bolIsFetech == true{
//            fetechBillViewModel.fetechBillCall(strBillerID, providedData: fetchdata)
        } else if isConnected == true && bolIsFetech == false{
           // fetechBillViewModel.fetechBillValidationCall(jsonstring ?? "")
        }else if bolIsFetech  == true{
           // fetechBillViewModel.fetechBillValidationPaymentCall(jsonStringPayment ?? "")
        }
        else{
//              ProgressHUD.remove()
            self.showErrorAlert("Please check your internetconnection.")
            
        }
    }
    //MARK: Observing the data
//    func observeEvent() {
//       // let loader =   self.loader()
//        
//        fetechBillViewModel.eventHandler = { [weak self] event in
//            guard self != nil else { return }
//            
//            switch event {
//            case .loading:
//                
//                print("loading....")
//             //   self?.stopLoader(loader: loader)
//            case .stopLoading:
//                
//                print("Stop loading...")
//              //  self?.stopLoader(loader: loader)
//            case .dataLoaded:
//                print("Data loaded...")
//               // self?.stopLoader(loader: loader)
//                if self?.fetechBillViewModel.fetechBillModel?.status == "success" && self?.bolIsFetech == true{
//                    let count = self?.fetechBillViewModel.fetechBillModel?.cust_params_data?.count ?? 0
//                    for i in 0..<count {
//                        self?.arrTag.append(CustomerParamsValue.Tag(name: self?.fetechBillViewModel.fetechBillModel?.cust_params_data?[i].customParamName ?? "", value: ""))
//                    }
//                        self?.tblFetechBill.reloadData()
//                    }
//                else if self?.fetechBillViewModel.fetechBillValidationModel?.status == "success" && self?.bolIsFetech == true{
//                    self?.showErrorAlert("Success")
//                }
//                else{
//                    if self?.bolIsFetech ?? false{
//                        self?.showErrorAlert("Success")
//                    }else{
//                        self?.showErrorAlert("Please try after some time")
//                    }
//                        
//                    }
//                   // self?.stopLoader(loader: loader)
//            case .error(let error):
//                print(error!)
//               // self?.stopLoader(loader: loader)
//            }
//        }
//    }
}

extension FetchingBillVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        print("Latitude: \(latitude), Longitude: \(longitude)")
        
        // Stop updating location to conserve battery
        locationManager.stopUpdatingLocation()
        doubleLatitude = latitude
        doubleLongitude = longitude
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
}
