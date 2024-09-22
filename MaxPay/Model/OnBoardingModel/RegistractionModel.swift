//
//  RegistractionModel.swift
//  MaxPay
//
//  Created by india on 08/11/23.
//

import Foundation
struct RegistractionModel : Codable {
    let status : String?
    let message : String?
    let data : DataRegistraction?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(DataRegistraction.self, forKey: .data)
    }

}

struct OtpVerifyModel : Codable {
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
