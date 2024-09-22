//
//  AttendQuizViewModel.swift
//  MaxPay
//
//  Created by Admin on 17/06/24.
//

import Foundation



final class AttendQuizViewModel {
    
    var attendQuizModelBase :AttendQuizModel_Base?
    

    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func AttendQuizModelApiCall(skeyStr:String,questionid:Int,answerStr:String,punchinStr:String,punchoutStr:String) {
        let params : [String:Any]  = ["skey":skeyStr,"question_id":questionid,"answer":answerStr,"punch_in":punchinStr,"punch_out":punchoutStr]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.AttendQuizModelApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                
                self.attendQuizModelBase = model
                
                self.eventHandler?(.dataLoaded)
                
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }

}
extension AttendQuizViewModel {

    enum Event {
        
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        
    }

}
