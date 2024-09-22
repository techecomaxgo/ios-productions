//
//  GetQuizViewModel.swift
//  MaxPay
//
//  Created by Admin on 16/06/24.
//

import Foundation


final class GetQuizViewModel {
    
    var getQuizModelBase :GetQuizModel_Base?
    

    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func GetQuizModelBaseCall(skeyStr:String) {
        let params : [String:Any]  = ["skey":skeyStr]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.GetQuizModelApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                
                self.getQuizModelBase = model
                
                self.eventHandler?(.dataLoaded)
                
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }

}
extension GetQuizViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
