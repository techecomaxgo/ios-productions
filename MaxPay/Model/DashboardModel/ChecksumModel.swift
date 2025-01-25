//
//  ChecksumModel.swift
//  MaxPay
//
//  Created by india on 15/12/23.
//

import Foundation

import Foundation


struct ChecksumModel: Codable {

  var status  : String? = nil
  var message : String? = nil
  var data    : ChecksumData?
  var token   : String? = nil

  enum CodingKeys: String, CodingKey {

    case status  = "status"
    case message = "message"
    case data    = "data"
    case token   = "token"
  
  }

  init(from decoder: Decoder) throws {
      
    let values = try decoder.container(keyedBy: CodingKeys.self)
    status  = try values.decodeIfPresent(String.self , forKey: .status)
    message = try values.decodeIfPresent(String.self , forKey: .message)
    data    = try values.decodeIfPresent(ChecksumData.self, forKey: .data)
    token   = try values.decodeIfPresent(String.self , forKey: .token)
 
  }
 
}
struct ChecksumData: Codable {

  var code     : String? = nil
  var result   : String? = nil
  var data     : ChecksumSubData?
  var checkSum : String? = nil

  enum CodingKeys: String, CodingKey {

    case code     = "code"
    case result   = "result"
    case data     = "data"
    case checkSum = "checkSum"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    code     = try values.decodeIfPresent(String.self , forKey: .code     )
    result   = try values.decodeIfPresent(String.self , forKey: .result   )
    data     = try values.decodeIfPresent(ChecksumSubData.self   , forKey: .data     )
    checkSum = try values.decodeIfPresent(String.self , forKey: .checkSum )
 
  }

  init() {

  }

}
struct ChecksumSubData: Codable {

  var merchantauthtoken : String? = nil

  enum CodingKeys: String, CodingKey {

    case merchantauthtoken = "merchantauthtoken"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    merchantauthtoken = try values.decodeIfPresent(String.self , forKey: .merchantauthtoken )
 
  }
    
  init() {

  }

}


/*
struct ChecksumModel : Codable {
    let code : String?
    let result : String?
    let data : ChecksumData?
    let riskScoreValue : String?
    let checkSum : String?
    let error : String?
    let message : String?
    let status : String?
    

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case result = "result"
        case data = "data"
        case riskScoreValue = "riskScoreValue"
        case checkSum = "checkSum"
        case error = "error"
        case message = "message"
        case status = "status"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        data = try values.decodeIfPresent(ChecksumData.self, forKey: .data)
        riskScoreValue = try values.decodeIfPresent(String.self, forKey: .riskScoreValue)
        checkSum = try values.decodeIfPresent(String.self, forKey: .checkSum)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        
    }

}
struct ChecksumData : Codable {
    
    let merchantauthtoken : String?

    enum CodingKeys: String, CodingKey {

        case merchantauthtoken = "merchantauthtoken"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        merchantauthtoken = try values.decodeIfPresent(String.self, forKey: .merchantauthtoken)
    }

}
*/
