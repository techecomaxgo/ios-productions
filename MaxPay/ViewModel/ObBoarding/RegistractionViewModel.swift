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
final class RegistractionViewModel {
    
    var registractionModel:RegistractionModel?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func registractionCall(_ strPhoneNumber:String) {
        let params : [String:Any]  = ["phone":strPhoneNumber,"skey":skey,"country_code":"+91","device_id":"Hello 123","imei":Common.shared.getDeviceID(),"os":"ios","device_name":Common.shared.getDeviceName(),"referral_code" : "","latitude": "","longitude": ""]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.registractionServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
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
