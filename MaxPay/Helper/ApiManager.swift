//
//  ApiManager.swift
//
//
//       https://uat.maxupi.in/

import UIKit
import Alamofire
import SwiftyJSON
import SwiftLoader
import CryptoKit
import Security


class PinningSessionDelegate: NSObject, URLSessionDelegate {
    // Base64 encoded SHA-384 hash of the ECDSA public key
    private let expectedPublicKeyHash = "MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEwfyiRM/MAgjbiLMyL7bLs18vNE5YY0024gW377uVsKzWlpnSifdihAXt7nnmvaV+rBFZCKGeNmoiPrI3IfRAoQ=="
    
    // Replace this with your actual expected public key hash
    //  private let expectedPublicKeyHash = "sha384/yourBase64EncodedHash=="
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        // Ensure the challenge is related to server trust
        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // Get the certificate chain using SecTrustCopyCertificateChain
        var certificateChain: [SecCertificate] = []
        let result = SecTrustCopyCertificateChain(serverTrust)
        
        
        // Log the certificate chain for debugging
        for (index, certificate) in certificateChain.enumerated() {
            if let summary = SecCertificateCopySubjectSummary(certificate) {
                print("Certificate \(index): \(summary)")
            }
        }
        
        // Now you can proceed with your pinning logic, extracting the public key, etc.
        guard let serverCertificate = certificateChain.first else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // Extract the public key from the certificate
        guard let serverPublicKey = SecCertificateCopyKey(serverCertificate) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // Get the public key data (external representation)
        guard let serverPublicKeyData = SecKeyCopyExternalRepresentation(serverPublicKey, nil) as Data? else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // Compute the SHA-384 hash of the public key
        let computedHashData = computeSHA384Hash(data: serverPublicKeyData)
        let computedHashBase64 = computedHashData.base64EncodedString()
        
        // Compare the computed hash with the expected hash
        if computedHashBase64 == expectedPublicKeyHash {
            completionHandler(.useCredential, URLCredential(trust: serverTrust))
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
    
    private func computeSHA384Hash(data: Data) -> Data {
        let hash = SHA384.hash(data: data)
        return Data(hash)
    }
}


struct ConstantApi{
    
    struct BaseURL {
        //        static let baseUrl = "http://13.126.228.61/api/v1/"
        
        // static let baseUrl = "https://api.maxupi.in/api/v1/"
        
        static let baseUrl = "https://api.maxupi.in/"
        
        
        static let weatherBaseUrl = "https://uat.maxupi.in/api/v1/"
        
        static let apiVersionNew = "api/v2/"
        static let apiVersion = "api/v1/"
    }
    
    
    struct SubURL {
        static let registraction = "auth/account/register"
        static let otpVerify = "auth/account/verify-otp"
        static let regenarateOTP = "auth/account/otp-re-generate"
        static let pinGeneration = "auth/account/generate-verify-pin"
        static let login = "auth/account/login"
        static let getBalanceDetails = "wallet/v2/get-card-details"
        static let getSecondaryWalletBalance = "wallet/swallet/get-wallet-details"
        static let payBillList = "biller/master-data"
      //  static let catagoryList = "biller/billers-by-category"
        static let catagoryList = "api/v2/bill/billers-category-by-name"
      //  static let fetechBill = "biller/billers-by-id"
        static let fetechBill = "api/v2/bill/fetch-or-validate-bill"
        static let fetechBiillValF = "biller/fetch-val-bill"
        static let billPayment = "biller/payment"
        static let city = "travel/bus/get-city-list"
        static let busList = "travel/bus/get-available-trips"
        static let seatDetails = "travel/bus/get-seat-details"
        static let busBooking = "travel/bus/block-seat-for-booking"
        static let busBookingBus = "travel/bus/book-bus"
        static let deductSWalletBalance = "wallet/swallet/deduct-swallet-balance"
        static let checksum = "upi/2.0/checksum"
        static let transactionTagging = "upi/2.0/transaction-tagging"
        static let addUpiUser = "upi/2.0/add-upi-user"
        static let validateUpiOtp = "upi/2.0/validate-upi-otp"
        static let notificationList = "notification/list-notification"
        static let notificationAddToken = "api/notification/2.0/add-notification-token"
        static let transactionList = "biller/transaction-history"
        static let registerComplaint = "biller-complaint/register-complaint"
        static let weatherApi = "current.json?key=4dd79c02Alamofiref94ebab1a190013232512&q="
        static let bharatQrApi = "upi/2.0/bqr-verify"
        static let rechargePlansApi = "api/recharge/v2/get-recharge-plans" //"api/recharge/v3/get-recharge-plans"//"recharge/recharge-plans"
        static let limitCheckApi = "upi/2.0/limitcheck"
        static let operatorApi = "recharge/operator-list"
        static let circleApi = "recharge/circle-list"
        
        static let PayUFirstForRechargeApi = "api/v2/payu/upi/payment"
        static let PayUSecondForRechargeApi = "api/recharge/v2/recharge"
        static let UpiUserTxnStatus = "upi/2.0/user-txn-status"
       // static let deductWalletApi = "wallet/swallet/deduct-swallet-balance"
       // static let rechargeModelApi = "recharge/recharge"
        static let rankAllApi = "rank/2.0/all-ranker"
        
        static let chainReferApi = "refer/2.0/total-refer"
        static let getReferDetailsApi = "refer/2.0/get-refer-details"
        

        static let getQuizApi = "api/v1/quiz-user/get-quiz"
        static let attendQuizApi = "api/v1/quiz-user/attend-quiz"
        static let resultQuizApi = "api/v1/quiz-user/quiz-result"
        
        static let milesModellApi = "miles/total-amount-miles"
        static let allmilesTransApi = "miles/all-miles-transaction"
        
        static let hotelModelSearchApi = "travel/hotel/hotel-search"
        
        static let hotelDetailsApi = "travel/hotel/get-hotel-details"
        static let hotelRoomTypesApi = "travel/hotel/get-available-rooms-by-hotel-details"
        
        static let hotelBookApi = "travel/hotel/book-hotel"
        
        static let getwalletdetailsApi = "get-wallet-details"
        static let primWalletModellApi = "wallet/get-wallet-balance"
        
        static let origionCityApi = "api/v1/travel/flight/get-airport-list"
        
        static let searchFlightOneApi = "travel/flight/search-flight"
     
        static let searchFlightRoundApi = "travel/flight/search-flight"
        
        static let deductWalletApi = "api/wallet/2.0/pwallet/deduct-wallet-balance"
      
        static let subscription = "api/v2/subscriptions/get-subscriptions"
        static let subscriptionService = "api/v2/subscriptions/subscribe-services"
        
        
    }
    static  let headers: HTTPHeaders = [
        "authorization": "Bearer \(Common.shared.token ?? "")",
        "x-my-ipu-name": Utils.getBuildNumber() ,
        "x-my-ipu-code": Utils.getBuildVersion() ,
        "x-my-ipu-app-os": "ios",
        // "user_agent" : Utils.getCustomUserAgent(),
    ]
    static  let headersNew: HTTPHeaders = [
        "authorization": "Bearer \(Common.shared.token ?? "")",
        "x-my-ipu-name": Utils.getBuildNumber() ,
        "x-my-ipu-code": Utils.getBuildVersion() ,
        "x-my-ipu-app-os": "ios",
        KSKEY: KSkeyValue
    ]
    
    static  let headersWithSkey: HTTPHeaders = [
        "Authorization": "Bearer \(Common.shared.token ?? "")",
        KSKEY: KSkeyValue
    ]
    static  let headersWithoutSkey: HTTPHeaders = [
        "authorization": "Bearer \(Common.shared.token ?? "")"
    ]
    
    static  let appVersionHeaders: HTTPHeaders = [
        "x-my-ipu-name": Utils.getBuildNumber() ,
        "x-my-ipu-code": Utils.getBuildVersion() ,
        "x-my-ipu-app-os": "ios",
        "user_agent" : Utils.getCustomUserAgent(),
    ]
    
    //    static  let headers1: HTTPHeaders = [
    //        "authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiIxIiwicGhvbmUiOiI4ODk2OTU4NDY2IiwidWlkIjoiNDBjZWVmMWEtMzRmZi00YjlmLTk1NDItZjU0OGVlNTM1MzFhIiwiaWF0IjoxNzAyOTgyMzIxfQ.sNFqm1Kw79YABLjXi67jkQ_qbCgldMYak94m17jr16U"
    //    ]
    
}
//MARK: API Manager class api calling
class ApiManager: NSObject {
    
    
    
    // Replace this with the actual Base64 encoded public key
    private let pinnedPublicKeyBase64 =
    "MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEwfyiRM/MAgjbiLMyL7bLs18vNE5YY0024gW377uVsKzWlpnSifdihAXt7nnmvaV+rBFZCKGeNmoiPrI3IfRAoQ=="
    
    static let sharedInstance = ApiManager()
    
    //private var sessionManager: SessionManager?
    // Create an array of pinned public keys
    var pinnedPublicKeys: [SecKey] = []
    
