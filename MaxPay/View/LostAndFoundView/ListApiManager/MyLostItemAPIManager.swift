//
//  MyLostItemAPIManager.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 28/05/24.
//

import Foundation
import  UIKit

class MyLostItemAPIManager {
    let HTTPMethod = APIMethod()
    let baseAPICall = BaseAPIManager()
    func fetchMyLostApiCall(params:Dictionary<String, Any>, fromVC:UIViewController,isClaimed:Bool, completion: @escaping (Result<LostItemListDataModel, Error>) -> ()) {
        baseAPICall.request(urlString:lostListByUser, fromVC:fromVC  , method: HTTPMethod.post, params: params,isAuthorization: true,isAcceptHeader: true,isUrlEncoded: false,isClaimed: isClaimed) { (_ result: Result<LostItemListDataModel, Error>)  in
            switch result {
            case .success(let info):
                completion(.success(info))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
