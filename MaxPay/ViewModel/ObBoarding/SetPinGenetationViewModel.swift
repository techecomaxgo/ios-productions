//
//  SetPinGenetationViewModel.swift
//  MaxPay
//
//  Created by india on 08/11/23.
//
/*
 {
     "skey": "142418AgQWGaSEHXoQ58ae75c4",
     "phone": "9348597393",
     "mpin": "4444"
 }
 */

import Foundation
final class SetPinGenetationViewModel {
    
    var otpVerifyModel:OtpVerifyModel?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func setPinGenerationCall(_ strPhoneNumber:String,_ strMPin:String) {
        let params : [String:Any]  = ["mobile":strPhoneNumber,"mpin":strMPin]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.pinGenerationServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.otpVerifyModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
}
extension SetPinGenetationViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
