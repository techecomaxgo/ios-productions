

import Foundation
import UIKit
import SwiftyJSON

let AppleID = "1577418265"
//let  getAlertMessageModel = [Singleton singleton].alertModel
let priceSymbal = "₹"
let RoundTheClock = "Round the clock"
let NotInternetMessage = "Unable to connect to the Internet"
let LocationServiceEnableMessage = " Location Service has to be enabled for this feature. Please allow the Location Service to 'While Using the App' from phone settings. "
let  UnableToConnect = ""
let kDateFormat = "yyyy/MM/dd hh:mm a"
//let getNSDateFormatter(strDateFormat) = [Utility getNSDateFormatterWithFormat :strDateFormat]
let isPad = UIDevice.current.userInterfaceIdiom

let  SCREEN_WIDTH  = UIScreen.main.bounds.size.width
let  SCREEN_HEIGHT  = UIScreen.main.bounds.size.height

let iPadStoryBoard_Port = "iPadMain_Port"
let iPadStoryBoard_Land = "iPadMain"
let iPhoneStoryBoard = "Main"//@"iPhoneMain"

let CMSCusDate = "CMSCustomisationDate"

let LastTouchTimeStamp = "lastTouchTimeStamp"
let UpdateLogo = "Update AppLogo"

let kArrSendMenuClick = ["room control", "tv control", "web radio", "chat", "hotel information", "experience itc hotel", "offers & promotion", "", "", "", "","", ""]
let AppStoreUpdateMajorPoUpStatement = "A new version of this App is available. Kindly update the App for a better experience."

let AppStoreUpdateMinorPoUpStatement = "A new version of this App is available. Kindly update the App for a better experience."

let FAndBBaseUrl = "https://oneapp.dev.smartler.in"
//let  FAndBBaseUrl = "https://oneapp.qa.smartler.in"
let MemberbenefitsURL = "https://www.itchotels.com/in/en/clubitc/membership-tiers"
let AboutClubITC = "https://www.itchotels.com/in/en/clubitc"
let offerURL = "https://www.itchotels.com/in/en/offers.html"
let LegalURL = "https://www.itchotels.com/in/en/terms"
let AboutusURL = "https://www.itchotels.com/in/en"
let termsCondURL = "https://www.itchotels.com/in/en/terms"
let collinairURl = "https://www.itchotels.com/in/en/clubitc-culinaire"
let ITCImagePath = FAndBBaseUrl + "/images/clubitc/icon/"
let termsCondURLITCLub = "https://www.itchotels.com/in/en/clubitc/terms"
let AppHeaderTitle = ""
//var FAndBBrownColor: UIColor {
//    Utility.getColorFromHexString("A4805F") ?? .black
//}
//var mdOBJStaticText : ModelStaticText!
//var mangeProfileModel: ManageProfileModel?
//var  profileModel:ProfileModel!
//var  voucherModel:VoucherModel!
//var  myActivityProModel:MyActivityProModel!
//var modelITCMMyClub:MyITCCLubModel?
//var orderDetailsListModel: OrderDetailsListModel?
//var reservationTableModel: ReservationTableModel?
//var mdOBJSelectedResturantGlobal : ModelSelectedResturant?
//var modelLegal:TermsConditionModel?
var strTotalGreenPoint:String?
var strDetailsAddress:String!
var GoogleApiKey = "AIzaSyAV6IxZimF0Gq5Curmy13jPrlV9lelxYE4"
var strFCMToken: String = ""

var dictBusList = JSON()
var dictBusSeatList = JSON()
var strBookingID:String?
var skey = "142418AgQWGaSEHXoQ58ae75c4"

//let AggregtorCode = "MAXPE"
//let MerchantId = "MAXPE"
//let MerchChanId = "OLIVEAPP"
//let SubMerchantId = "OLIVE"
//let MerchantVpa = "maxpe@axis"
//let MCC = "7322"

