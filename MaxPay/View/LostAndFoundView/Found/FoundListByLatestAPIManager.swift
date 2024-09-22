//
//  FoundListByLatestAPIManager.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 26/05/24.
//

import Foundation
import  UIKit

class FoundListByLatestAPIManager {
    let HTTPMethod = APIMethod()
    let baseAPICall = BaseAPIManager()
    func fetchFilterFoundItemByLatestApiCall(params:Dictionary<String, Any>, fromVC:UIViewController, completion: @escaping (Result<FoundItemListDataModel, Error>) -> ()) {
        baseAPICall.request(urlString:filterFoundByLatest, fromVC:fromVC  , method: HTTPMethod.post, params: params,isAuthorization: true,isAcceptHeader: true,isUrlEncoded: false) { (_ result: Result<FoundItemListDataModel, Error>)  in
            switch result {
            case .success(let info):
                completion(.success(info))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
