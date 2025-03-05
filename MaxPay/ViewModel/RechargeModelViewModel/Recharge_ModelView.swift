//
//  Recharge_ModelView.swift
//  MaxPay
//
//  Created by Ios Developer on 27/05/24.
//

import Foundation
import OlivePayLibrary

//RechargeModel_Base



final class Recharge_ModelView {
    var beneVpa : BeneVpa?
    var tr : String?
    var am: String?
    var tid: String?
    var rechargeModelBase:RechargeModel_Base?
    var payUFirstForRecharge: PayUFirstForRecharge?
    var checksumModel:ChecksumModel?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func RechargePayUFirstAPICall(amountStr:Int, phoneStr:String, txnidnew: String, customerEmail: String, productinfo: String, firstname: String, device_id: String, client_ip: String) {
        let params : [String:Any]  = ["amount":amountStr,"customerPhone":phoneStr, "txnidnew": txnidnew, "customerEmail" : customerEmail, "productinfo": productinfo, "firstname": firstname, "device_id": device_id, "client_ip": client_ip]
        print("The dictionary is : \(params)")
        
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.PayUFirstForRechargeServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                
                self.payUFirstForRecharge = model
                
                let params: [String: String] = self.extractParams(uri: self.payUFirstForRecharge?.result?.intentURIData ?? "")
                print(params)
                self.beneVpa = BeneVpa(name: params["pn"] ?? "", vpa: params["pa"] ?? "", nickName: "Ecomaxgo llp")
                self.tr = params["tr"]
                self.am = params["am"]
                self.tid = params["tid"]
                
                
                self.eventHandler?(.dataLoaded)
                
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
    func RechargePayUSecondAPICall(amountStr:Int, phoneStr:String, provider: String, location: String, txnidnew: String, latitude: String, longitude: String, device_id: String, client_ip: String) {
       
        let params : [String:Any]  = ["skey":"AVJQIdwn79iR0zlP0iKNKumME","recharge_number":phoneStr, "amount": amountStr, "isSpecial" : "N", "provider": provider, "location": location, "payment_method": "UPI", "upi_txn_id": txnidnew, "latitude": latitude, "longitude": longitude, "device_id": device_id, "device_ip": client_ip]
        print("The dictionary is : \(params)")
        
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.PayUSecondForRechargeServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                
                self.payUFirstForRecharge = model
                
                let params: [String: String] = self.extractParams(uri: self.payUFirstForRecharge?.result?.intentURIData ?? "")
                print(params)
                self.beneVpa = BeneVpa(name: params["pn"] ?? "", vpa: params["pa"] ?? "", nickName: "Ecomaxgo llp")
                self.tr = params["tr"]
                self.am = params["am"]
                self.tid = params["tid"]
                
                
                self.eventHandler?(.dataLoaded)
                
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
    
    func extractParams(uri: String) -> [String: String] {
     var params = [String: String]()
     
     // Split the URI string by "&"
     let pairs = uri.split(separator: "&")
     
     // Iterate through each pair and split by "="
     for pair in pairs {
     let keyValue = pair.split(separator: "=", maxSplits: 1, omittingEmptySubsequences: true)
     if keyValue.count == 2 {
     let key = String(keyValue[0])
     let value = String(keyValue[1])
     params[key] = value
     }
     }
     
     return params
    }
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

