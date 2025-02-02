//
//  DashboardViewModel.swift
//  MaxPay
//
//  Created by india on 10/11/23.
//

import Foundation
final class DashboardViewModel {
    
    var balanceDetailsModel:BalanceDetailsModel?
    var secondaryWalletBalance:SecondaryWalletBalance?
    var checkSum: ChecksumModel?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func getBalanceDetailsCall(phoneStr:String) {
        let params : [String:Any]  = ["skey":skey]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.dashboardBalanceServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.balanceDetailsModel = model
                Common.shared.cardNumbe = model.messageBalance?.card_number
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
    func getSecondaryWalletBalanceDetailsCall(phoneStr:String) {
        let params : [String:Any]  = ["skey":skey,"phone":phoneStr]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.dashboardSecondaryBalanceServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.secondaryWalletBalance = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
}
extension DashboardViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
