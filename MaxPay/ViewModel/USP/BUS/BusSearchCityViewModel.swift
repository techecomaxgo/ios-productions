//
//  BusSearchCityViewModel.swift
//  MaxPay
//
//  Created by india on 06/12/23.
//

import Foundation
final class BusSearchCityViewModel {
    
    var cityModel:CityModel?
    var busListModel:BusListModel?
    var weatherModel: WeatherModel?
    
    var dict:Dictionary = [String:Any]()
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func cityCall() {
        let params : [String:Any]  = ["skey":skey]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.cityServiceApi(dict:params as NSDictionary,completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.cityModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
    func busListCall(_ strSourceID:Int,_ strDestinationID:Int,_ strJourneyDate:String) {
        let params : [String:Any]  = ["skey":skey,"sourceId":strSourceID,"destinationId":strDestinationID,"journeydate":strJourneyDate]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.BusListServiceApi(dict:params as NSDictionary,completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.busListModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
    
    func weatherApiCall(city: String) {
        
        self.eventHandler?(.loading)
        
        ApiManager.sharedInstance.weatherServiceApi(city: city, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.weatherModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
}
extension BusSearchCityViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
