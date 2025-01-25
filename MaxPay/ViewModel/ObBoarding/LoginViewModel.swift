//
//  LoginViewModel.swift
//  MaxPay
//
//  Created by india on 09/11/23.
//


import Foundation
final class LoginViewModel {
    
    var loginModel:LoginModel?
    var loginPostModel : LoginPostModel?
    var checksumModel:ChecksumModel?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func loginMpinCall(_ strPhoneNumber:String,_ strMPin:String) {
     
        let params : [String:Any]  = ["mobile":strPhoneNumber,"mpin":strMPin,"device_id":Common.shared.getDeviceID(), "latitude":Common.shared.latitude ?? "28.78","longitude":Common.shared.longitude ?? "77.17" ,
                                      "device_name": Utils.getDeviceModelIdentifier(),
                                      "device_ip" : Common.shared.getDeviceIP(),
                                      "isBiometic" : false]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.loginServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                
                self.loginModel = model
                
                self.eventHandler?(.dataLoaded)
                
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
    func loginChecksumCall(_ strPhoneNumber:String,_ strToken:String) {
        let params : [String:Any]  = ["mobile":strPhoneNumber,"device_id":Common.shared.getDeviceID() ]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.checksumServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.checksumModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
}
extension LoginViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
