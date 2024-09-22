//
//  Walletdetails_ViewModel.swift
//  MaxPay
//
//  Created by Admin on 29/06/24.
//



import Foundation


final class Walletdetails_ViewModel {
    
    var getWalletDetailsModel:GetWalletDetailsApi_Base?
    
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    
    func GetWalletDetailsModelCall(skeyStr:String,phoneStr:String) {
        
        let params : [String:Any]  = ["skey":skeyStr,"phone":phoneStr ]
        
        print("The dictionary is : \(params)")
        
        self.eventHandler?(.loading)
        
        ApiManager.sharedInstance.GetwalletdetailsApi(dict:params as NSDictionary, completion: { (model, err) in
           
            self.eventHandler?(.stopLoading)
          
            if let err = err {
                
                print("Failed to fetch courses:", err)
                
                return
            }
          
            if let model = model {
                
                self.getWalletDetailsModel = model
                
                self.eventHandler?(.dataLoaded)
                
            }else{
                self.eventHandler?(.error(err))
            }
            
        })
    }
}
extension Walletdetails_ViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}