let PAY = "Pay"
let REQUEST = "Request"
let COLLECT_REQUEST_AMOUNT_LIMIT = 2000.00
let COLLECT_REQUEST_LIMIT_PERDAY = 5
let DEVICE_BINDING_LIMIT = 3
let MANDATE_APPROVE = "APPROVE"
let MANDATE_DECLINE = "DECLINE"

//let PaymentSuccessfulPageRedirect

//////DashBoardData
enum DashboardSection : Int {
    case DASHBOARD_SECTION_SEARCH = 0
    case DASHBOARD_SECTION_CIRCULAR
    case DASHBOARD_SECTION_SLIDER
    case DASHBOARD_SECTION_NONMEMBER
    case DASHBOARD_SECTION_OFFER
    case DASHBOARD_SECTION_BANNER // 0
     //1
    case DASHBOARD_SECTION_POPULAR //2
    case DASHBOARD_SECTION_WEASSURE // 3
    case TOTAL
}
enum DashboardFoodSection : Int {
    case DASHBOARD_SECTION_COLLINAIR = 0
    case DASHBOARD_SECTION_SEARCH
    case DASHBOARD_SECTION_SLIDER
    case DASHBOARD_SECTION_CIRCULAR
    case DASHBOARD_SECTION_COLLAPSE
    case Enroll
    case DASHBOARD_SECTION_SIGNATURE
    case DASHBOARD_SECTION_TRENDING
    case DASHBOARD_FAV
    case DASHBOARD_SECTION_LATESTOFFER
    case DASHBOARD_SECTION_BANNER
    case DASHBOARD_SECTION_WEASSURE
    case TOTAL
    
    
}

enum MenuLandigSection : Int {
    case DASHBOARD_FIRST = 0
    case DASHBOARD_SECOND
    case DASHBOARD_THIRD
    case TOTAL
}
enum CHECKOUTSECTION : Int {
//    case ORDERREVIEW = 0
//    case ITEMS
    case COMMENT = 0
    case OFFERDISCOUNT
    case OFFERDISCOUNTAPPLIED
    case ORDERMETHOD
    case ADDRESS
    case TAKEAWAY
    case SENDGIFT
    case SENDGIFTAPPLIED
    case BILLDETAILS
    case GREENPOINT
    case GREENPOINTAPPLIED
    case TOTALPRICE
    case SPECIALNOTE
    case TOTALSECTION
}
enum ExploreSection : Int {
    case Explore_Section_Hotel = 0
    case Explore_Section_Brands
    case Explore_Section_Offers
    case Explore_Section_UpCommingHotel
    case Explore_Section_Dinning
    case TOTAL
}
enum LundryLandingSection : Int {
    case Lundry_Section_Banner = 0
    case Lundry_Section_NearHotel
    case Lundry_Section_LatestOffer
    case Lundry_Section_Bottom
    case TOTAL
}
//var fcm_Token = ""

let deviceBounds:CGRect! = UIScreen.main.bounds
//MARK : AppDelegate instant
let appDel = UIApplication.shared.delegate as! AppDelegate

let genericDateFormatter = "dd MMM,yyyy"
///Mark: API
///let BaseUrl:String  = "https://www.pharmastoreom.com/admin/rest-api-post/index.php" //"https://ndlprojects.com/PharmaStore/rest-api-post/index.php"


//#pragma mark - Frame create and x,y,w h calculation
func getWidth(_ view: Any) -> CGFloat {
    (view as AnyObject).frame.width
}
func getHeight(_ view: Any) -> CGFloat {
    (view as AnyObject).frame.height
}
func getMinX(_ view: Any) -> CGFloat {
    (view as AnyObject).frame.minX
}
func getMinY(_ view: Any) -> CGFloat {
    (view as AnyObject).frame.minY
}
func getMaxX(_ view: Any) -> CGFloat {
    (view as AnyObject).frame.maxX
}
func getMaxY(_ view: Any) -> CGFloat {
    (view as AnyObject).frame.maxY
}



var shadowView = UIView()
var mulListV = MultipleSelecetionListPicker()
var listV = ListPickerView()
var dtPickerView = DatePickerView()

