//
//  CategoriesAPIManager.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 27/05/24.
//

import Foundation
import  UIKit

class CategoriesAPIManager {
    
    let HTTPMethod = APIMethod()
    let baseAPICall = BaseAPIManager()
    func fetchCategoriesApiCall(params:Dictionary<String, Any>, fromVC:UIViewController, completion: @escaping (Result<CategoriesDataModel, Error>) -> ()) {
        baseAPICall.request(urlString:getAllCategories, fromVC:fromVC  , method: HTTPMethod.get, params: params,isAuthorization: true,isAcceptHeader: true,isUrlEncoded: false) { (_ result: Result<CategoriesDataModel, Error>)  in
            switch result {
            case .success(let info):
                completion(.success(info))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
