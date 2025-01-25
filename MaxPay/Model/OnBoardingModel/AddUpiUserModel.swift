//
//  AddUpiUserModel.swift
//  MaxPay
//
//  Created by Admin on 23/10/24.
//

import Foundation
struct AddUpiUserModel : Codable {
    let status : String?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}

struct ValidateUpiOTPModel : Codable {
    let status : String?
    let message : String?
    let data : DataValidateUpiOTP?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(DataValidateUpiOTP.self, forKey: .data)
    }

}

struct DataValidateUpiOTP : Codable {
    let otp : Int?
    let otpr : String?

    enum CodingKeys: String, CodingKey {

        case otp = "otp"
        case otpr = "otpr"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        otp = try values.decodeIfPresent(Int.self, forKey: .otp)
        otpr = try values.decodeIfPresent(String.self, forKey: .otpr)
    }

}
