//
//  SeatDetailsViewModel.swift
//  MaxPay
//
//  Created by india on 08/12/23.
//
/*{
    "skey": "142418AgQWGaSEHXoQ58ae75c4",
    "sourceId": 595,
    "sourceCity": "Lucknow",
    "destinationId": 1059,
    "destinationCity": "Delhi",
    "journeydate": "25-10-2023",
    "tripId": "NXS-333-7427-1005692-1005922-20231225",
    "routeId": "7427",
    "seater": true,
    "sleeper": false,
    "engineId": 13
}
*/
import Foundation
final class SeatDetailsViewModel {
    
    var seatDetailsModel:SeatDetailsModel?
    var seatModel:SeatModel?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func seatDetailsCall(sourceId:Int,sourceCity:String,destinationId:Int,destinationCity:String,journeydate:String, tripId:String,routeId:String,seater:Bool,sleeper:Bool,engineId:Int) {
        let params : [String:Any]  = ["skey":skey,"sourceId":sourceId,"sourceCity":sourceCity,"destinationId":destinationId,"destinationCity":destinationCity,"journeydate":journeydate,"tripId":tripId,"routeId":routeId,"seater":seater,"sleeper":sleeper,"engineId":engineId]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.seatsDetailsServiceApi(dict:params as NSDictionary,completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.seatModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
}
extension SeatDetailsViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