class MyBasics: NSObject {
    
    
    class func showPopup(Title:String?, Message:String?, InViewC:UIViewController?) {
        
        let popUpAlert = UIAlertController(title: Title!, message: Message!, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        popUpAlert.addAction(okAction)
        InViewC?.present(popUpAlert, animated: true, completion: nil)
        
    }
    class func isValidPhoneNumberByCountry(numberStr:String) -> Bool {
        
        let PHONE_REGEX = "^\\+[0-9]{10,16}$"
            //"^\\+(?:[0-9] ?){10,11}[0-9]$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: numberStr)
        return result
    }
    class func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    class func isValidPhoneNumber(numberStr:String) -> Bool {
        
        let PHONE_REGEX = "^[0-9]{10,15}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: numberStr)
        return result
    }
    
    class func isPasswordValid(passwordStr : String) -> Bool
    {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$&*%^&~ ]).{8,}$")
        return passwordTest.evaluate(with: passwordStr)
    }
    
    class func validateAmount(_ amount: String) -> Bool {
        // Check if the amount is not empty
        guard !amount.isEmpty else {
            return false
        }
        
        // Check if the amount is a valid number and contains at most 18 digits including 2 decimal places
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        let components = amount.components(separatedBy: CharacterSet(charactersIn: "0123456789\(decimalSeparator)"))
        let isValidAmount = components.count <= 2 && amount.count <= 21 // 18 digits including 2 decimal places
        
        return isValidAmount
    }
    
    class func isValidExpiryDate(expiryMonth: String, expiryYear: String) -> Bool {
        // Check if both month and year are non-empty and have 2 characters
        guard expiryMonth.count == 2, expiryYear.count == 2 else {
            return false
        }
        
        // Convert month and year strings to integers
        guard let month = Int(expiryMonth), let year = Int(expiryYear) else {
            return false
        }
        
        // Check if month is between 1 and 12
        guard (1...12).contains(month) else {
            return false
        }
        
        // Get the current year
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date()) % 100 // Get the last two digits of the current year
        
        // Check if year is greater than or equal to the current year
        guard year >= currentYear else {
            return false
        }
        
        // Expiry date is valid
        return true
    }
    
    class func heightForText(text:String!, viewWidth:CGFloat, font:UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: viewWidth, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height + 4
    }
    
    func makeShadowToChildView(shadowView:UIView)
    {
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(1.0))
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 4
    }
    
    // MARK: Multiple List picker
    
    class func showMultipleListDropDown(Items:Array<String>,selectedIncludedName:[Bool] ,ParentViewC:UIViewController) {
        
        shadowView = UIView(frame: deviceBounds)
        shadowView.backgroundColor = UIColor.black
        shadowView.alpha = 0.0
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(hideMultipleListView))
        tapGes.numberOfTapsRequired = 1
        shadowView.addGestureRecognizer(tapGes)
        mulListV = Bundle.main.loadNibNamed("ListPickerView", owner: ParentViewC, options: nil)?[1] as! MultipleSelecetionListPicker
        mulListV.frame = CGRect(x: 0, y: deviceBounds.size.height, width: deviceBounds.size.width, height: 227.0)
        ParentViewC.view.addSubview(shadowView)
        ParentViewC.view.addSubview(mulListV)
        ParentViewC.view.endEditing(true)
        mulListV.myDelegate = ParentViewC as? CustomListMultipleDelegate
        mulListV.ReloadPickerView(dataArray: Items,selectedIncludedName:selectedIncludedName)
        UIView.animate(withDuration: 0.3, animations: {
            
            shadowView.alpha = 0.3
            mulListV.frame = CGRect(x: 0, y: deviceBounds.size.height - 227.0, width: deviceBounds.size.width, height: 227.0)
            
        }, completion: nil)
        
    }
    
    @objc class func hideMultipleListView() {
        
        UIView.animate(withDuration: 0.3, animations: {
            shadowView.alpha = 0.0
            mulListV.frame = CGRect(x: 0, y: deviceBounds.size.height, width: deviceBounds.size.width, height: 227.0)
            
        }) { (Bool) in
            //listV.myDelegate?.ListDidHide!()
            shadowView.removeFromSuperview()
            mulListV.removeFromSuperview()
        }
    }
    
    
    
    // MARK: List picker
    class func showListDropDownFromView(Items:Array<String>, ParentViewC:UIView) {
        
        shadowView = UIView(frame: deviceBounds)
        shadowView.backgroundColor = UIColor.black
        shadowView.alpha = 0.0
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(hideListView))
        tapGes.numberOfTapsRequired = 1
        shadowView.addGestureRecognizer(tapGes)
        listV = Bundle.main.loadNibNamed("ListPickerView", owner: ParentViewC, options: nil)?.first as! ListPickerView
        listV.frame = CGRect(x: 0, y: deviceBounds.size.height, width: deviceBounds.size.width, height: 227.0)
        appDel.topViewControllerWithRootViewController(rootViewController: UIApplication.shared.keyWindow?.rootViewController)!.view.addSubview(shadowView)
        appDel.topViewControllerWithRootViewController(rootViewController: UIApplication.shared.keyWindow?.rootViewController)!.view.addSubview(listV)
        appDel.topViewControllerWithRootViewController(rootViewController: UIApplication.shared.keyWindow?.rootViewController)!.view.endEditing(true)
        listV.myDelegate = ParentViewC as? CustomListDelegate
        listV.ReloadPickerView(dataArray: Items)
        UIView.animate(withDuration: 0.3, animations: {
            
            shadowView.alpha = 0.3
            listV.frame = CGRect(x: 0, y: deviceBounds.size.height - 227.0, width: deviceBounds.size.width, height: 227.0)
            
        }, completion: nil)
        
    }
    class func showListDropDown(Items:Array<String>, ParentViewC:UIViewController) {
        
        
        shadowView = UIView(frame: deviceBounds)
        shadowView.backgroundColor = UIColor.black
        shadowView.alpha = 0.0
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(hideListView))
        tapGes.numberOfTapsRequired = 1
        shadowView.addGestureRecognizer(tapGes)
        listV = Bundle.main.loadNibNamed("ListPickerView", owner: ParentViewC, options: nil)?.first as! ListPickerView
        listV.frame = CGRect(x: 0, y: deviceBounds.size.height, width: deviceBounds.size.width, height: 227.0)
        ParentViewC.view.addSubview(shadowView)
        ParentViewC.view.addSubview(listV)
        ParentViewC.view.endEditing(true)
        listV.myDelegate = ParentViewC as? CustomListDelegate
        listV.ReloadPickerView(dataArray: Items)
        UIView.animate(withDuration: 0.3, animations: {
            
            shadowView.alpha = 0.3
            listV.frame = CGRect(x: 0, y: deviceBounds.size.height - 227.0, width: deviceBounds.size.width, height: 227.0)
            
        }, completion: nil)
        
        
    }
    
    @objc class func hideListView() {
        
        UIView.animate(withDuration: 0.3, animations: {
            
            shadowView.alpha = 0.0
            listV.frame = CGRect(x: 0, y: deviceBounds.size.height, width: deviceBounds.size.width, height: 227.0)
            
        }) { (Bool) in
            
            //listV.myDelegate?.ListDidHide!()
            shadowView.removeFromSuperview()
            listV.removeFromSuperview()
            
        }
    }
    
    
    // MARK: Date picker
    class func showDatePickerDropDownFromView(PickerType:UIDatePicker.Mode, ParentViewC:UIView) {
        
        shadowView = UIView(frame: deviceBounds)
        shadowView.backgroundColor = UIColor.black
        shadowView.alpha = 0.0
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(hideDatePickerView))
        tapGes.numberOfTapsRequired = 1
        shadowView.addGestureRecognizer(tapGes)
        dtPickerView = Bundle.main.loadNibNamed("ListPickerView", owner: ParentViewC, options: nil)?[2] as! DatePickerView
        dtPickerView.frame = CGRect(x: 0, y: deviceBounds.size.height, width: deviceBounds.size.width, height: 227.0)
        dtPickerView.dtPicker?.datePickerMode = PickerType
        dtPickerView.ReloadDatePickerView()
        appDel.topViewControllerWithRootViewController(rootViewController: UIApplication.shared.keyWindow?.rootViewController)!.view.addSubview(shadowView)
        appDel.topViewControllerWithRootViewController(rootViewController: UIApplication.shared.keyWindow?.rootViewController)!.view.addSubview(dtPickerView)
        appDel.topViewControllerWithRootViewController(rootViewController: UIApplication.shared.keyWindow?.rootViewController)!.view.endEditing(true)
        dtPickerView.delegate = ParentViewC as? DatePickerDelegate
        UIView.animate(withDuration: 0.3, animations: {
            
            shadowView.alpha = 0.3
            dtPickerView.frame = CGRect(x: 0, y: deviceBounds.size.height - 227.0, width: deviceBounds.size.width, height: 227.0)
            
        }, completion: nil)
        
    }
    class func showDatePickerDropDown(PickerType:UIDatePicker.Mode, ParentViewC:UIViewController) {
        
        shadowView = UIView(frame: deviceBounds)
        shadowView.backgroundColor = UIColor.black
        shadowView.alpha = 0.0
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(hideDatePickerView))
        tapGes.numberOfTapsRequired = 1
        shadowView.addGestureRecognizer(tapGes)
        dtPickerView = Bundle.main.loadNibNamed("ListPickerView", owner: ParentViewC, options: nil)?[2] as! DatePickerView
        dtPickerView.frame = CGRect(x: 0, y: deviceBounds.size.height, width: deviceBounds.size.width, height: 227.0)
        dtPickerView.dtPicker?.datePickerMode = PickerType
        ParentViewC.view.addSubview(shadowView)
        ParentViewC.view.addSubview(dtPickerView)
        ParentViewC.view.endEditing(true)
        dtPickerView.delegate = ParentViewC as? DatePickerDelegate
        
        UIView.animate(withDuration: 0.3, animations: {
            
            shadowView.alpha = 0.3
            dtPickerView.frame = CGRect(x: 0, y: deviceBounds.size.height - 227.0, width: deviceBounds.size.width, height: 227.0)
            
        }, completion: nil)
        
    }
    
    
    
    class func showFlightDatePickerDropDown(PickerType:UIDatePicker.Mode, ParentViewC:UIViewController) {
        
        shadowView = UIView(frame: deviceBounds)
        shadowView.backgroundColor = UIColor.black
        shadowView.alpha = 0.0
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(hideDatePickerView))
        tapGes.numberOfTapsRequired = 1
        shadowView.addGestureRecognizer(tapGes)
        dtPickerView = Bundle.main.loadNibNamed("ListPickerView", owner: ParentViewC, options: nil)?[2] as! DatePickerView
        dtPickerView.frame = CGRect(x: 0, y: deviceBounds.size.height, width: deviceBounds.size.width, height: 227.0)
        dtPickerView.dtPicker?.datePickerMode = PickerType
        ParentViewC.view.addSubview(shadowView)
        ParentViewC.view.addSubview(dtPickerView)
        ParentViewC.view.endEditing(true)
        dtPickerView.delegate = ParentViewC as? DatePickerDelegate
        
        UIView.animate(withDuration: 0.3, animations: {
            
            shadowView.alpha = 0.3
            dtPickerView.frame = CGRect(x: 0, y: deviceBounds.size.height - 437.0, width: deviceBounds.size.width, height: 227.0)
            
        }, completion: nil)
        
    }
    
    @objc class func hideDatePickerView() {
        
        UIView.animate(withDuration: 0.3, animations: {
            
            shadowView.alpha = 0.0
            dtPickerView.frame = CGRect(x: 0, y: deviceBounds.size.height, width: deviceBounds.size.width, height: 227.0)
            
        }) { (Bool) in
            
            //listV.myDelegate?.ListDidHide!()
            shadowView.removeFromSuperview()
            dtPickerView.removeFromSuperview()
            
        }
    }
    
 
    
    
}
