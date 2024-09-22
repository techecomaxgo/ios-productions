//
//  SearchFlightOne_ViewModel.swift
//  MaxPay
//
//  Created by Admin on 06/07/24.
//

import Foundation



import Foundation


final class SearchFlightOne_ViewModel {
    
    var flightSearchModelBase :FlightSearchModel_Base?
    
    var checksumModel:ChecksumModel?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    
    /*
     {
         "skey": "142418AgQWGaSEHXoQ58ae75c4",
         "travelDate": "2024-07-10",
         "origin": "DEL",
         "destination": "BOM",
         "adult": 1,
         "child": 0,
         "infant": 0,
         "tripType": 0,
         "cabin":0
     }
     
     */
    
    //MARK: Data featching form server
    
    func flightOneSearchApiCall(skeyStr:String, travelDateStr:String,originStr:String,destinationStr:String, adultStr:Int,childStr:Int,infantStr:Int,tripTypeStr:Int,cabinStr:Int) {
        
        let params : [String:Any]  = ["skey":skeyStr ,"travelDate":travelDateStr,"origin":originStr,"destination":destinationStr,"adult":adultStr,"child":childStr,"infant":infantStr,"tripType":tripTypeStr,"cabin":cabinStr ]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.searchFlightOneApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                
                self.flightSearchModelBase = model
                
                self.eventHandler?(.dataLoaded)
                
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }

}
extension SearchFlightOne_ViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
