//
//  SearchLostItemAPIManager.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 25/05/24.
//

import Foundation
import  UIKit

class SearchLostItemListAPIManager {
    let HTTPMethod = APIMethod()
    let baseAPICall = BaseAPIManager()
    func fetchSearchLostItemApiCall(params:Dictionary<String, Any>, fromVC:UIViewController, isClaimed:Bool = false ,completion: @escaping (Result<LostItemListDataModel, Error>) -> ()) {
        baseAPICall.request(urlString:searchLostRecords, fromVC:fromVC  , method: HTTPMethod.post, params: params,isAuthorization: true,isAcceptHeader: true,isUrlEncoded: false,isClaimed: isClaimed) { (_ result: Result<LostItemListDataModel, Error>)  in
            switch result {
            case .success(let info):
                completion(.success(info))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
