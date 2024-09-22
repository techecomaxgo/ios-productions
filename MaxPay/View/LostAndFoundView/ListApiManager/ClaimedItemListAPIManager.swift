//
//  ClaimedItemListAPIManager.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 25/05/24.
//

import Foundation
import  UIKit

class ClaimedItemListAPIManager {
    let HTTPMethod = APIMethod()
    let baseAPICall = BaseAPIManager()
    func fetchClaimedItemApiCall(params:Dictionary<String, Any>, fromVC:UIViewController,isClaimed:Bool, completion: @escaping (Result<ClaimedItemListDataModel, Error>) -> ()) {
        baseAPICall.request(urlString:claimedRecords, fromVC:fromVC  , method: HTTPMethod.post, params: params,isAuthorization: true,isAcceptHeader: true,isUrlEncoded: false,isClaimed: isClaimed) { (_ result: Result<ClaimedItemListDataModel, Error>)  in
            switch result {
            case .success(let info):
                completion(.success(info))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
