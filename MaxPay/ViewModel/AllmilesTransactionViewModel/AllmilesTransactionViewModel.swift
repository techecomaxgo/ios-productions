//
//  AllmilesTransactionViewModel.swift
//  MaxPay
//
//  Created by Admin on 01/06/24.
//

import Foundation


//
//  GetMilesViewModel.swift
//  MaxPay
//
//  Created by Admin on 31/05/24.
//

import Foundation


final class AllmilesTransactionViewModel {
    
    var geAllMilesModel:AllmilesTransactionModel?
    
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    
    func GetAllMilesApiCall(skeyStr:String) {
        
        let params : [String:Any]  = ["skey":skeyStr]
        
        print("The dictionary is : \(params)")
        
        self.eventHandler?(.loading)
        
        ApiManager.sharedInstance.GetAllmilesTransactionModelApi(dict:params as NSDictionary, completion: { (model, err) in
           
            self.eventHandler?(.stopLoading)
          
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
          
            if let model = model {
                
                self.geAllMilesModel = model
                
                self.eventHandler?(.dataLoaded)
                
            }else{
                self.eventHandler?(.error(err))
            }
            
        })
    }
}
extension AllmilesTransactionViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}


