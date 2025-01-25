//
//  SIMSelectionViewModel.swift
//  MaxPay
//
//  Created by india on 20/12/23.
//


import Foundation

final class SIMSelectionViewModel {
    
    var encryptDataModel:EncryptDataModel?
    var checksumModel:ChecksumModel?

    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func loginChecksumCall(_ strMobileNumber:String,_ deviceId:String) {
       
        let params : NSDictionary  = ["mobile":strMobileNumber,"device_id": deviceId]
       // let encryptedData = EncryptionService.shared.finalParam(params) // make it final encripted dictionary  to pass on api

        self.eventHandler?(.loading)
        ApiManager.sharedInstance.checksumServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch:", err)
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
extension SIMSelectionViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
