//
//  ResultQuizViewModel.swift
//  MaxPay
//
//  Created by Admin on 02/02/25.
//

import Foundation
class ResultQuizViewModel {
    var resultQuizViewModelbase : ResultQuizModel_Base?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func ResultQuizModelBaseCall(skeyStr:String) {
        let params : [String:Any]  = ["skey":skeyStr]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.ResultQuizModelApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                
                self.resultQuizViewModelbase = model
                
                self.eventHandler?(.dataLoaded)
                
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }

}
extension ResultQuizViewModel {

    enum Event {
        
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        
    }

}
