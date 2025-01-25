//
//  Common.swift
//  MaxPay
//
//  Created by india on 08/11/23.
//

import UIKit
import CoreLocation
import Foundation
import Security
let defaults = UserDefaults.standard
class Common {
    
    static let shared = Common()
    private init(){}
    
     var primaryAccRefNumber: String = ""

    
    
    let PHONE_NUMBER   = "PHONE_NUMBER"
    
    let UMobile_NUMBER   = "MOBILE_NUMBER"
    let UserImage   = "User_Image"

    let ISLOGGEDIN   = "ISLOGGEDIN"
    let ISINTRO   = "ISINTRO"
    let TOKEN = "TOKEN"
    let PRIMARYWALLETBALANCE = "PRIMARYWALLETBALANCE"
    let SECONDARYWALLETBALANCE = "SECONDARYWALLETBALANCE"
    let SUMWALLETBALANCE = "SUMWALLETBALANCE"

    let FCMTOKEN = "FCMTOKEN"
    let USERFIRSTNAME = "USERFIRSTNAME"
    let USERLASTNAME = "USERLASTNAME"
    let MERCHANTAUTHTOKEN = "MERCHANTAUTHTOKEN"
    let UNIQUEMERCHANTAUTHTOKEN = "UNIQUEMERCHANTAUTHTOKEN"
    let MY_CARDS = "MY_CARDS"
    let BBPS_FAVOURITE_CATEGORY = "BBPS_FAVOURITE_CATEGORY"
    let RECENT_CONTACTS = "RECENT_CONTACTS"
    let RECENT_REQUEST_CONTACTS = "RECENT_REQUEST_CONTACTS"
    let TRAVEL_BUS_SEARCHES = "TRACEL_BUS_SEARCHES"
    let ISDEREGISTERED = "ISDEREGISTERED"
    let DEVICE_BINDING_LIMIT = "DEVICE_BINDING_LIMIT"
    let COLLECT_REQUEST_LIMIT = "COLLECT_REQUEST_LIMIT"
    let PRIMARY_ACC_NO = "PRIMARY_ACC_NO"
    let LATITUDE = "lat"
    let LONGITUDE = "long"
    
    func isValidPhone(phone: String) -> Bool {
            let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return phoneTest.evaluate(with: phone)
    }
    func getDeviceID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    func getDeviceName() -> String {
        return UIDevice.current.name
    }
    func getDeviceIP() -> String {
        return Utils.getIpAddress() ?? ""
    }
     func getOSVersion() -> String {
        return (UIDevice.current.systemVersion)
    }
    var isIntroDone:Bool?{
        get{
            return (defaults.value(forKey: ISINTRO) as? Bool)
        }set{
            defaults.setValue(newValue, forKey: ISINTRO)
        }
    }
    
    var deviceBindingLimit:Int? {
        get{
            return (defaults.value(forKey: DEVICE_BINDING_LIMIT) as? Int)
        }set{
            defaults.setValue(newValue, forKey: DEVICE_BINDING_LIMIT)
        }
    }

    var collectRequestLimit:Int? {
        get{
            return (defaults.value(forKey: COLLECT_REQUEST_LIMIT) as? Int)
        }set{
            defaults.setValue(newValue, forKey: COLLECT_REQUEST_LIMIT)
        }
    }
    
    var primaryAccNo:String? {
        get{
            return (defaults.value(forKey: PRIMARY_ACC_NO) as? String)
        }set{
            defaults.setValue(newValue, forKey: PRIMARY_ACC_NO)
        }
    }
    
    var isDeregistered:Bool?{
        get{
            return (defaults.value(forKey: ISDEREGISTERED) as? Bool)
        }set{
            defaults.setValue(newValue, forKey: ISDEREGISTERED)
        }
    }
    
    var isLoggedIn:Bool?{
        get{
            return (defaults.value(forKey: ISLOGGEDIN) as? Bool)
        }set{
            defaults.setValue(newValue, forKey: ISLOGGEDIN)
        }
        
    }
    
    //UMobile_NUMBER
    var userMobile_NUMBER:String?{
        get{
            return (defaults.value(forKey: UMobile_NUMBER) as? String)
        }set{
            defaults.set(newValue, forKey: UMobile_NUMBER)
        }
    }
    
    
    
    var phoneNo:String?{
        get{
            return (defaults.value(forKey: PHONE_NUMBER) as? String)
        }set{
            defaults.set(newValue, forKey: PHONE_NUMBER)
        }
    }
    
    
    var fcmToken:String?{
        get{
            return (defaults.value(forKey: FCMTOKEN) as? String)
        }set{
            defaults.set(newValue, forKey: FCMTOKEN)
        }
    }
    
    var sum_wallet_balance:String?{
        get{
            return (defaults.value(forKey: SUMWALLETBALANCE) as? String)
        }set{
            defaults.set(newValue, forKey: SUMWALLETBALANCE)
        }
    }
    
    
    var secondary_wallet_balance:String?{
        get{
            return (defaults.value(forKey: SECONDARYWALLETBALANCE) as? String)
        }set{
            defaults.set(newValue, forKey: SECONDARYWALLETBALANCE)
        }
    }
    var primary_wallet_balance:String?{
        get{
            return (defaults.value(forKey: PRIMARYWALLETBALANCE) as? String)
        }set{
            defaults.set(newValue, forKey: PRIMARYWALLETBALANCE)
        }
    }
    var token:String?{
        get{
            return (defaults.value(forKey: TOKEN) as? String)
        }set{
            defaults.set(newValue, forKey: TOKEN)
        }
    }
    var userFirstName:String?{
        get{
            return (defaults.value(forKey: USERFIRSTNAME) as? String)
        }set{
            defaults.set(newValue, forKey: USERFIRSTNAME)
        }
    }
    //User  Image
    var UserProfileImage:String?{
        get{
            return (defaults.value(forKey: UserImage) as? String)
        }set{
            defaults.set(newValue, forKey: UserImage)
        }
    }
    var userLastName:String?{
        get{
            return (defaults.value(forKey: USERLASTNAME) as? String)
        }set{
            defaults.set(newValue, forKey: USERLASTNAME)
        }
    }
    var merchantauthtoken:String?{
        get{
            return (defaults.value(forKey: MERCHANTAUTHTOKEN) as? String)
        }set{
            defaults.set(newValue, forKey: MERCHANTAUTHTOKEN)
        }
    }
    var uniqueMerchantauthtoken:String?{
        get{
            return (defaults.value(forKey: UNIQUEMERCHANTAUTHTOKEN) as? String)
        }set{
            defaults.set(newValue, forKey: UNIQUEMERCHANTAUTHTOKEN)
        }
    }
    
