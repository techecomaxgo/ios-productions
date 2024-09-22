//
//  LimitCheckViewModel.swift
//  MaxPay
//
//  Created by Ios Developer on 18/05/24.
//


import Foundation


final class LimitCheckViewModel {
    
    var limitCheckModel:LimitCheck_Base?
    
    var checksumModel:ChecksumModel?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func limitCheckCall(action:String) {
        let params : [String:Any]  = ["action":action]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.LimitCheckApiServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                
                self.limitCheckModel = model
                
                self.eventHandler?(.dataLoaded)
                
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
    //rechargeChecksumCall
    //bharatQrChecksumCall
    func limitChecksumCall(_ strPhoneNumber:String,_ strToken:String) {
        let params : [String:Any]  = ["phone":strPhoneNumber,"skey":skey,"token":strToken]
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
extension LimitCheckViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}

