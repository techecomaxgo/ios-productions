//
//  ApiManager.swift
//
//
//       https://uat.maxupi.in/

import UIKit
import Alamofire
import SwiftyJSON
import SwiftLoader

struct ConstantApi{
    
    struct BaseURL {
//        static let baseUrl = "http://13.126.228.61/api/v1/"
        
       // static let baseUrl = "https://api.maxupi.in/api/v1/"
        
        static let baseUrl = "https://uat.maxupi.in/api/v1/"
        
        static let weatherBaseUrl = "http://api.maxupi.in/v1/"
    }
    
    
    struct SubURL {
        static let registraction = "user/mobile-registration"
        static let otpVerify = "user/otp-verify"
        static let regenarateOTP = "user/re-generate-otp"
        static let pinGeneration = "user/pin-generation"
        static let login = "user/login"
        static let  getBalanceDetails = "wallet/get-card-details"
        static let  getSecondaryWalletBalance = "wallet/swallet/get-wallet-details"
        static let  payBillList = "biller/master-data"
        static let   catagoryList = "biller/billers-by-category"
        static let   fetechBill = "biller/billers-by-id"
        static let   fetechBiillValF = "biller/fetch-val-bill"
        static let billPayment = "biller/payment"
        static let city = "travel/bus/get-city-list"
        static let busList = "travel/bus/get-available-trips"
        static let seatDetails = "travel/bus/get-seat-details"
        static let busBooking = "travel/bus/block-seat-for-booking"
        static let busBookingBus = "travel/bus/book-bus"
        static let deductSWalletBalance = "wallet/swallet/deduct-swallet-balance"
        static let checksum = "upi/checksum"
        static let transactionTagging = "upi/transaction-tagging"
        static let notificationList = "notification/list-notification"
        static let notificationAddToken = "notification/add-notification-token"
        static let transactionList = "biller/transaction-history"
        static let registerComplaint = "biller-complaint/register-complaint"
        static let weatherApi = "current.json?key=4dd79c02aff94ebab1a190013232512&q="
        static let bharatQrApi = "upi/bqr-verify"
        static let rechargePlansApi = "recharge/recharge-plans"
        static let limitCheckApi = "upi/limitcheck"
        static let operatorApi = "recharge/operator-list"
        static let circleApi = "recharge/circle-list"
        
        static let deductWalletApi = "wallet/swallet/deduct-swallet-balance"
        static let rechargeModelApi = "recharge/recharge"
        static let rankAllApi = "rank/all-ranker"
        
        static let chainReferApi = "refer/total-refer"
        
        static let getQuizApi = "quiz-user/get-quiz"
        
        static let attendQuizApi = "quiz-user/attend-quiz"
        
        static let milesModellApi = "miles/total-amount-miles"
        static let allmilesTransApi = "miles/all-miles-transaction"
        
        static let hotelModelSearchApi = "travel/hotel/hotel-search"
        
        static let hotelDetailsApi = "travel/hotel/get-hotel-details"
        static let hotelRoomTypesApi = "travel/hotel/get-available-rooms-by-hotel-details"

        static let hotelBookApi = "travel/hotel/book-hotel"
        
        static let getwalletdetailsApi = "get-wallet-details"
        static let primWalletModellApi = "wallet/get-wallet-balance"
        
        static let origionCityApi = "travel/flight/get-airport-list"
        
        static let searchFlightOneApi = "travel/flight/search-flight"
        static let searchFlightRoundApi = "travel/flight/search-flight"



        
    }
    static  let headers: HTTPHeaders = [
        "authorization": "Bearer \(Common.shared.token ?? "")"
    ]
    
    static  let headers1: HTTPHeaders = [
        "authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiIxIiwicGhvbmUiOiI4ODk2OTU4NDY2IiwidWlkIjoiNDBjZWVmMWEtMzRmZi00YjlmLTk1NDItZjU0OGVlNTM1MzFhIiwiaWF0IjoxNzAyOTgyMzIxfQ.sNFqm1Kw79YABLjXi67jkQ_qbCgldMYak94m17jr16U"
    ]
}
//MARK: API Manager class api calling
class ApiManager: NSObject {
    
    static let sharedInstance = ApiManager()
    
