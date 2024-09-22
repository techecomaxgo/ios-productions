//
//  PostLostItemAPIManager.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 27/05/24.
//

import Foundation
import  UIKit

class PostLostItemAPIManager {
    let HTTPMethod = APIMethod()
    let baseAPICall = BaseAPIManager()
    func postLostItemApiCall(params:Dictionary<String, Any>, fromVC:UIViewController,fileName:String,img:[UIImage], isClaimed:Bool, completion: @escaping (Result<PostLostItemDataModel, Error>) -> ()) {
        
        baseAPICall.requestUploadWithIamge(urlString: postLostItem, fromVC: fromVC, method: HTTPMethod.post, params: params, isAuthorization: true, filename: fileName, image: img,isClaimed: isClaimed) { (_ result: Result<PostLostItemDataModel, Error>)  in
            switch result {
            case .success(let info):
                completion(.success(info))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
