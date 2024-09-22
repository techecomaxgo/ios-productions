//
//  BusReviewViewModel.swift
//  MaxPay
//
//  Created by india on 12/12/23.
//

import Foundation
final class BusReviewViewModel {
    
    var busRevieweModel:BusRevieweModel?
    var busBookModel:BusBookModel?
    var deductSWalletModel :DeductSWalletModel?
    
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func busReviewCall(_ strJSONString:String) {
        var params:Dictionary = [String:Any]()
        if let jsonData = strJSONString.data(using: .utf8) {
            do {
                // Convert JSON data to a dictionary
                if let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                    print(dictionary) // Access the converted dictionary
                    params = dictionary
                }
            } catch {
                print("Error converting JSON string to dictionary: \(error.localizedDescription)")
            }
        }
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.busReviewServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            /*
             {
                 data =     {
                     BaseTotal = 0;
                     IsInsurance = 0;
                     IsInsuranceAMT = 0;
                     ResponseKey = "20242151639767d38f-b1af-48ac-90b6-3427ea3ffd80";
                     TraceId = "<null>";
                     discount = 0;
                     error = Success;
                     fareBreak = "<null>";
                     isFareRecheck = 0;
                     isTransactionCreated = 1;
                     totalAmount = 563;
                     transactionScreenId = EMT130207583;
                     transactionid = 130207583;
                     validFor = 8;
                 };
                 message = "tantative bus book, sucess";
                 status = success;
             }
             */
            
            if let model = model {
                self.busRevieweModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
    
    func busBookCall(_ transactionId: String) {
        let params : [String:Any]  = ["skey": skey, "transactionId": transactionId]
        
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.busBookServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.busBookModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
    
    func deductWalletBalanceCall(_ deductAmount: Double, _ category: String) {
        let params : [String:Any]  = ["skey": skey, "deduct_amount": deductAmount, "category": category]
        
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.deductWalletBalanceServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.deductSWalletModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
}
extension BusReviewViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
