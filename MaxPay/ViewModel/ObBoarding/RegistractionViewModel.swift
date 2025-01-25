//
//  RegistractionViewModel.swift
//  MaxPay
//
//  Created by india on 08/11/23.
//
/*
 {
     "skey": "142418AgQWGaSEHXoQ58ae75c4",
     "country_code": "+91",
     "phone": "9348597393",
     "imei": "86523645653876845",
     "device_id": "Hello 123",
     "os": "ios",
     "device_name": "apple 670",
     "referral_code" : "",
     "latitude": "",
     "longitude": ""
 }
 
 */

import Foundation
import UIKit

final class RegistractionViewModel {
    
    var registractionModel:RegistractionModel?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func registractionCall(_ strPhoneNumber:String) {
        let params : [String:Any]  = ["country_code":"+91","device_id":Common.shared.getDeviceID(),"latitude":Common.shared.latitude ?? "28.78","longitude":Common.shared.longitude ?? "77.17" , "mobile" : strPhoneNumber,  "device_name": Utils.getDeviceModelIdentifier(), "device_ip" : Common.shared.getDeviceIP(),  "os_version" : Common.shared.getOSVersion(),"registration_timestamp"  : Date().getCurrentDateTime(), "source" : "mobile_app",  "language_preference" : "en" , "device_brand" : "Apple" , "referral_code" : ""]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.registractionServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch:", err)
                return
            }
            if let model = model {
                self.registractionModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
}
extension RegistractionViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
