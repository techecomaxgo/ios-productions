//
//  NotificationViewModel.swift
//  MaxPay
//
//  Created by india on 25/01/24.
//

import Foundation

final class NotificationViewModel {
    
    var notificationListModel:NotificationListModel?
    var dict:Dictionary = [String:Any]()
    
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func notificationListCall(_ page: Int) {
        let params : [String:Any]  = [
            "skey":skey,
            "page": page,
            "limit": 10
        ]
        print("The dictionary is : \(params)")
        
        self.eventHandler?(.loading)
        
        ApiManager.sharedInstance.notificationListServiceApi(dict: params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.notificationListModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
}

extension NotificationViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
