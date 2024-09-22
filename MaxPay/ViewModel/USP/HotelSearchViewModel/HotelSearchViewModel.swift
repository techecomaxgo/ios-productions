//
//  HotelSearchViewModel.swift
//  MaxPay
//
//  Created by Admin on 03/06/24.
//

import Foundation


final class HotelSearchViewModel {
    
    var getHotelSearchModel:HotelSearchModel_Base?
    
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    
    func GetHotelSearchModelApiCall(skeyStr:String,city:String,CheckInDate:String,CheckOutDate:String,RoomCount:Int,Adults:Int,Child:Int,Nights:Int,HotelCount:Int,RoomDetails:[String : Any],maxPrice:String,minPrice:String,sorttype:String) {
        
        //let params : [String:Any]  = ["skey":skeyStr]
        
        let params: [String: Any] = [
            "skey": skeyStr,
            "city": city,
            "CheckInDate": CheckInDate,
            "CheckOutDate": CheckOutDate,
            "RoomCount": RoomCount,
            "Adults": Adults,  // Sum of adults in all rooms
            "Child": Child,  // Sum of children in all rooms
            "Nights": Nights,
            "HotelCount": HotelCount,
            "RoomDetails": [RoomDetails],
            "maxPrice": maxPrice,
            "minPrice": minPrice,
            "sorttype": sorttype
        ]
        
        print("The dictionary is : \(params)")
        
        self.eventHandler?(.loading)
        
        ApiManager.sharedInstance.GetHotelSearchModelApi(dict:params as NSDictionary, completion: { (model, err) in
           
            self.eventHandler?(.stopLoading)
          
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
          
            if let model = model {
                
                self.getHotelSearchModel = model
                
                self.eventHandler?(.dataLoaded)
                
            }else{
                self.eventHandler?(.error(err))
            }
            
        })
    }
}
extension HotelSearchViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}


