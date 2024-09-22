//
//  ClaimItemAPIManager.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 26/05/24.
//

import Foundation
import  UIKit

class ClaimItemAPIManager {
    let HTTPMethod = APIMethod()
    let baseAPICall = BaseAPIManager()
    func fetchClaimItemApiCall(params:Dictionary<String, Any>, fromVC:UIViewController,isCalimed:Bool, completion: @escaping (Result<CommonDataModel, Error>) -> ()) {
        baseAPICall.request(urlString:claimItem, fromVC:fromVC  , method: HTTPMethod.post, params: params,isAuthorization: true,isAcceptHeader: true,isUrlEncoded: false,isClaimed: isCalimed) { (_ result: Result<CommonDataModel, Error>)  in
            switch result {
            case .success(let info):
                completion(.success(info))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
