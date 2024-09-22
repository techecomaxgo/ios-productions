//
//  FetechBillViewModel.swift
//  MaxPay
//
//  Created by india on 21/11/23.
//

import Foundation
final class FetechBillViewModel {
    
    var fetechBillModel:FetechBillModel?
    var fetechBillValidationModel:FetechBillValidationModel?
    var fetechValaidationPayment:FetechValaidationPayment?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func fetechBillCall(_ strBillerID:String) {
        let params : [String:Any]  = ["skey":skey, "biller_id":strBillerID]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.fetechBillServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.fetechBillModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
    func fetechBillValidationCall(_ strJSONString:String) {
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
        ApiManager.sharedInstance.fetechBillValidationServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.fetechBillValidationModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
    func fetechBillValidationPaymentCall(_ strJSONString:String) {
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
        ApiManager.sharedInstance.fetechBillValidationBillPaymentServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.fetechValaidationPayment = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
}
extension FetechBillViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
