//
//  APIManager.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 28/05/24.
//

import Foundation
import UIKit
import Alamofire

class APIManager{
    
    //POST Request
    let contentType = ContentType()
    
    func checkConnectivity(fromVC:UIViewController){
        if !Utils.hasConnectivity(){
            fromVC.displayAlert(message: NoInternet)
            return
        }
    }
    static func setHeader()->[String:String]
     {
         //isClaimed ? KJWTTokenValue : KTokenValue
         let header = ["Authorization":KJWTTokenValue]
         return header
     }
     
    static func requestPostMultipartFormData(_ url : String ,fromVC:UIViewController ,dicsParams : [String: Any],dicImages:[UIImage], completionhandler:@escaping (Any) -> ())
    {
        guard let surl = URL(string: baseUrl + apiVersion + url) else { return }
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            var i = 0
            for (key, value) in dicsParams {
                multipartFormData.append(((value ) as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            for img in dicImages {
                i += 1
                if let imageData = img.pngData()
                {
                    multipartFormData.append(imageData, withName: KImages, fileName: "img\(i).png", mimeType: "image/png")
                }
            }
        }, to: surl ,headers: self.setHeader()) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if((response.result.error) == nil)
                    {
                        completionhandler(response.result.value as Any)
                    }
                    else
                    {
                        fromVC.hideProgressBar()
                    }
                }
            case .failure(let encodingError):
                fromVC.hideProgressBar()
                
            }
        }
    }
}
