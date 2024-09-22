//
//  QRBharatScanViewModel.swift
//  MaxPay
//
//  Created by Ios Developer on 11/05/24.
//

import Foundation

final class QRBharatScanViewModel {
    
    var scanQrModel:QRBharatModel?
    var checksumModel:ChecksumModel?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func qrBharatCall(_ qrStr:String) {
        let params : [String:Any]  = ["bqrString":qrStr]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.QrBharatServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.scanQrModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
    
    
    
    func bharatQrChecksumCall(_ strPhoneNumber:String,_ strToken:String) {
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


extension QRBharatScanViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}

