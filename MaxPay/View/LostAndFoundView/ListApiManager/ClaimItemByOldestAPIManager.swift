//
//  ClaimItemByOldestAPIManager.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 27/05/24.
//

import Foundation
import  UIKit

class ClaimItemByOldestAPIManager {
    let HTTPMethod = APIMethod()
    let baseAPICall = BaseAPIManager()
    func fetchClaimByOldestApiCall(params:Dictionary<String, Any>, fromVC:UIViewController, completion: @escaping (Result<ClaimedItemListDataModel, Error>) -> ()) {
        baseAPICall.request(urlString:filterClaimByOldest, fromVC:fromVC  , method: HTTPMethod.post, params: params,isAuthorization: true,isAcceptHeader: true,isUrlEncoded: false) { (_ result: Result<ClaimedItemListDataModel, Error>)  in
            switch result {
            case .success(let info):
                completion(.success(info))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
