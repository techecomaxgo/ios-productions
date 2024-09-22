//
//  Recharge_ModelView.swift
//  MaxPay
//
//  Created by Ios Developer on 27/05/24.
//

import Foundation

//RechargeModel_Base



final class Recharge_ModelView {
    
    var rechargeModelBase:RechargeModel_Base?
    
    var checksumModel:ChecksumModel?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func RechargeModelApiCall(skeyStr:String,amountStr:Int,rechargenumberStr:String,phoneStr:String,txnIdStr:String,ViaStr:String) {
        let params : [String:Any]  = ["skey":skeyStr,"amount":amountStr,"recharge_number":rechargenumberStr,"phone":phoneStr,"txn_id":txnIdStr,"via":ViaStr]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.RechargeModelApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                
                self.rechargeModelBase = model
                
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
extension Recharge_ModelView {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}

