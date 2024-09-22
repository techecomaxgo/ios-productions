//
//  BaseAPIManager.swift

import Foundation
import UIKit


class BaseAPIManager{
    
    //POST Request
    let contentType = ContentType()
    
    func checkConnectivity(fromVC:UIViewController){
        if !Utils.hasConnectivity(){
            fromVC.displayAlert(message: NoInternet)
            return
        }
    }
    func setHeader()->[String:String]
    {
        //isClaimed ? KJWTTokenValue : KTokenValue
        let header = ["Authorization":KTokenValue]
        return header
    }
    
    func request<T:Codable>(urlString:String, fromVC:UIViewController,  method:String,params:Dictionary<String, Any>, isAuthorization:Bool=false, isAcceptHeader:Bool=false, isUrlEncoded:Bool=true, isClaimed:Bool = false,completion: @escaping((Result<T,Error>)->Void)){
        
        self.checkConnectivity(fromVC:fromVC)
        
        guard let url = URL(string: baseUrl + apiVersion + urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = method
        if isAcceptHeader{
            request.addValue(contentType.appJson, forHTTPHeaderField: "Accept")
        }
        if isAuthorization{
            request.addValue(isClaimed ? KJWTTokenValue : KTokenValue, forHTTPHeaderField: "Authorization")
        }
        if params.count > 0{
            if isUrlEncoded{
                request.setValue(contentType.appXWFormUrlEncoded, forHTTPHeaderField: "Content-Type")
                let strParams = (params.compactMap({ (key, value) -> String in
                    return "\(key)=\(value)"
                }) as Array).joined(separator: "&")
                let data : Data = strParams.data(using: .utf8)!
                request.httpBody = data
            }else{
                request.setValue(contentType.appJson, forHTTPHeaderField: "Content-Type")
                var  jsonData = NSData()
                do {
                    jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) as NSData
                } catch {
                    print(error.localizedDescription)
                }
                request.httpBody = jsonData as Data
            }
        }
        call(with: request, completion: completion)
    }
    
    func call<T:Codable>(with request:URLRequest,completion: @escaping((Result<T,Error>)->Void)){
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            guard let data = data else{
                completion(.failure(err!));return
            }
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
    
    func callUpload<T:Codable>(with request:URLRequest,data:Data,completion: @escaping((Result<T,Error>)->Void)){
        URLSession.shared.uploadTask(with: request, from: data) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            guard let data = data else{
                completion(.failure(err!));return
            }
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
    func generateBoundaryString() -> String {
        return "Boundary-\(Int.random(in: 1000 ... 9999))"
    }
    
    public func requestUploadWithIamge<T:Codable>(urlString:String, fromVC:UIViewController, method:String,params:Dictionary<String, Any>, isAuthorization:Bool=false,filename:String,image:[UIImage], isClaimed:Bool = false,completion: @escaping((Result<T,Error>)->Void)) {
        
        guard let url = URL(string: baseUrl + apiVersion + urlString) else { return }
        var request = URLRequest(url: url)
        let boundary:String = generateBoundaryString()
        let MPboundary:String = "--\(boundary)"
        let endMPboundary:String = "\(MPboundary)--"
        //convert UIImage to NSData
        var data:Data?
        let body:NSMutableString = NSMutableString();
        let myRequestData:NSMutableData = NSMutableData()
        // with other params
        let mimetype = "image/png"
        for (key, value) in params {
            body.appendFormat("\(MPboundary)\r\n" as NSString)
            body.appendFormat("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n" as NSString)
            body.appendFormat("\(value)\r\n" as NSString)
        }
        var i = 0
        for img in image{
            let imgFilename = "image\(i).png"
            data = img.pngData()! as Data
            body.appendFormat("%@\r\n",MPboundary)
            body.appendFormat("Content-Disposition: form-data; name=\"\(filename)\"; filename=\"\(imgFilename)\"\r\n" as NSString)
            body.appendFormat("Content-Type:  \"\(mimetype)\"\r\n" as NSString)
            myRequestData.append(body.data(using: NSUTF8StringEncoding)!)
            myRequestData.append(data!)
            body.appendFormat("\r\n" as NSString)
            i += 1
        }
        let end:String = "\r\n\(endMPboundary)"
        myRequestData.append(end.data(using: String.Encoding(rawValue: NSUTF8StringEncoding))!)
        let content:String = "multipart/form-data; boundary=\(boundary)"
        request.setValue(content, forHTTPHeaderField: "Content-Type")
        request.setValue("\(myRequestData.length)", forHTTPHeaderField: "Content-Length")
        if isAuthorization{
            let authorizationKey = KJWTTokenValue
            request.addValue(authorizationKey, forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = method
        self.callUpload(with: request as URLRequest, data: myRequestData as Data, completion: completion)
    }
}
