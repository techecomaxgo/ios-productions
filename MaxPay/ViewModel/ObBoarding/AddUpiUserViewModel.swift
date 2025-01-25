//
//  AddUpiUserViewModel.swift
//  MaxPay
//
//  Created by Admin on 23/10/24.
//

import Foundation
final class AddUpiUserViewModel {
    
    var addUpiUserModel:AddUpiUserModel?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func addUpiUserCall(account:AccountDetails) {
        let params: [String: Any] = [
            "account": [
                "ifsc": account.ifsc,
                "iin": account.iin,
                "internationalActive": account.internationlActive,
                "maskedAccnumber": account.maskedAccnumber,
                "name": account.name,
                "status": account.status,
                "type": account.type,
                "vpa": account.vpa
            ],
            KSKEY: KSkeyValue
        ]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.addUpiUserServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.addUpiUserModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
}
extension AddUpiUserViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}


