//
//  CatagoryListViewModel.swift
//  MaxPay
//
//  Created by india on 20/11/23.
//

import Foundation
final class CatagoryListViewModel {
    
    var catagoryListModel:ResponseDataPayU?
    //MARK: Data Binding Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    //MARK: Data featching form server
    func catagoryListCall(_ strCatagory:String) {
        let params : [String:Any]  = ["skey":skey,"pageNumber":"1","pageSize":"500", "category":strCatagory]
        print("The dictionary is : \(params)")
        self.eventHandler?(.loading)
        ApiManager.sharedInstance.catagoryListServiceApi(dict:params as NSDictionary, completion: { (model, err) in
            self.eventHandler?(.stopLoading)
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            if let model = model {
                self.catagoryListModel = model
                self.eventHandler?(.dataLoaded)
            }else{
                self.eventHandler?(.error(err))
            }
        })
    }
}
extension CatagoryListViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
