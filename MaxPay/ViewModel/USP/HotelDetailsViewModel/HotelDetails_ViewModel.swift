//
//  HotelDetails_ViewModel.swift
//  MaxPay
//
//  Created by Admin on 09/06/24.
//

import Foundation


final class HotelDetails_ViewModel {
    
    var getHotelDetalsModel:HotelDetals_Base?
    
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    
    func GetHotelDetailsModelApiCall(skeyStr:String,hotelIDStr:String,engineIDStr:Int,eMTCommonIDStr:String) {
        
        //let params : [String:Any]  = ["skey":skeyStr]
        
        let params: [String: Any] = [
            "skey": skeyStr,
            "HotelID": hotelIDStr,
            "EngineID": engineIDStr,
            "EMTCommonID": eMTCommonIDStr
        ]
        
        print("The dictionary is : \(params)")
        
        self.eventHandler?(.loading)
        
        ApiManager.sharedInstance.GetHotelDetailsApi(dict:params as NSDictionary, completion: { (model, err) in
           
            self.eventHandler?(.stopLoading)
          
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
          
            if let model = model {
                
                self.getHotelDetalsModel = model
                
                self.eventHandler?(.dataLoaded)
                
            }else{
                self.eventHandler?(.error(err))
            }
            
        })
    }
}
extension HotelDetails_ViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}


