//
//  RechargePlansViewModel.swift
//  MaxPay
//
//  Created by Ios Developer on 17/05/24.
//

import Foundation


final class RechargePlansViewModel {
    
    var rechargeAllModel:RechargeAllPlans_Model?
    
    var checksumModel:ChecksumModel?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func rechargePlanCall(numStr:String,skey:String) {
        
        let params : [String:Any]  = ["skey":skey, "number":numStr]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.getRechargePlansServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.rechargeAllModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
    //rechargeChecksumCall
    //bharatQrChecksumCall
    func rechargeChecksumCall(_ strPhoneNumber:String,_ strToken:String) {
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
extension RechargePlansViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}

