//
//  ValidateUpiOTPViewModel.swift
//  MaxPay
//
//  Created by Admin on 23/10/24.
//

import Foundation

final class ValidateUpiOTPViewModel {
    
    var validateUpiOTPModel:ValidateUpiOTPModel?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func validateUpiOTPCall(_ strPhoneNumber:String) {
        let params : [String:Any]  = ["mobileNumber":strPhoneNumber]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.validateUpiOtpServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.validateUpiOTPModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
}
extension ValidateUpiOTPViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}