    //       private func configurePinning() -> Alamofire.SessionManager {
    //
    //           // Attempt to create a SecKey from the Base64 string
    //           if let secKey = publicKeyFromBase64(base64: pinnedPublicKeyBase64) {
    //               // Add the SecKey to the array
    //               pinnedPublicKeys.append(secKey)
    //           } else {
    //               print("Failed to convert Base64 string to SecKey")
    //           }
    //
    //           // Now you can use pinnedPublicKeys array as needed
    //           print("Pinned public keys array: \(pinnedPublicKeys)")
    //
    //        // Create server trust policies for specific domains
    //        let serverTrustPolicies: [String: ServerTrustPolicy] = [
    //            "api.maxupi.in": .pinPublicKeys(
    //                publicKeys: pinnedPublicKeys,
    //                validateCertificateChain: true,        // Validate the entire certificate chain
    //                validateHost: true                    // Ensure the host is validated
    //            )
    //        ]
    //
    //        // Create a custom Session with the ServerTrustPolicyManager
    //        let configuration = URLSessionConfiguration.default
    //        let session = Alamofire.SessionManager(
    //            configuration: configuration,
    //            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
    //        )
    //
    //        return session
    //
    //    }
    
    override init(){
        super.init()
        
        
    }
    
    
    func registractionServiceApi(dict:NSDictionary,completion: @escaping (RegistractionModel?, Error?) -> ()) {
        
        //let session = createSession()
        
        //        // Example: Using PinningSessionDelegate with AlmAlamofireire
        //        let pinningDelegate = PinningSessionDelegate()
        //        let session = URLSession(configuration: .default, delegate: pinningDelegate, delegateQueue: nil)
        
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.BaseURL.apiVersionNew)\(ConstantApi.SubURL.registraction)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.appVersionHeaders).responseJSON {  response in
            
            print("response: ", response)
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                // print(dictResponse)
                if let data = response.data, data.count > 0{
                    // print(data)
                    do{
                        let model = try JSONDecoder().decode(RegistractionModel.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
            
        }
    }
    func otpVerifyServiceApi(dict:NSDictionary,completion: @escaping (OtpVerifyModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.BaseURL.apiVersionNew)\(ConstantApi.SubURL.otpVerify)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.appVersionHeaders).responseJSON {  response in
            if response.result.isSuccess{
                print(response)
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    
                    do{
                        let model = try JSONDecoder().decode(OtpVerifyModel.self, from: data)
                        print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    func otpRegenarateOTPServiceApi(dict:NSDictionary,completion: @escaping (OtpVerifyModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.BaseURL.apiVersionNew)\(ConstantApi.SubURL.regenarateOTP)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi
            .appVersionHeaders).responseJSON {  response in
                if response.result.isSuccess{
                    guard let dictResponse = response.data, dictResponse.count > 0 else {
                        return
                    }
                    if let data = response.data, data.count > 0{
                        // print(data)
                        do{
                            let model = try JSONDecoder().decode(OtpVerifyModel.self, from: data)
                            //  print(model)
                            completion(model,nil)
                            
                        }catch{}
                        
                    }
                }
            }
    }
    func pinGenerationServiceApi(dict:NSDictionary,completion: @escaping (OtpVerifyModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.BaseURL.apiVersionNew)\(ConstantApi.SubURL.pinGeneration)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.appVersionHeaders).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    // print(data)
                    do{
                        let model = try JSONDecoder().decode(OtpVerifyModel.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    func loginServiceApi(dict:NSDictionary,completion: @escaping (LoginModel?, Error?) -> ()) {
        
        //        // Create a custom URLSession with the pinning delegate
        //        let pinningDelegate = PinningSessionDelegate()
        //        let sessionConfiguration = URLSessionConfiguration.default
        //        let customURLSession = URLSession(configuration: sessionConfiguration, delegate: pinningDelegate, delegateQueue: nil)
        //
        //        // Define the URL
        //        let url = "\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.BaseURL.apiVersionNew)\(ConstantApi.SubURL.login)"
        //        let parameters: Parameters = dict as? Parameters ?? [:]
        //        let headers: HTTPHeaders = ConstantApi.appVersionHeaders
        //
        //        // Create a request manually with custom URLSession using Alamofire
        //        let request = customURLSession.dataTask(with: URLRequest(url: URL(string: url)!)) { (data, response, error) in
        //            // Handle response
        //            if let error = error {
        //                print("Request failed with error: \(error.localizedDescription)")
        //            } else {
        //                if let data = data {
        //                    do {
        //                        let json = try JSONSerialization.jsonObject(with: data, options: [])
        //                        print("Response JSON: \(json)")
        //                    } catch {
        //                        print("Failed to parse response: \(error)")
        //                    }
        //                }
        //            }
        //        }
        //
        //        // Start the request
        //        request.resume()
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.BaseURL.apiVersionNew)\(ConstantApi.SubURL.login)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.appVersionHeaders).responseJSON {  response in
            print("response: ", response)
            //public key pinning
            // 677bed882129187c67dd01ce4952cee5228921aad8d30e2b1d4d9162fdbfda8c
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    // print(data)
                    do{
                        let model = try JSONDecoder().decode(LoginModel.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }else{
                print("hello")
            }
        }
    }
    
    
    func QrBharatServiceApi(dict:NSDictionary,completion: @escaping (QRBharatModel?, Error?) -> ()) {
        
        // Encrypt the dictionary
        let encryptedData = EncryptionService.shared.finalParam(dict)
        print(encryptedData)
        print("bearer token\(Common.shared.token ?? "")")
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.bharatQrApi)", method: .post, parameters: encryptedData as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                // Check if the response was successful
                //                guard let responseDict = response.error as? [String: Any] else {
                //                    debugPrint("Response did not contain a valid dictionary: \(response)")
                //                    completion(nil, NSError(domain: "APIError", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"]))
                //                    return
                //                }
                
                // Check if response data exists and is not empty
                guard let responseData = response.data, responseData.count > 0 else {
                    completion(nil, NSError(domain: "APIError", code: 1002, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                do {
                    let dict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                    //print(dict)
                    // Process base64-encoded string
                    if let base64Encoded = dict?["data"] as? String {
                        // Base64 decoding
                        guard let decodedData = Data(base64Encoded: base64Encoded),
                              let decodedString = String(data: decodedData, encoding: .utf8) else {
                            completion(nil, NSError(domain: "APIError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Base64 decoding failed"]))
                            return
                        }
                        
                        // Convert the decoded string to a dictionary
                        if let decodedDict = EncryptionService.shared.convertToDictionary(text: decodedString) {
                            do {
                                // Decrypt the data
                                let decryptedData = try EncryptionService.shared.decrypt(encrypted: decodedDict["encrypted"] as! String, iv: decodedDict["iv"] as! String, authTag: decodedDict["authTag"] as! String, jwtToken: Common.shared.token ?? "")
                                
                                if let stringData = decryptedData {
                                    if let jsonData = stringData.data(using: .utf8) {
                                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                        if let dictionary = jsonObject as? [String: Any] {
                                            // Now we have a dictionary, proceed with serialization
                                            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                                            // Decode the data into a model
                                            let model = try JSONDecoder().decode(QRBharatModel.self, from: data)
                                            completion(model, nil)
                                        }
                                    }
                                }
                                
                            } catch {
                                // Handle decryption or decoding errors
                                print("Decryption or JSON decoding failed: \(error.localizedDescription)")
                                completion(nil, error)
                            }
                        } else {
                            print("Failed to convert decoded string to dictionary.")
                            completion(nil, NSError(domain: "APIError", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Invalid decoded string"]))
                        }
                        //                } else {
                        //                    print("Base64 string not found in response.")
                        //                    completion(nil, NSError(domain: "APIError", code: 1005, userInfo: [NSLocalizedDescriptionKey: "Base64 encoded data missing in response"]))
                        //                }
                        
                    } else {
                        print("Base64 string not found in response.")
                        completion(nil, NSError(domain: "APIError", code: 1005, userInfo: [NSLocalizedDescriptionKey: "Base64 encoded data missing in response"]))
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func getRechargePlansServiceApi(dict:NSDictionary,completion: @escaping (RechargeAllPlans_Model?, Error?) -> ()) {
        let encryptedData = EncryptionService.shared.finalParam(dict)
        print("encryptedData: ",  encryptedData)
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.rechargePlansApi)", method: .post, parameters: encryptedData as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            print(response)
            if response.result.isSuccess{
                guard let responseData = response.data, responseData.count > 0 else {
                    completion(nil, NSError(domain: "APIError", code: 1002, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                do {
                    let dict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                    // Process base64-encoded string
                    if let base64Encoded = dict?["data"] as? String {
                        // Base64 decoding
                        guard let decodedData = Data(base64Encoded: base64Encoded),
                              let decodedString = String(data: decodedData, encoding: .utf8) else {
                            completion(nil, NSError(domain: "APIError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Base64 decoding failed"]))
                            return
                        }
                        
                        // Convert the decoded string to a dictionary
                        if let decodedDict = EncryptionService.shared.convertToDictionary(text: decodedString) {
                            do {
                                // Decrypt the data
                                let decryptedData = try EncryptionService.shared.decrypt(encrypted: decodedDict["encrypted"] as! String, iv: decodedDict["iv"] as! String, authTag: decodedDict["authTag"] as! String, jwtToken: Common.shared.token ?? "")
                                
                                if let stringData = decryptedData {
                                    if let jsonData = stringData.data(using: .utf8) {
                                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                        if let dictionary = jsonObject as? [String: Any] {
                                            // Now we have a dictionary, proceed with serialization
                                            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                                            // Decode the data into a model
                                            let model = try JSONDecoder().decode(RechargeAllPlans_Model.self, from: data)
                                            completion(model, nil)
                                        }
                                    }
                                }
                                
                            } catch {
                                // Handle decryption or decoding errors
                                print("Decryption or JSON decoding failed: \(error.localizedDescription)")
                                completion(nil, error)
                            }
                        } else {
                            print("Failed to convert decoded string to dictionary.")
                            completion(nil, NSError(domain: "APIError", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Invalid decoded string"]))
                        }
                    } else {
                        print("Base64 string not found in response.")
                        completion(nil, NSError(domain: "APIError", code: 1005, userInfo: [NSLocalizedDescriptionKey: "Base64 encoded data missing in response"]))
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
//            if response.result.isSuccess{
//                guard let dictResponse = response.data, dictResponse.count > 0 else {
//                    return
//                }
//                if let data = response.data, data.count > 0{
//                    print(data)
//                    do{
//                        let model = try JSONDecoder().decode(RechargeAllPlans_Model.self, from: data)
////                         print(model)
//                        completion(model,nil)
//                        
//                    }catch{}
//                    
//                }
//            }
        }
    }
    
    
    func LimitCheckApiServiceApi(dict:NSDictionary,completion: @escaping (LimitCheck_Base?, Error?) -> ()) {
        
        // Encrypt the dictionary
        let encryptedData = EncryptionService.shared.finalParam(dict)
        print(encryptedData)
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.limitCheckApi)", method: .post, parameters: encryptedData as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                // Check if the response was successful
                //                guard let responseDict = response.error as? [String: Any] else {
                //                    debugPrint("Response did not contain a valid dictionary: \(response)")
                //                    completion(nil, NSError(domain: "APIError", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"]))
                //                    return
                //                }
                //
                //                print(responseDict)
                
                // Check if response data exists and is not empty
                guard let responseData = response.data, responseData.count > 0 else {
                    completion(nil, NSError(domain: "APIError", code: 1002, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                do {
                    let dict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                    // Process base64-encoded string
                    if let base64Encoded = dict?["data"] as? String {
                        // Base64 decoding
                        guard let decodedData = Data(base64Encoded: base64Encoded),
                              let decodedString = String(data: decodedData, encoding: .utf8) else {
                            completion(nil, NSError(domain: "APIError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Base64 decoding failed"]))
                            return
                        }
                        
                        // Convert the decoded string to a dictionary
                        if let decodedDict = EncryptionService.shared.convertToDictionary(text: decodedString) {
                            do {
                                // Decrypt the data
                                let decryptedData = try EncryptionService.shared.decrypt(encrypted: decodedDict["encrypted"] as! String, iv: decodedDict["iv"] as! String, authTag: decodedDict["authTag"] as! String, jwtToken: Common.shared.token ?? "")
                                
                                if let stringData = decryptedData {
                                    if let jsonData = stringData.data(using: .utf8) {
                                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                        if let dictionary = jsonObject as? [String: Any] {
                                            // Now we have a dictionary, proceed with serialization
                                            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                                            // Decode the data into a model
                                            let model = try JSONDecoder().decode(LimitCheck_Base.self, from: data)
                                            completion(model, nil)
                                        }
                                    }
                                }
                                
                            } catch {
                                // Handle decryption or decoding errors
                                print("Decryption or JSON decoding failed: \(error.localizedDescription)")
                                completion(nil, error)
                            }
                        } else {
                            print("Failed to convert decoded string to dictionary.")
                            completion(nil, NSError(domain: "APIError", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Invalid decoded string"]))
                        }
                    } else {
                        print("Base64 string not found in response.")
                        completion(nil, NSError(domain: "APIError", code: 1005, userInfo: [NSLocalizedDescriptionKey: "Base64 encoded data missing in response"]))
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func PayUFirstForRechargeServiceApi(dict:NSDictionary,completion: @escaping (PayUFirstForRecharge?, Error?) -> ()) {
        
        // Encrypt the dictionary
        //let encryptedData = EncryptionService.shared.finalParam(dict)
        //print(encryptedData)
        print("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.PayUFirstForRechargeApi)")
        print(dict)
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.PayUFirstForRechargeApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headersNew).responseJSON {  response in
            if response.result.isSuccess{
                print(response)
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //  print(data)
                    do{
                        let model = try JSONDecoder().decode(PayUFirstForRecharge.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
        /*Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.PayUFirstForRechargeApi)", method: .post, parameters: encryptedData as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                // Check if the response was successful
                //                guard let responseDict = response.error as? [String: Any] else {
                //                    debugPrint("Response did not contain a valid dictionary: \(response)")
                //                    completion(nil, NSError(domain: "APIError", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"]))
                //                    return
                //                }
                //
                //                print(responseDict)
                
                // Check if response data exists and is not empty
                guard let responseData = response.data, responseData.count > 0 else {
                    completion(nil, NSError(domain: "APIError", code: 1002, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                do {
                    let dict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                    // Process base64-encoded string
                    if let base64Encoded = dict?["data"] as? String {
                        // Base64 decoding
                        guard let decodedData = Data(base64Encoded: base64Encoded),
                              let decodedString = String(data: decodedData, encoding: .utf8) else {
                            completion(nil, NSError(domain: "APIError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Base64 decoding failed"]))
                            return
                        }
                        
                        // Convert the decoded string to a dictionary
                        if let decodedDict = EncryptionService.shared.convertToDictionary(text: decodedString) {
                            do {
                                // Decrypt the data
                                let decryptedData = try EncryptionService.shared.decrypt(encrypted: decodedDict["encrypted"] as! String, iv: decodedDict["iv"] as! String, authTag: decodedDict["authTag"] as! String, jwtToken: Common.shared.token ?? "")
                                
                                if let stringData = decryptedData {
                                    if let jsonData = stringData.data(using: .utf8) {
                                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                        if let dictionary = jsonObject as? [String: Any] {
                                            // Now we have a dictionary, proceed with serialization
                                            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                                            // Decode the data into a model
                                            let model = try JSONDecoder().decode(PayUFirstForRecharge.self, from: data)
                                            completion(model, nil)
                                        }
                                    }
                                }
                                
                            } catch {
                                // Handle decryption or decoding errors
                                print("Decryption or JSON decoding failed: \(error.localizedDescription)")
                                completion(nil, error)
                            }
                        } else {
                            print("Failed to convert decoded string to dictionary.")
                            completion(nil, NSError(domain: "APIError", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Invalid decoded string"]))
                        }
                    } else {
                        print("Base64 string not found in response.")
                        completion(nil, NSError(domain: "APIError", code: 1005, userInfo: [NSLocalizedDescriptionKey: "Base64 encoded data missing in response"]))
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }*/
    }
    func PayUSecondForRechargeServiceApi(dict:NSDictionary,completion: @escaping (PayUFirstForRecharge?, Error?) -> ()) {
        
        // Encrypt the dictionary
        let encryptedData = EncryptionService.shared.finalParam(dict)
        print(encryptedData)
        //print("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.PayUFirstForRechargeApi)")
        print(dict)
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.PayUSecondForRechargeApi)", method: .post, parameters: encryptedData as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let responseData = response.data, responseData.count > 0 else {
                    completion(nil, NSError(domain: "APIError", code: 1002, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                do {
                    let dict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                    // Process base64-encoded string
                    if let base64Encoded = dict?["data"] as? String {
                        // Base64 decoding
                        guard let decodedData = Data(base64Encoded: base64Encoded),
                              let decodedString = String(data: decodedData, encoding: .utf8) else {
                            completion(nil, NSError(domain: "APIError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Base64 decoding failed"]))
                            return
                        }
                        
                        // Convert the decoded string to a dictionary
                        if let decodedDict = EncryptionService.shared.convertToDictionary(text: decodedString) {
                            do {
                                // Decrypt the data
                                let decryptedData = try EncryptionService.shared.decrypt(encrypted: decodedDict["encrypted"] as! String, iv: decodedDict["iv"] as! String, authTag: decodedDict["authTag"] as! String, jwtToken: Common.shared.token ?? "")
                                
                                if let stringData = decryptedData {
                                    if let jsonData = stringData.data(using: .utf8) {
                                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                        if let dictionary = jsonObject as? [String: Any] {
                                            print("dictionary:",dictionary)
                                            // Now we have a dictionary, proceed with serialization
                                            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                                            // Decode the data into a model
                                            print("Data Results:",data)
                                            let model = try JSONDecoder().decode(PayUFirstForRecharge.self, from: data)
                                            completion(model, nil)
                                        }
                                    }
                                }
                            } catch {
                                // Handle decryption or decoding errors
                                print("Decryption or JSON decoding failed: \(error.localizedDescription)")
                                completion(nil, error)
                            }
                        } else {
                            print("Failed to convert decoded string to dictionary.")
                            completion(nil, NSError(domain: "APIError", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Invalid decoded string"]))
                        }
                    } else {
                        print("Base64 string not found in response.")
                        completion(nil, NSError(domain: "APIError", code: 1005, userInfo: [NSLocalizedDescriptionKey: "Base64 encoded data missing in response"]))
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
   
    
    
    func CircleServiceApi(dict:NSDictionary,completion: @escaping (CircleModel_Base?, Error?) -> ()) {
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.circleApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //  print(data)
                    do{
                        let model = try JSONDecoder().decode(CircleModel_Base.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    //wallet/swallet/deduct-swallet-balance
    
    func PaymentWalletDeductModelApi(dict:NSDictionary,completion: @escaping (PaymentWalletDeduct_Model?, Error?) -> ()) {
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.deductWalletApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headersWithoutSkey).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //  print(data)
                    do{
                        let model = try JSONDecoder().decode(PaymentWalletDeduct_Model.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    
    
    func RechargeModelApi(dict:NSDictionary,completion: @escaping (RechargeModel_Base?, Error?) -> ()) {
        
        let encryptedData = EncryptionService.shared.finalParam(dict)
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.PayUSecondForRechargeApi)", method: .post, parameters: encryptedData as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
           if response.result.isSuccess{
               guard let responseData = response.data, responseData.count > 0 else {
                   completion(nil, NSError(domain: "APIError", code: 1002, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                   return
               }
               do {
                   let dict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                   // Process base64-encoded string
                   if let base64Encoded = dict?["data"] as? String {
                       // Base64 decoding
                       guard let decodedData = Data(base64Encoded: base64Encoded),
                             let decodedString = String(data: decodedData, encoding: .utf8) else {
                           completion(nil, NSError(domain: "APIError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Base64 decoding failed"]))
                           return
                       }
                       
                       // Convert the decoded string to a dictionary
                       if let decodedDict = EncryptionService.shared.convertToDictionary(text: decodedString) {
                           do {
                               // Decrypt the data
                               let decryptedData = try EncryptionService.shared.decrypt(encrypted: decodedDict["encrypted"] as! String, iv: decodedDict["iv"] as! String, authTag: decodedDict["authTag"] as! String, jwtToken: Common.shared.token ?? "")
                               
                               if let stringData = decryptedData {
                                   if let jsonData = stringData.data(using: .utf8) {
                                       let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                       if let dictionary = jsonObject as? [String: Any] {
                                           print("dictionary:",dictionary)
                                           // Now we have a dictionary, proceed with serialization
                                           let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                                           // Decode the data into a model
                                           print("Data Results:",data)
                                           let model = try JSONDecoder().decode(RechargeModel_Base.self, from: data)
                                           completion(model, nil)
                                       }
                                   }
                               }
                           } catch {
                               // Handle decryption or decoding errors
                               print("Decryption or JSON decoding failed: \(error.localizedDescription)")
                               completion(nil, error)
                           }
                       } else {
                           print("Failed to convert decoded string to dictionary.")
                           completion(nil, NSError(domain: "APIError", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Invalid decoded string"]))
                       }
                   } else {
                       print("Base64 string not found in response.")
                       completion(nil, NSError(domain: "APIError", code: 1005, userInfo: [NSLocalizedDescriptionKey: "Base64 encoded data missing in response"]))
                   }
               } catch {
                   print(error.localizedDescription)
               }
           }
            //{
//                guard let dictResponse = response.data, dictResponse.count > 0 else {
//                    return
//                }
//                if let data = response.data, data.count > 0{
//                    
//                    
//                    
//                    
//                    
//                    
//                    //  print(data)
////                    do{
////                        let model = try JSONDecoder().decode(RechargeModel_Base.self, from: data)
////                        // print(model)
////                        completion(model,nil)
////                        
////                    }catch{}
//                    
//                }
//            }
        }
    }
    
    
    
    func GetMilesApi(dict:NSDictionary,completion: @escaping (GetMilesModel_Base?, Error?) -> ()) {
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.milesModellApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //  print(data)
                    do{
                        let model = try JSONDecoder().decode(GetMilesModel_Base.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    
    func GetwalletdetailsApi(dict:NSDictionary,completion: @escaping (GetWalletDetailsApi_Base?, Error?) -> ()) {
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.getwalletdetailsApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    print(data)
                    do{
                        let model = try JSONDecoder().decode(GetWalletDetailsApi_Base.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    //AllmilesTransactionViewModel
    
    
    func GetAllmilesTransactionModelApi(dict:NSDictionary,completion: @escaping (AllmilesTransactionModel?, Error?) -> ()) {
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.allmilesTransApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    print(data)
                    do{
                        let model = try JSONDecoder().decode(AllmilesTransactionModel.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    
    
    
    func GetHotelSearchModelApi(dict:NSDictionary,completion: @escaping (HotelSearchModel_Base?, Error?) -> ()) {
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.hotelModelSearchApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    // print(data)
                    do{
                        let model = try JSONDecoder().decode(HotelSearchModel_Base.self, from: data)
                        
                        print(model)
                        completion(model,nil)
                        
                    }catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key.stringValue)' not found:", context.debugDescription)
                        print("CodingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context) {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("CodingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("CodingPath:", context.codingPath)
                    } catch let DecodingError.dataCorrupted(context) {
                        print("Data corrupted:", context.debugDescription)
                    } catch {
                        print("Error:", error.localizedDescription)
                    }
                    
                }
            }
        }
    }
    
    
    func GetHotelRoomTypesApi(dict:NSDictionary,completion: @escaping (HotelRoomTypesModel_Base?, Error?) -> ()) {
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.hotelRoomTypesApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    // print(data)
                    do{
                        let model = try JSONDecoder().decode(HotelRoomTypesModel_Base.self, from: data)
                        
                        print(model)
                        completion(model,nil)
                        
                    }catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key.stringValue)' not found:", context.debugDescription)
                        print("CodingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context) {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("CodingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("CodingPath:", context.codingPath)
                    } catch let DecodingError.dataCorrupted(context) {
                        print("Data corrupted:", context.debugDescription)
                    } catch {
                        print("Error:", error.localizedDescription)
                    }
                    
                }
            }
        }
    }
    
    
    func GetHotelBookingApi(dict:NSDictionary,completion: @escaping (HotelBook_Model?, Error?) -> ()) {
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.hotelBookApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    // print(data)
                    do{
                        let model = try JSONDecoder().decode(HotelBook_Model.self, from: data)
                        
                        print(model)
                        completion(model,nil)
                        
                    }catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key.stringValue)' not found:", context.debugDescription)
                        print("CodingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context) {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("CodingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("CodingPath:", context.codingPath)
                    } catch let DecodingError.dataCorrupted(context) {
                        print("Data corrupted:", context.debugDescription)
                    } catch {
                        print("Error:", error.localizedDescription)
                    }
                    
                }
            }
        }
    }
    
    
    func GetHotelDetailsApi(dict:NSDictionary,completion: @escaping (HotelDetals_Base?, Error?) -> ()) {
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.hotelDetailsApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    // print(data)
                    do{
                        let model = try JSONDecoder().decode(HotelDetals_Base.self, from: data)
                        
                        print(model)
                        completion(model,nil)
                        
                    }catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key.stringValue)' not found:", context.debugDescription)
                        print("CodingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context) {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("CodingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("CodingPath:", context.codingPath)
                    } catch let DecodingError.dataCorrupted(context) {
                        print("Data corrupted:", context.debugDescription)
                    } catch {
                        print("Error:", error.localizedDescription)
                    }
                    
                }
            }
        }
    }
    
    func RankAllModelApi(completion: @escaping (RankModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.rankAllApi)", method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //print(data)
                    do{
                        switch response.result{
                        case .success(let value):
                            print("The value is : \(String(describing: response.error))")
                            
                        case .failure(let err):
                            print(err.localizedDescription)
                        }
                        let model = try JSONDecoder().decode(RankModel.self, from: data)
                        // print(model)
                        completion(model,nil)
                        SwiftLoader.hide()
                    }catch{}
                    
                }
            }
        }
    }
    
    
    
    func ChainModelApi(dict:NSDictionary,completion: @escaping (ChainModel_Base?, Error?) -> ()) {
        let encryptedData = EncryptionService.shared.finalParam(dict)
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.chainReferApi)", method: .post, parameters: encryptedData as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                print("Dict-Response..\(dictResponse)")
                do{
                     let dict = try JSONSerialization.jsonObject(with: dictResponse, options: []) as? [String: Any]
                     
                     
                     // Process base64-encoded string
                     if let base64Encoded = dict?["data"] as? String {
                         // Base64 decoding
                         guard let decodedData = Data(base64Encoded: base64Encoded),
                               let decodedString = String(data: decodedData, encoding: .utf8) else {
                             completion(nil, NSError(domain: "APIError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Base64 decoding failed"]))
                             return
                         }
                         
                         // Convert the decoded string to a dictionary
                         if let decodedDict = EncryptionService.shared.convertToDictionary(text: decodedString) {
                             do {
                                 // Decrypt the data
                                 let decryptedData = try EncryptionService.shared.decrypt(encrypted: decodedDict["encrypted"] as! String, iv: decodedDict["iv"] as! String, authTag: decodedDict["authTag"] as! String, jwtToken: Common.shared.token ?? "")
                                 
                                 if let stringData = decryptedData {
                                     if let jsonData = stringData.data(using: .utf8) {
                                         let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                         if let dictionary = jsonObject as? [String: Any] {
                                             // Now we have a dictionary, proceed with serialization
                                             let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                                             // Decode the data into a model
                                             let model = try JSONDecoder().decode(ChainModel_Base.self.self, from: data)
                                             completion(model, nil)
                                         }
                                     }
                                 }
                                 
                             } catch {
                                 // Handle decryption or decoding errors
                                 print("Decryption or JSON decoding failed: \(error.localizedDescription)")
                                 completion(nil, error)
                             }
                         } else {
                             print("Failed to convert decoded string to dictionary.")
                             completion(nil, NSError(domain: "APIError", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Invalid decoded string"]))
                         }
                         //            } else {
                         //                print("Base64 string not found in response.")
                         //                completion(nil, NSError(domain: "APIError", code: 1005, userInfo: [NSLocalizedDescriptionKey: "Base64 encoded data missing in response"]))
                         //            }
                         SwiftLoader.hide()
                         
                     }
                 } catch {
                     SwiftLoader.hide()
                     print(error.localizedDescription)
                 }
//                if let data = response.data, data.count > 0{
//                    //  print(data)
//                    do{
//                        let model = try JSONDecoder().decode(ChainModel_Base.self, from: data)
//                        // print(model)
//                        completion(model,nil)
//                        
//                    }catch{}
//                    
//                }
            }
        }
    }
    
    
    
    func ChainReferDetailsApi(dict:NSDictionary,completion: @escaping (ChainModel_Base?, Error?) -> ()) {
        let encryptedData = EncryptionService.shared.finalParam(dict)
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.getReferDetailsApi)", method: .post, parameters: encryptedData as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                print("Dict-Response..\(dictResponse)")
                do{
                     let dict = try JSONSerialization.jsonObject(with: dictResponse, options: []) as? [String: Any]
                     
                     
                     // Process base64-encoded string
                     if let base64Encoded = dict?["data"] as? String {
                         // Base64 decoding
                         guard let decodedData = Data(base64Encoded: base64Encoded),
                               let decodedString = String(data: decodedData, encoding: .utf8) else {
                             completion(nil, NSError(domain: "APIError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Base64 decoding failed"]))
                             return
                         }
                         
                         // Convert the decoded string to a dictionary
                         if let decodedDict = EncryptionService.shared.convertToDictionary(text: decodedString) {
                             do {
                                 // Decrypt the data
                                 let decryptedData = try EncryptionService.shared.decrypt(encrypted: decodedDict["encrypted"] as! String, iv: decodedDict["iv"] as! String, authTag: decodedDict["authTag"] as! String, jwtToken: Common.shared.token ?? "")
                                 
                                 if let stringData = decryptedData {
                                     if let jsonData = stringData.data(using: .utf8) {
                                         let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                         if let dictionary = jsonObject as? [String: Any] {
                                             // Now we have a dictionary, proceed with serialization
                                             let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                                             print("model data: \(data)")
                                             // Decode the data into a model
                                             let model = try JSONDecoder().decode(ChainModel_Base.self.self, from: data)
                                             print("model json data: \(model)")
                                             completion(model, nil)
                                         }
                                     }
                                 }
                                 
                             } catch {
                                 // Handle decryption or decoding errors
                                 print("Decryption or JSON decoding failed: \(error.localizedDescription)")
                                 completion(nil, error)
                             }
                         } else {
                             print("Failed to convert decoded string to dictionary.")
                             completion(nil, NSError(domain: "APIError", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Invalid decoded string"]))
                         }
                         //            } else {
                         //                print("Base64 string not found in response.")
                         //                completion(nil, NSError(domain: "APIError", code: 1005, userInfo: [NSLocalizedDescriptionKey: "Base64 encoded data missing in response"]))
                         //            }
                         SwiftLoader.hide()
                         
                     }
                 } catch {
                     SwiftLoader.hide()
                     print(error.localizedDescription)
                 }
//                if let data = response.data, data.count > 0{
//                    //  print(data)
//                    do{
//                        let model = try JSONDecoder().decode(ChainModel_Base.self, from: data)
//                        // print(model)
//                        completion(model,nil)
//
//                    }catch{}
//
//                }
            }
        }
    }
    
    
    
    
    
    //searchFlightOneApi
    
    
    
    func searchFlightOneApi(dict:NSDictionary,completion: @escaping (FlightSearchModel_Base?, Error?) -> ()) {
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.searchFlightOneApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //  print(data)
                    do{
                        let model = try JSONDecoder().decode(FlightSearchModel_Base.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    
    func searchFlightRoundTripApi(dict:NSDictionary,completion: @escaping (FlightSearchModel_Base?, Error?) -> ()) {
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.searchFlightOneApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //  print(data)
                    do{
                        let model = try JSONDecoder().decode(FlightSearchModel_Base.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    
    
    
    func FlightOriginCityListApi(dict:NSDictionary,completion: @escaping (Origin_Base?, Error?) -> ()) {
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.origionCityApi)", method: .post, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headersNew).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //  print(data)
                    do{
                        let model = try JSONDecoder().decode(Origin_Base.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    func userTxnStatusApi(dict:NSDictionary,completion: @escaping (Origin_Base?, Error?) -> ()) {
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.UpiUserTxnStatus)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //  print(data)
                    do{
                        let model = try JSONDecoder().decode(Origin_Base.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    
    func GetQuizModelApi(dict:NSDictionary,completion: @escaping (GetQuizModel_Base?, Error?) -> ()) {
        let encryptedData = EncryptionService.shared.finalParam(dict)
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.getQuizApi)", method: .post, parameters: encryptedData as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    SwiftLoader.hide()
                    return
                }
                
               do {
                    let dict = try JSONSerialization.jsonObject(with: dictResponse, options: []) as? [String: Any]
                    
                    
                    // Process base64-encoded string
                    if let base64Encoded = dict?["data"] as? String {
                        // Base64 decoding
                        guard let decodedData = Data(base64Encoded: base64Encoded),
                              let decodedString = String(data: decodedData, encoding: .utf8) else {
                            completion(nil, NSError(domain: "APIError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Base64 decoding failed"]))
                            return
                        }
                        
                        // Convert the decoded string to a dictionary
                        if let decodedDict = EncryptionService.shared.convertToDictionary(text: decodedString) {
                            do {
                                // Decrypt the data
                                let decryptedData = try EncryptionService.shared.decrypt(encrypted: decodedDict["encrypted"] as! String, iv: decodedDict["iv"] as! String, authTag: decodedDict["authTag"] as! String, jwtToken: Common.shared.token ?? "")
                                
                                if let stringData = decryptedData {
                                    if let jsonData = stringData.data(using: .utf8) {
                                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                        if let dictionary = jsonObject as? [String: Any] {
                                            // Now we have a dictionary, proceed with serialization
                                            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                                            // Decode the data into a model
                                            let model = try JSONDecoder().decode(GetQuizModel_Base.self.self, from: data)
                                            completion(model, nil)
                                        }
                                    }
                                }
                                
                            } catch {
                                // Handle decryption or decoding errors
                                print("Decryption or JSON decoding failed: \(error.localizedDescription)")
                                completion(nil, error)
                            }
                        } else {
                            print("Failed to convert decoded string to dictionary.")
                            completion(nil, NSError(domain: "APIError", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Invalid decoded string"]))
                        }
                        //            } else {
                        //                print("Base64 string not found in response.")
                        //                completion(nil, NSError(domain: "APIError", code: 1005, userInfo: [NSLocalizedDescriptionKey: "Base64 encoded data missing in response"]))
                        //            }
                        SwiftLoader.hide()
                        
                    }
                } catch {
                    SwiftLoader.hide()
                    print(error.localizedDescription)
                }
//                if let data = response.data, data.count > 0{
//                    //  print(data)
//                    do{
//                        let model = try JSONDecoder().decode(GetQuizModel_Base.self, from: data)
//                        // print(model)
//                        completion(model,nil)
//                        
//                    }catch{}
//                    
//                }
            }
        }
    }
    
    
    func AttendQuizModelApi(dict:NSDictionary,completion: @escaping (AttendQuizModel_Base?, Error?) -> ()) {
        let encryptedData = EncryptionService.shared.finalParam(dict)
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.attendQuizApi)", method: .post, parameters: encryptedData as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                do {
                     let dict = try JSONSerialization.jsonObject(with: dictResponse, options: []) as? [String: Any]
                     
                     
                     // Process base64-encoded string
                     if let base64Encoded = dict?["data"] as? String {
                         // Base64 decoding
                         guard let decodedData = Data(base64Encoded: base64Encoded),
                               let decodedString = String(data: decodedData, encoding: .utf8) else {
                             completion(nil, NSError(domain: "APIError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Base64 decoding failed"]))
                             return
                         }
                         
                         // Convert the decoded string to a dictionary
                         if let decodedDict = EncryptionService.shared.convertToDictionary(text: decodedString) {
                             do {
                                 // Decrypt the data
                                 let decryptedData = try EncryptionService.shared.decrypt(encrypted: decodedDict["encrypted"] as! String, iv: decodedDict["iv"] as! String, authTag: decodedDict["authTag"] as! String, jwtToken: Common.shared.token ?? "")
                                 
                                 if let stringData = decryptedData {
                                     if let jsonData = stringData.data(using: .utf8) {
                                         let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                         if let dictionary = jsonObject as? [String: Any] {
                                             // Now we have a dictionary, proceed with serialization
                                             let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                                             // Decode the data into a model
                                             let model = try JSONDecoder().decode(AttendQuizModel_Base.self.self, from: data)
                                             completion(model, nil)
                                         }
                                     }
                                 }
                                 
                             } catch {
                                 // Handle decryption or decoding errors
                                 print("Decryption or JSON decoding failed: \(error.localizedDescription)")
                                 completion(nil, error)
                             }
                         } else {
                             print("Failed to convert decoded string to dictionary.")
                             completion(nil, NSError(domain: "APIError", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Invalid decoded string"]))
                         } 
                         //            } else {
                         //                print("Base64 string not found in response.")
                         //                completion(nil, NSError(domain: "APIError", code: 1005, userInfo: [NSLocalizedDescriptionKey: "Base64 encoded data missing in response"]))
                         //            }
                         SwiftLoader.hide()
                         
                     }
                 } catch {
                     SwiftLoader.hide()
                     print(error.localizedDescription)
                 }
//                if let data = response.data, data.count > 0{
//                    //  print(data)
//                    do{
//                        let model = try JSONDecoder().decode(AttendQuizModel_Base.self, from: data)
//                        // print(model)
//                        completion(model,nil)
//                        
//                    }catch{}
//                    
//                }
            }
        }
    }
    
    
    func ResultQuizModelApi(dict:NSDictionary,completion: @escaping (ResultQuizModel_Base?, Error?) -> ()) {
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.resultQuizApi)", method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //  print(data)
                    do{
                        let model = try JSONDecoder().decode(ResultQuizModel_Base.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    
    
    func OperatorApiServiceApi(dict:NSDictionary,completion: @escaping (Operator_Base?, Error?) -> ()) {
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.operatorApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //  print(data)
                    do{
                        let model = try JSONDecoder().decode(Operator_Base.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    
    
    
    func dashboardBalanceServiceApi(dict:NSDictionary,completion: @escaping (BalanceDetailsModel?, Error?) -> ()) {
        let encryptedData = EncryptionService.shared.finalParam(dict)
        let endpoint = "api/wallet/2.0/get-card-details"
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(endpoint)", method: .post, parameters: encryptedData as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                do {
                    let dict = try JSONSerialization.jsonObject(with: dictResponse, options: []) as? [String: Any]
                    //oprint(dict)
                    
                    // Process base64-encoded string
                    if let base64Encoded = dict?["data"] as? String {
                        // Base64 decoding
                        guard let decodedData = Data(base64Encoded: base64Encoded),
                              let decodedString = String(data: decodedData, encoding: .utf8) else {
                            completion(nil, NSError(domain: "APIError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Base64 decoding failed"]))
                            return
                        }
                        
                        // Convert the decoded string to a dictionary
                        if let decodedDict = EncryptionService.shared.convertToDictionary(text: decodedString) {
                            do {
                                // Decrypt the data
                                let decryptedData = try EncryptionService.shared.decrypt(encrypted: decodedDict["encrypted"] as! String, iv: decodedDict["iv"] as! String, authTag: decodedDict["authTag"] as! String, jwtToken: Common.shared.token ?? "")
                                
                                if let stringData = decryptedData {
                                    if let jsonData = stringData.data(using: .utf8) {
                                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                        if let dictionary = jsonObject as? [String: Any] {
                                            // Now we have a dictionary, proceed with serialization
                                            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                                            // Decode the data into a model
                                            let model = try JSONDecoder().decode(BalanceDetailsModel.self, from: data)
                                            completion(model, nil)
                                        }
                                    }
                                }
                                
                            } catch {
                                // Handle decryption or decoding errors
                                print("Decryption or JSON decoding failed: \(error.localizedDescription)")
                                completion(nil, error)
                            }
                        } else {
                            print("Failed to convert decoded string to dictionary.")
                            completion(nil, NSError(domain: "APIError", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Invalid decoded string"]))
                        }
                        //            } else {
                        //                print("Base64 string not found in response.")
                        //                completion(nil, NSError(domain: "APIError", code: 1005, userInfo: [NSLocalizedDescriptionKey: "Base64 encoded data missing in response"]))
                        //            }
                        SwiftLoader.hide()
                        
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            
            }
        }
    }
    
    func dashboardSecondaryBalanceServiceApi(dict:NSDictionary,completion: @escaping (SecondaryWalletBalance?, Error?) -> ()) {
        let encryptedData = EncryptionService.shared.finalParam(dict)
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.BaseURL.apiVersionNew)\(ConstantApi.SubURL.getSecondaryWalletBalance)", method: .post, parameters: encryptedData as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.appVersionHeaders).responseJSON {  response in
            print(response)
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //  print(data)
                    // print(ConstantApi.headers)
                    do{
                        let model = try JSONDecoder().decode(SecondaryWalletBalance.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    func payBillListServiceApi(dict:NSDictionary,completion: @escaping (PayBillListModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.payBillList)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //   print(data)
                    // print(ConstantApi.headers)
                    do{
                        let model = try JSONDecoder().decode(PayBillListModel.self, from: data)
                        //print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    func catagoryListServiceApi(dict:NSDictionary,completion: @escaping (ResponseDataPayU?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.catagoryList)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headersWithoutSkey).responseJSON {  response in
            if response.result.isSuccess{
              
                print(response)
                
                
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                   
                }
                if let data = response.data, data.count > 0{
                     print(data)
                    // print(ConstantApi.headers)
                    do{
                        let model = try JSONDecoder().decode(ResponseDataPayU.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    func fetechBillServiceApi(dict:NSDictionary,completion: @escaping (FetechBillModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.fetechBill)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headersWithoutSkey).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
//                    print(data)
                    //print(ConstantApi.headers)
                    do{
                        print("The value is : \(response.result.value ?? "")")
                        let model = try JSONDecoder().decode(FetechBillModel.self, from: data)
                        //print(model)
                        completion(model,nil)
                        
                    }catch{
                        print(error)
                    }
                    
                }
            }
        }
    }
    func fetechBillValidationServiceApi(dict:NSDictionary,completion: @escaping (FetechBillValidationModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.fetechBiillValF)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //  print(data)
                    // print(ConstantApi.headers)
                    do{
                        // print("The value is : \(response.result.value ?? "")")
                        let model = try JSONDecoder().decode(FetechBillValidationModel.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    func fetechBillValidationBillPaymentServiceApi(dict:NSDictionary,completion: @escaping (FetechValaidationPayment?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.billPayment)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //  print(data)
                    // print(ConstantApi.headers)
                    do{
                        // print("The value is : \(response.result.value ?? "")")
                        let model = try JSONDecoder().decode(FetechValaidationPayment.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    func cityServiceApi(dict:NSDictionary,completion: @escaping (CityModel?, Error?) -> ()) {
        
        let encryptedData = EncryptionService.shared.finalParam(dict)
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.BaseURL.apiVersion)\(ConstantApi.SubURL.city)", method: .post, parameters: encryptedData as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headersWithoutSkey).responseJSON {   response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                do {
                    let dict = try JSONSerialization.jsonObject(with: dictResponse, options: []) as? [String: Any]
                    //oprint(dict)
                    
                    // Process base64-encoded string
                    if let base64Encoded = dict?["data"] as? String {
                        // Base64 decoding
                        guard let decodedData = Data(base64Encoded: base64Encoded),
                              let decodedString = String(data: decodedData, encoding: .utf8) else {
                            completion(nil, NSError(domain: "APIError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Base64 decoding failed"]))
                            return
                        }
                        
                        // Convert the decoded string to a dictionary
                        if let decodedDict = EncryptionService.shared.convertToDictionary(text: decodedString) {
                            do {
                                // Decrypt the data
                                let decryptedData = try EncryptionService.shared.decrypt(encrypted: decodedDict["encrypted"] as! String, iv: decodedDict["iv"] as! String, authTag: decodedDict["authTag"] as! String, jwtToken: Common.shared.token ?? "")
                                
                                if let stringData = decryptedData {
                                    if let jsonData = stringData.data(using: .utf8) {
                                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                        if let dictionary = jsonObject as? [String: Any] {
                                            // Now we have a dictionary, proceed with serialization
                                            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                                            // Decode the data into a model
                                            let model = try JSONDecoder().decode(CityModel.self, from: data)
                                            completion(model, nil)
                                        }
                                    }
                                }
                                
                            } catch {
                                // Handle decryption or decoding errors
                                print("Decryption or JSON decoding failed: \(error.localizedDescription)")
                                completion(nil, error)
                            }
                        } else {
                            print("Failed to convert decoded string to dictionary.")
                            completion(nil, NSError(domain: "APIError", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Invalid decoded string"]))
                        }
                        //            } else {
                        //                print("Base64 string not found in response.")
                        //                completion(nil, NSError(domain: "APIError", code: 1005, userInfo: [NSLocalizedDescriptionKey: "Base64 encoded data missing in response"]))
                        //            }
                       
                        
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            
            
        }
                    // print(data)
                    // print(ConstantApi.headers)
//                    do{
//                        // print("The value is : \(String(describing: response.result.value))")
//                        let model = try JSONDecoder().decode(CityModel.self, from: data)
//                        //print(model)
//                        completion(model,nil)
//                        
//                    }catch{}
                    
              //  }
            //}
        }
    }
    
    func BusListServiceApi(dict:NSDictionary,completion: @escaping (BusListModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.BaseURL.apiVersion)\(ConstantApi.SubURL.busList)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //  print(data)
                    do{
                        // print("The value is : \(String(describing: response.result.value))")
                        switch response.result{
                        case .success(let value):
                            
                            dictBusList = SwiftyJSON.JSON(value)
                        case .failure(let err):
                            print(err.localizedDescription)
                        }
                        let model = try JSONDecoder().decode(BusListModel.self, from: data)
                        // print(model)
                        completion(model,nil)
                        SwiftLoader.hide()
                    }catch{}
                    
                }
            }
        }
    }
    
    func weatherServiceApi(city: String, completion: @escaping (WeatherModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.BaseURL.apiVersion)\(ConstantApi.SubURL.weatherApi + city)", method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //print(data)
                    do{
                        switch response.result{
                        case .success(let value):
                            print("The value is : \(String(describing: response.error))")
                            
                        case .failure(let err):
                            print(err.localizedDescription)
                        }
                        let model = try JSONDecoder().decode(WeatherModel.self, from: data)
                        // print(model)
                        completion(model,nil)
                        SwiftLoader.hide()
                    }catch{}
                    
                }
            }
        }
    }
    
    func seatsDetailsServiceApi(dict:NSDictionary,completion: @escaping (SeatModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.BaseURL.apiVersion)\(ConstantApi.SubURL.seatDetails)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    do{
                        print("The value is : \(String(describing: response.error))")
                        switch response.result{
                        case .success(let value):
                            
                            dictBusSeatList  = SwiftyJSON.JSON(value)
                        case .failure(let err):
                            print(err.localizedDescription)
                        }
                        
                        let model = try JSONDecoder().decode(SeatModel.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    func busReviewServiceApi(dict:NSDictionary,completion: @escaping (BusRevieweModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.BaseURL.apiVersion)\(ConstantApi.SubURL.busBooking)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //  print(data)
                    // print(ConstantApi.headers)
                    do{
                        //print("The value is : \(response.result.value)")
                        let model = try JSONDecoder().decode(BusRevieweModel.self, from: data)
                        //print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    func busBookServiceApi(dict:NSDictionary,completion: @escaping (BusBookModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.busBookingBus)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    // print(data)
                    // print(ConstantApi.headers)
                    do{
                        //print("The value is : \(response.result.value)")
                        let model = try JSONDecoder().decode(BusBookModel.self, from: data)
                        //  print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    func deductWalletBalanceServiceApi(dict:NSDictionary,completion: @escaping (DeductSWalletModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.deductSWalletBalance)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //print(data)
                    // print(ConstantApi.headers)
                    do{
                        // print("The value is : \(response.result.value)")
                        let model = try JSONDecoder().decode(DeductSWalletModel.self, from: data)
                        // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    
    func checksumServiceApi(dict: NSDictionary, completion: @escaping (ChecksumModel?, Error?) -> ()) {
        
        // Encrypt the dictionary
        let encryptedData = EncryptionService.shared.finalParam(dict)
        print("CSingh ConstantApi.headers: \(ConstantApi.headers)")
        // Send the request
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.checksum)",
                          method: .post,
                          parameters: encryptedData as? Parameters,
                          encoding: JSONEncoding.prettyPrinted,
                          headers: ConstantApi.headers)
        .responseJSON { response in
            if response.result.isSuccess{
                // Check if the response was successful
                //            guard let responseDict = response.error as? [String: Any] else {
                //                debugPrint("Response did not contain a valid dictionary: \(response)")
                //                completion(nil, NSError(domain: "APIError", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"]))
                //                return
                //            }
                
                // Check if response data exists and is not empty
                guard let responseData = response.data, responseData.count > 0 else {
                    completion(nil, NSError(domain: "APIError", code: 1002, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                
                do {
                    let dict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                    //print(dict)
                    
                    // Process base64-encoded string
                    if let base64Encoded = dict?["data"] as? String {
                        // Base64 decoding
                        guard let decodedData = Data(base64Encoded: base64Encoded),
                              let decodedString = String(data: decodedData, encoding: .utf8) else {
                            completion(nil, NSError(domain: "APIError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Base64 decoding failed"]))
                            return
                        }
                        
                        // Convert the decoded string to a dictionary
                        if let decodedDict = EncryptionService.shared.convertToDictionary(text: decodedString) {
                            do {
                                // Decrypt the data
                                let decryptedData = try EncryptionService.shared.decrypt(encrypted: decodedDict["encrypted"] as! String, iv: decodedDict["iv"] as! String, authTag: decodedDict["authTag"] as! String, jwtToken: Common.shared.token ?? "")
                                
                                if let stringData = decryptedData {
                                    if let jsonData = stringData.data(using: .utf8) {
                                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                        if let dictionary = jsonObject as? [String: Any] {
                                            // Now we have a dictionary, proceed with serialization
                                            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                                            // Decode the data into a model
                                            let model = try JSONDecoder().decode(ChecksumModel.self, from: data)
                                            completion(model, nil)
                                        }
                                    }
                                }
                                
                            } catch {
                                // Handle decryption or decoding errors
                                print("Decryption or JSON decoding failed: \(error.localizedDescription)")
                                completion(nil, error)
                            }
                        } else {
                            print("Failed to convert decoded string to dictionary.")
                            completion(nil, NSError(domain: "APIError", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Invalid decoded string"]))
                        }
                        //            } else {
                        //                print("Base64 string not found in response.")
                        //                completion(nil, NSError(domain: "APIError", code: 1005, userInfo: [NSLocalizedDescriptionKey: "Base64 encoded data missing in response"]))
                        //            }
                        SwiftLoader.hide()
                        
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    //
    //    func callToDecrypt(dict : NSDictionary) throws -> String {
    //
    //        let decryped = try EncryptionService.shared.decrypt(encrypted: dict["encrypted"] as! String, iv: dict["iv"] as! String, authTag: dict["authTag"] as! String, jwtToken: Common.shared.token ?? "")
    //        return decryped
    //    }
    
    
    func notificationListServiceApi(dict:NSDictionary, completion: @escaping (NotificationListModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.notificationList)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    // print(data)
                    do{
                        // print("The value is : \(String(describing: response.result.value))")
                        switch response.result{
                        case .success(let value):
                            print(value)
                            //                            notificationList = SwiftyJSON.JSON(value)
                        case .failure(let err):
                            print(err.localizedDescription)
                        }
                        let model = try JSONDecoder().decode(NotificationListModel.self, from: data)
                        // print(model)
                        completion(model,nil)
                        SwiftLoader.hide()
                    }catch{}
                    
                }
            }
        }
    }
    
    func addNotificationTokenServiceApi(dict:NSDictionary, completion: @escaping (NotificationListModel?, Error?) -> ()) {
        
        // Encrypt the dictionary
        let encryptedData = EncryptionService.shared.finalParam(dict)
        print(encryptedData)
        print("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.notificationAddToken)")
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.notificationAddToken)", method: .post, parameters: encryptedData as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                // Check if the response was successful
                //                guard let responseDict = response.error as? [String: Any] else {
                //                    debugPrint("Response did not contain a valid dictionary: \(response)")
                //                    completion(nil, NSError(domain: "APIError", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"]))
                //                    return
                //                }
                
                // Check if response data exists and is not empty
                guard let responseData = response.data, responseData.count > 0 else {
                    completion(nil, NSError(domain: "APIError", code: 1002, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                do {
                    let dict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                    //print(dict)
                    // Process base64-encoded string
                    if let base64Encoded = dict?["data"] as? String {
                        // Base64 decoding
                        guard let decodedData = Data(base64Encoded: base64Encoded),
                              let decodedString = String(data: decodedData, encoding: .utf8) else {
                            completion(nil, NSError(domain: "APIError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Base64 decoding failed"]))
                            return
                        }
                        
                        // Convert the decoded string to a dictionary
                        if let decodedDict = EncryptionService.shared.convertToDictionary(text: decodedString) {
                            do {
                                // Decrypt the data
                                let decryptedData = try EncryptionService.shared.decrypt(encrypted: decodedDict["encrypted"] as! String, iv: decodedDict["iv"] as! String, authTag: decodedDict["authTag"] as! String, jwtToken: Common.shared.token ?? "")
                                
                                if let stringData = decryptedData {
                                    if let jsonData = stringData.data(using: .utf8) {
                                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                        if let dictionary = jsonObject as? [String: Any] {
                                            // Now we have a dictionary, proceed with serialization
                                            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                                            // Decode the data into a model
                                            let model = try JSONDecoder().decode(NotificationListModel.self, from: data)
                                            completion(model, nil)
                                        }
                                    }
                                }
                                
                            } catch {
                                // Handle decryption or decoding errors
                                print("Decryption or JSON decoding failed: \(error.localizedDescription)")
                                completion(nil, error)
                            }
                        } else {
                            print("Failed to convert decoded string to dictionary.")
                            completion(nil, NSError(domain: "APIError", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Invalid decoded string"]))
                        }
                    } else {
                        print("Base64 string not found in response.")
                        completion(nil, NSError(domain: "APIError", code: 1005, userInfo: [NSLocalizedDescriptionKey: "Base64 encoded data missing in response"]))
                    }
                    SwiftLoader.hide()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func complaintListServiceApi(dict:NSDictionary, completion: @escaping (ComplaintListModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.transactionList)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    print(data)
                    do{
                        //print("The value is : \(String(describing: response.result.value))")
                        switch response.result{
                        case .success(let value):
                            print(value)
                        case .failure(let err):
                            print(err.localizedDescription)
                        }
                        let model = try JSONDecoder().decode(ComplaintListModel.self, from: data)
                        // print(model)
                        completion(model,nil)
                        SwiftLoader.hide()
                    }catch{}
                    
                }
            }
        }
    }
    
    func complaintRegisterServiceApi(dict:NSDictionary, completion: @escaping (RegisterComplaintModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.registerComplaint)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //print(data)
                    do{
                        //  print("The value is : \(String(describing: response.result.value))")
                        switch response.result{
                        case .success(let value):
                            print(value)
                        case .failure(let err):
                            print(err.localizedDescription)
                        }
                        let model = try JSONDecoder().decode(RegisterComplaintModel.self, from: data)
                        // print(model)
                        completion(model,nil)
                        SwiftLoader.hide()
                    }catch{}
                    
                }
            }
        }
    }
    
    
    func transactionTaggingServiceApi(dict:NSDictionary, completion: @escaping (RegisterComplaintModel?, Error?) -> ()) {
        
        // Encrypt the dictionary
        let encryptedData = EncryptionService.shared.finalParam(dict)
        print("encryptedData: \(encryptedData)")
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.transactionTagging)", method: .post, parameters: encryptedData as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                
                // Check if the response was successful
                //                guard let responseDict = response.error as? [String: Any] else {
                //                    debugPrint("Response did not contain a valid dictionary: \(response)")
                //                    completion(nil, NSError(domain: "APIError", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"]))
                //                    return
                //                }
                
                // Check if response data exists and is not empty
                guard let responseData = response.data, responseData.count > 0 else {
                    completion(nil, NSError(domain: "APIError", code: 1002, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                do {
                    let dict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                    //print(dict)
                    // Process base64-encoded string
                    if let base64Encoded = dict?["data"] as? String {
                        // Base64 decoding
                        guard let decodedData = Data(base64Encoded: base64Encoded),
                              let decodedString = String(data: decodedData, encoding: .utf8) else {
                            completion(nil, NSError(domain: "APIError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Base64 decoding failed"]))
                            return
                        }
                        
                        // Convert the decoded string to a dictionary
                        if let decodedDict = EncryptionService.shared.convertToDictionary(text: decodedString) {
                            do {
                                // Decrypt the data
                                let decryptedData = try EncryptionService.shared.decrypt(encrypted: decodedDict["encrypted"] as! String, iv: decodedDict["iv"] as! String, authTag: decodedDict["authTag"] as! String, jwtToken: Common.shared.token ?? "")
                                
                                if let stringData = decryptedData {
                                    if let jsonData = stringData.data(using: .utf8) {
                                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                        if let dictionary = jsonObject as? [String: Any] {
                                            // Now we have a dictionary, proceed with serialization
                                            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                                            // Decode the data into a model
                                            let model = try JSONDecoder().decode(RegisterComplaintModel.self, from: data)
                                            completion(model, nil)
                                        }
                                    }
                                }
                                
                            } catch {
                                // Handle decryption or decoding errors
                                print("Decryption or JSON decoding failed: \(error.localizedDescription)")
                                completion(nil, error)
                            }
                        } else {
                            print("Failed to convert decoded string to dictionary.")
                            completion(nil, NSError(domain: "APIError", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Invalid decoded string"]))
                        }
                    } else {
                        print("Base64 string not found in response.")
                        completion(nil, NSError(domain: "APIError", code: 1005, userInfo: [NSLocalizedDescriptionKey: "Base64 encoded data missing in response"]))
                    }
                    SwiftLoader.hide()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    func addUpiUserServiceApi(dict:NSDictionary, completion: @escaping (AddUpiUserModel?, Error?) -> ()) {
        
        // Encrypt the dictionary
        let encryptedData = EncryptionService.shared.finalParam(dict)
        print("encryptedData: \(encryptedData)")
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.addUpiUser)", method: .post, parameters: encryptedData as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseData {  response in
            if response.result.isSuccess{
                // Check if the response was successful
                //                guard let responseDict = response.error as? [String: Any] else {
                //                    debugPrint("Response did not contain a valid dictionary: \(response)")
                //                    completion(nil, NSError(domain: "APIError", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"]))
                //                    return
                //                }
                
                // Check if response data exists and is not empty
                guard let responseData = response.data, responseData.count > 0 else {
                    completion(nil, NSError(domain: "APIError", code: 1002, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                do {
                    let dict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                    //print(dict)
                    // Process base64-encoded string
                    if let base64Encoded = dict?["data"] as? String {
                        // Base64 decoding
                        guard let decodedData = Data(base64Encoded: base64Encoded),
                              let decodedString = String(data: decodedData, encoding: .utf8) else {
                            completion(nil, NSError(domain: "APIError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Base64 decoding failed"]))
                            return
                        }
                        
                        // Convert the decoded string to a dictionary
                        if let decodedDict = EncryptionService.shared.convertToDictionary(text: decodedString) {
                            do {
                                // Decrypt the data
                                let decryptedData = try EncryptionService.shared.decrypt(encrypted: decodedDict["encrypted"] as! String, iv: decodedDict["iv"] as! String, authTag: decodedDict["authTag"] as! String, jwtToken: Common.shared.token ?? "")
                                
                                if let stringData = decryptedData {
                                    if let jsonData = stringData.data(using: .utf8) {
                                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                        if let dictionary = jsonObject as? [String: Any] {
                                            // Now we have a dictionary, proceed with serialization
                                            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                                            // Decode the data into a model
                                            let model = try JSONDecoder().decode(AddUpiUserModel.self, from: data)
                                            completion(model, nil)
                                        }
                                    }
                                }
                                
                            } catch {
                                // Handle decryption or decoding errors
                                print("Decryption or JSON decoding failed: \(error.localizedDescription)")
                                completion(nil, error)
                            }
                        } else {
                            print("Failed to convert decoded string to dictionary.")
                            completion(nil, NSError(domain: "APIError", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Invalid decoded string"]))
                        }
                    } else {
                        print("Base64 string not found in response.")
                        completion(nil, NSError(domain: "APIError", code: 1005, userInfo: [NSLocalizedDescriptionKey: "Base64 encoded data missing in response"]))
                    }
                    SwiftLoader.hide()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func validateUpiOtpServiceApi(dict:NSDictionary,completion: @escaping (ValidateUpiOTPModel?, Error?) -> ()) {
        let encryptedData = EncryptionService.shared.finalParam(dict)
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.validateUpiOtp)", method: .post, parameters: encryptedData as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.appVersionHeaders).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //  print(data)
                    do{
                        let model = try JSONDecoder().decode(ValidateUpiOTPModel.self, from: data)
                        //  print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    
    func SubscriptionApiServiceApi(completion: @escaping (SubscriptionResponse?, Error?) -> ()) {
        let url = "\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.subscription)"
        let bodyParameters: [String: Any] = [
            "skey": "AVJQIdwn79iR0zlP0iKNKumME"
        ]
        
        // Send POST request with JSON body
        Alamofire.request(url, method: .post, parameters: bodyParameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headersWithoutSkey).responseJSON { response in
           

            if response.result.isSuccess {
                guard let data = response.data, data.count > 0 else {
                
                    completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"]))
                    return
                }
                do {
                    // Decode the response into a SubscriptionResponse object
                    let model = try JSONDecoder().decode(SubscriptionResponse.self, from: data)
                
                    completion(model, nil)
                } catch {
                  
                    completion(nil, error)
                }
            } else {
                // Log any errors
                 completion(nil, response.error)
            }
        }
    }
   
    


    func SubscriptionAddRequest(jsonString: String, completion: @escaping (SubscriptionResponseAdd?, Error?) -> ()) {
        let url = "\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.subscriptionService)"
        
        // Convert JSON string to Data
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Error: Invalid JSON String")
            completion(nil, NSError(domain: "Invalid JSON", code: 400, userInfo: nil))
            return
        }
        
        // Create a proper URLRequest
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = ConstantApi.headersWithoutSkey
        request.httpBody = jsonData
        
        // Send the request
        Alamofire.request(request).responseJSON { response in
            print("Request Body: \(jsonString)")
            
            switch response.result {
            case .success:
                guard let data = response.data, !data.isEmpty else {
                    print("Error: Empty response")
                    completion(nil, NSError(domain: "Empty Response", code: 204, userInfo: nil))
                    return
                }
                
                do {
                    let model = try JSONDecoder().decode(SubscriptionResponseAdd.self, from: data)
                    print("API Response:", model)
                    completion(model, nil)
                } catch let decodingError {
                    print("JSON Decoding Error:", decodingError)
                    completion(nil, decodingError)
                }
                
            case .failure(let error):
                print("API Request Failed:", error)
                completion(nil, error)
            }
        }
    }

    
//    func SubscriptionAddRequest(dict:NSDictionary,completion: @escaping (SubscriptionResponseAdd?, Error?) -> ()) {
//        let url = "\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.subscriptionService)"
//       
//        
//        // Send POST request with JSON body
//        Alamofire.request(url, method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headersWithoutSkey).responseJSON { response in
//            
//            print("vheck7",dict as? Parameters)
//            print("vheck7")
//            if response.result.isSuccess{
//                guard let dictResponse = response.data, dictResponse.count > 0 else {
//                    return
//                }
//                if let data = response.data, data.count > 0{
//                    //  print(data)
//                    do{
//                        let model = try JSONDecoder().decode(SubscriptionResponseAdd.self, from: data)
//                          print(model)
//                        completion(model,nil)
//                        print("vheck8")
//                    }catch{}
//                    
//                }
//            }
//        }
//    }

}


