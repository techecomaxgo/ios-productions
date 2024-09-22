//
//  ChecksumModel.swift
//  MaxPay
//
//  Created by india on 15/12/23.
//

import Foundation
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
