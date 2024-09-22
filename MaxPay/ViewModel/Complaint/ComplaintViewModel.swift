//
//  ComplaintViewModel.swift
//  MaxPay
//
//  Created by india on 25/01/24.
//

import Foundation

final class ComplaintViewModel {
    
    var complaintListModel: ComplaintListModel?
    var complaintRegisterModel: RegisterComplaintModel?
    var dict:Dictionary = [String:Any]()
    
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func complaintListModel(_ page: Int) {
        let params : [String:Any]  = [
            "skey":skey,
            "page": page,
            "page_size": 10
        ]
        print("The dictionary is : \(params)")
        
        self.eventHandler?(.loading)
        
        ApiManager.sharedInstance.complaintListServiceApi(dict: params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.complaintListModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
    
    func complaintRegisterModel(description: String, disposition: String, participation_type:String, complaintType: String, txn_id: String, mobileNo: String) {
        let params : [String:Any]  = [
            "skey":skey,
            "complaint_description": description,
            "participation_type": participation_type,
            "complaint_disposition": disposition,
            "complaint_type": complaintType,
            "txn_id": txn_id,
            "mobile_no": mobileNo
        ]
        print("The dictionary is : \(params)")
        
        self.eventHandler?(.loading)
        
        ApiManager.sharedInstance.complaintRegisterServiceApi(dict: params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.complaintRegisterModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
    
    func transactionTaggingModel(txnid: String, tag: String) {
        let params : [String:Any]  = [
            "ettags": tag,
            "txnid": txnid
        ]
        print("The dictionary is : \(params)")
        
        self.eventHandler?(.loading)
        
        ApiManager.sharedInstance.transactionTaggingServiceApi(dict: params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.complaintRegisterModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
    
}

extension ComplaintViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
