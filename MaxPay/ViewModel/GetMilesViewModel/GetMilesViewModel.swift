//
//  GetMilesViewModel.swift
//  MaxPay
//
//  Created by Admin on 31/05/24.
//

import Foundation


final class GetMilesViewModel {
    
    var getMilesModel:GetMilesModel_Base?
    
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    
    func GetMilesApiCall(skeyStr:String) {
        
        let params : [String:Any]  = ["skey":skeyStr]
        
        print("The dictionary is : \(params)")
        
        self.eventHandler?(.loading)
        
        ApiManager.sharedInstance.GetMilesApi(dict:params as NSDictionary, completion: { (model, err) in
           
            self.eventHandler?(.stopLoading)
          
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
          
            if let model = model {
                
                self.getMilesModel = model
                
                self.eventHandler?(.dataLoaded)
                
            }else{
                self.eventHandler?(.error(err))
            }
            
        })
    }
}
extension GetMilesViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}


