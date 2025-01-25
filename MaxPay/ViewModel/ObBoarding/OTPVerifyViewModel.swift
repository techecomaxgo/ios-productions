//
//  OTPVerifyViewModel.swift
//  MaxPay
//
//  Created by india on 08/11/23.
//

import Foundation
final class OTPVerifyViewModel {
    
    var otpVerifyModel:OtpVerifyModel?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func otpVerifyCall(_ strPhoneNumber:String,_ strOTP:Int) {
        let params : [String:Any]  = ["mobile":strPhoneNumber,"otp":strOTP , "device_id" : Common.shared.getDeviceID()]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.otpVerifyServiceApi(dict:params as NSDictionary, completion: { (model, err) in
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
    func otpRegenarateCall(_ strPhoneNumber:String) {
        let params : [String:Any]  = ["mobile":strPhoneNumber,"device_id":Common.shared.getDeviceID()]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.otpRegenarateOTPServiceApi(dict:params as NSDictionary, completion: { (model, err) in
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
extension OTPVerifyViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
