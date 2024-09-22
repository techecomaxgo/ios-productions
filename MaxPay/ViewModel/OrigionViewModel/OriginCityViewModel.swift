//
//  OriginCityViewModel.swift
//  MaxPay
//
//  Created by Admin on 04/07/24.
//

import Foundation


//FlightOriginCityListApi




final class OriginCityViewModel {
    
    var cityOriginBase :Origin_Base?
    
    var checksumModel:ChecksumModel?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func OriginCityModelApiCall(skeyStr:String,pageStr:Int) {
        let params : [String:Any]  = ["skey":skeyStr,"perPage":pageStr]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.FlightOriginCityListApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                
                self.cityOriginBase = model
                
                self.eventHandler?(.dataLoaded)
                
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }

}
extension OriginCityViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