    func registractionServiceApi(dict:NSDictionary,completion: @escaping (RegistractionModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.registraction)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
           // var statusCode = response.response?.statusCode
            
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
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.otpVerify)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                  //  print(data)
                    do{
                        let model = try JSONDecoder().decode(OtpVerifyModel.self, from: data)
                      //  print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    func otpRegenarateOTPServiceApi(dict:NSDictionary,completion: @escaping (OtpVerifyModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.regenarateOTP)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
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
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.pinGeneration)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
            var statusCode = response.response?.statusCode
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
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.login)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
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
            }
        }
    }
    
    
    func QrBharatServiceApi(dict:NSDictionary,completion: @escaping (QRBharatModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.bharatQrApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                  //  print(data)
                    do{
                        let model = try JSONDecoder().decode(QRBharatModel.self, from: data)
                       // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    
    func getRechargePlansServiceApi(dict:NSDictionary,completion: @escaping (RechargeAllPlans_Model?, Error?) -> ()) {
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.rechargePlansApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
           
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    print(data)
                    do{
                        let model = try JSONDecoder().decode(RechargeAllPlans_Model.self, from: data)
                       // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    
    func LimitCheckApiServiceApi(dict:NSDictionary,completion: @escaping (LimitCheck_Base?, Error?) -> ()) {
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.limitCheckApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                  //  print(data)
                    do{
                        let model = try JSONDecoder().decode(LimitCheck_Base.self, from: data)
                       // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
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
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.deductWalletApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
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
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.rechargeModelApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                  //  print(data)
                    do{
                        let model = try JSONDecoder().decode(RechargeModel_Base.self, from: data)
                       // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
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
                            print("The value is : \(String(describing: response.result.value))")
                            
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
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.chainReferApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                  //  print(data)
                    do{
                        let model = try JSONDecoder().decode(ChainModel_Base.self, from: data)
                       // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
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
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.origionCityApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
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
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.getQuizApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                  //  print(data)
                    do{
                        let model = try JSONDecoder().decode(GetQuizModel_Base.self, from: data)
                       // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    
    func AttendQuizModelApi(dict:NSDictionary,completion: @escaping (AttendQuizModel_Base?, Error?) -> ()) {
        
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.attendQuizApi)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                  //  print(data)
                    do{
                        let model = try JSONDecoder().decode(AttendQuizModel_Base.self, from: data)
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
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.getBalanceDetails)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                  //  print(data)
                    print(ConstantApi.headers)
                    do{
                        let model = try JSONDecoder().decode(BalanceDetailsModel.self, from: data)
                       // print(model)
                        completion(model,nil)
                        
                    }catch{
                        
                        
                    }
                    
                }
            }
        }
    }
    func dashboardSecondaryBalanceServiceApi(dict:NSDictionary,completion: @escaping (SecondaryWalletBalance?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.getSecondaryWalletBalance)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
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
    func catagoryListServiceApi(dict:NSDictionary,completion: @escaping (CatagoryListModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.catagoryList)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                   // print(data)
                   // print(ConstantApi.headers)
                    do{
                        let model = try JSONDecoder().decode(CatagoryListModel.self, from: data)
                       // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    func fetechBillServiceApi(dict:NSDictionary,completion: @escaping (FetechBillModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.fetechBill)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //print(data)
                    //print(ConstantApi.headers)
                    do{
                        //print("The value is : \(response.result.value ?? "")")
                        let model = try JSONDecoder().decode(FetechBillModel.self, from: data)
                        //print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
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
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.city)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                   // print(data)
                   // print(ConstantApi.headers)
                    do{
                       // print("The value is : \(String(describing: response.result.value))")
                        let model = try JSONDecoder().decode(CityModel.self, from: data)
                        //print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
    func BusListServiceApi(dict:NSDictionary,completion: @escaping (BusListModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.busList)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
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
        Alamofire.request("\(ConstantApi.BaseURL.weatherBaseUrl)\(ConstantApi.SubURL.weatherApi + city)", method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    //print(data)
                    do{
                        switch response.result{
                        case .success(let value):
                            print("The value is : \(String(describing: response.result.value))")
                            
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
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.seatDetails)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                    do{
                        print("The value is : \(String(describing: response.result.value))")
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
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.busBooking)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
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
    
    func checksumServiceApi(dict:NSDictionary,completion: @escaping (ChecksumModel?, Error?) -> ()) {
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.checksum)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                  //  print(data)
                   // print(ConstantApi.headers)
                    do{
                       // print("The value is : \(response.result.value)")
                        let model = try JSONDecoder().decode(ChecksumModel.self, from: data)
                       // print(model)
                        completion(model,nil)
                        
                    }catch{}
                    
                }
            }
        }
    }
    
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
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.notificationAddToken)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
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
        Alamofire.request("\(ConstantApi.BaseURL.baseUrl)\(ConstantApi.SubURL.transactionTagging)", method: .post, parameters: dict as? Parameters, encoding: JSONEncoding.prettyPrinted, headers: ConstantApi.headers).responseJSON {  response in
            if response.result.isSuccess{
                guard let dictResponse = response.data, dictResponse.count > 0 else {
                    return
                }
                if let data = response.data, data.count > 0{
                   // print(data)
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
    
    
    
}




