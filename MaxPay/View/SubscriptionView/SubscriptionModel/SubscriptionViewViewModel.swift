//
//  OTPVerifyViewModel.swift
//  MaxPay
//
//  Created by india on 08/11/23.
//

import Foundation
final class SubscriptionViewViewModel {
    
    var subscription:SubscriptionResponse?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func subscriptionmodel() {
       
        print("Failed to fetch check")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.SubscriptionApiServiceApi( completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                print(model)
                self.subscription = model
                self.eventHandler?(.dataLoaded)
            }else{
                print("abcddddd")
                self.eventHandler?(.error(err))
            }
        })
    }
    
}
extension SubscriptionViewViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
