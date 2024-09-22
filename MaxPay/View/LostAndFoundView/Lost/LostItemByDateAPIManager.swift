//
//  LostItemByDateAPIManager.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 26/05/24.
//

import Foundation
import  UIKit

class LostItemByDateAPIManager {
    let HTTPMethod = APIMethod()
    let baseAPICall = BaseAPIManager()
    func fetchFilterLostItemByDateApiCall(params:Dictionary<String, Any>, fromVC:UIViewController, completion: @escaping (Result<LostItemListDataModel, Error>) -> ()) {
        baseAPICall.request(urlString:filterLostByDate, fromVC:fromVC  , method: HTTPMethod.post, params: params,isAuthorization: true,isAcceptHeader: true,isUrlEncoded: false) { (_ result: Result<LostItemListDataModel, Error>)  in
            switch result {
            case .success(let info):
                completion(.success(info))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
