//
//  BookHotel_ViewModel.swift
//  MaxPay
//
//  Created by Admin on 11/06/24.
//

import Foundation

//GetHotelBookingApi



final class BookHotel_ViewModel {
    
    var getHotelBook_Model:HotelBook_Model?
    
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    
    func GetHotelBookApiCall(skeyStr:String,city:String,CheckInDate:String,CheckOutDate:String,RoomCount:Int,hotelID:String,engineID:Int,eMTCommonID:String,hotelName:String,Adults:Int,Child:Int,Nights:Int,MealTypeStr:String,chargeableRateStr:Int,RateCodeStr:String,RateKeyStr:String,RoomType:String,RoomTypeCode:String,CancellationPolicy:String,hotelReservInfo:[String : Any],adultsDetails:[String : Any],ChildDetails:[Int]) {
        
        //let params : [String:Any]  = ["skey":skeyStr]
        
        let params: [String: Any] = [
            "skey": skeyStr,
            "city": city,
            "CheckInDate": CheckInDate,
            "CheckOutDate": CheckOutDate,
            "RoomCount": RoomCount,
            "HotelID": hotelID,
            "EngineID": engineID,
            "EMTCommonID": eMTCommonID,
            "HotelName":hotelName,
            "Adults": Adults,  // Sum of adults in all rooms
            "Child": Child,  // Sum of children in all rooms
            "Nights": Nights,
            "MealType" :MealTypeStr,
            "chargeableRate":chargeableRateStr,
            "RateCode": RateCodeStr,
            "RateKey":RateKeyStr,
            "RoomType":RoomType,
            "RoomTypeCode" : RoomTypeCode,
            "CancellationPolicy":CancellationPolicy,
            "HotelReservationInfo":hotelReservInfo,
            "AdultDetails" :adultsDetails,
            "ChildDetails":ChildDetails
            
        ]
        
        print("The dictionary is : \(params)")
        
        self.eventHandler?(.loading)
        
        ApiManager.sharedInstance.GetHotelBookingApi(dict:params as NSDictionary, completion: { (model, err) in
           
            self.eventHandler?(.stopLoading)
          
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
          
            if let model = model {
                
                self.getHotelBook_Model = model
                
                self.eventHandler?(.dataLoaded)
                
            }else{
                self.eventHandler?(.error(err))
            }
            
        })
    }
}
extension BookHotel_ViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}


