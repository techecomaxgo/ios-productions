//
//  RankViewModel.swift
//  MaxPay
//
//  Created by Admin on 31/05/24.
//

import Foundation


//RechargeModel_Base



final class RankViewModel {
    
    var rankModelBase : RankModel?
    

    //MARK: Data Binding Closure
    
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func RankModelApiCall(skeyStr:String) {
        let params : [String:Any]  = ["skey":skeyStr]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.RankAllModelApi(completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                
                self.rankModelBase = model
                
                self.eventHandler?(.dataLoaded)
                
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
    
}
extension RankViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}