    var myCards:Data? {
        get{
            return (defaults.value(forKey: MY_CARDS) as? Data)
        }set{
            defaults.set(newValue, forKey: MY_CARDS)
        }
    }

    var recentContacts:Data? {
        get{
            return (defaults.value(forKey: RECENT_CONTACTS) as? Data)
        }set{
            defaults.set(newValue, forKey: RECENT_CONTACTS)
        }
    }
    
    var recentRequestContacts:Data? {
        get{
            return (defaults.value(forKey: RECENT_REQUEST_CONTACTS) as? Data)
        }set{
            defaults.set(newValue, forKey: RECENT_REQUEST_CONTACTS)
        }
    }

    var bbpsFavouriteCategories:Data? {
        get{
            return (defaults.value(forKey: BBPS_FAVOURITE_CATEGORY) as? Data)
        }set{
            defaults.set(newValue, forKey: BBPS_FAVOURITE_CATEGORY)
        }
    }
    
    var travelBusSearches:Data? {
        get{
            return (defaults.value(forKey: TRAVEL_BUS_SEARCHES) as? Data)
        }set{
            defaults.set(newValue, forKey: TRAVEL_BUS_SEARCHES)
        }
    }
    
    var latitude:String?{
        get{
            return (defaults.value(forKey: LATITUDE) as? String)
        }set{
            defaults.set(newValue, forKey: LATITUDE)
        }
    }
    var longitude:String?{
        get{
            return (defaults.value(forKey: LONGITUDE) as? String)
        }set{
            defaults.set(newValue, forKey: LONGITUDE)
        }
    }
    
    func getPostalCode(_ doubleLatitude:Double,_ doubleLongitude:Double) -> String{
        let geocoder = CLGeocoder()
        var strPostalCode:String?

        // Coordinates to reverse geocode
        let location = CLLocation(latitude: doubleLatitude, longitude:doubleLongitude)

        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                return
            }

            if let placemark = placemarks?.first {
                if let postalCode = placemark.postalCode {
                    print("Postal Code: \(postalCode)")
                    strPostalCode = "\(postalCode)"
                }
                
                // Access other address components if needed
                print("Address: \(placemark)")
                
            }
        }
        return strPostalCode ?? ""
    }
    func showDate(_ date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    func showHDate(_ date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        return dateFormatter.string(from: date)
    }
    
    func convertshowHDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        dateFormatter.dateFormat = "d MMM"
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
    
    
    
    
    
    func showHDay(_ date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    func dateApiAllowed(_  date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
    
    
    
    func dateForApiHit(_  date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    
    
    func dateFormaterShow(_ strDate:String) -> String{
        let dateString = strDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: dateString) {
            print(date) // This will print the parsed date
            return dateFormatter.string(from: date)
        } else {
            print("Invalid date format")
            return ""
        }

    }
    
    func dateformatForPreviouslySearched(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, EEEE yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    func convertDateforButton(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        dateFormatter.dateFormat = "dd MMM yyyy"
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
    
    func convertTo12HourFormatIfNeeded(_ timeString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"

        if let _ = dateFormatter.date(from: timeString) {
            // If the time is already in 12-hour format, return as is
            return timeString
        }

        // Convert from 24-hour to 12-hour format
        dateFormatter.dateFormat = "HH:mm"

        if let date = dateFormatter.date(from: timeString) {
            dateFormatter.dateFormat = "h:mm a"
            let formattedTime = dateFormatter.string(from: date)
            return formattedTime
        }

        return nil
    }
    
    
  

    func generateRRN() -> String {
        var rrn = ""
        for _ in 0..<12 {
            var randomByte: UInt8 = 0
            let result = SecRandomCopyBytes(kSecRandomDefault, 1, &randomByte)
            if result == errSecSuccess {
                let digit = randomByte % 10
                rrn.append(String(digit))
            } else {
                fatalError("Unable to generate random number")
            }
        }
        return rrn
    }
    

    func generateMyOrderId() -> String {
        var rrn = ""
        for _ in 0..<6 {
            var randomByte: UInt8 = 0
            let result = SecRandomCopyBytes(kSecRandomDefault, 1, &randomByte)
            if result == errSecSuccess {
                let digit = randomByte % 10
                rrn.append(String(digit))
            } else {
                fatalError("Unable to generate random number")
            }
        }
        return rrn
    }
    
    func hideFirstSixDigits(of hideString: String, hideCount: Int) -> String {
        guard hideString.count > hideCount else {
            return hideString
        }
        
        let startIndex = hideString.index(hideString.startIndex, offsetBy: hideCount)
        let hiddenPart = String(repeating: "*", count: hideCount)
        let visiblePart = hideString[startIndex...]

        return hiddenPart + visiblePart
    }
    
}
