//
//  LoginModel.swift
//  MaxPay
//
//  Created by india on 10/11/23.
//

import Foundation
struct LoginModel : Codable {
    let status : String?
    let message : String?
    let dataLogin : DataLogin?
    let token : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case dataLogin = "data"
        case token = "token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        dataLogin = try values.decodeIfPresent(DataLogin.self, forKey: .dataLogin)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }

}
struct DataLogin : Codable {
    let f_name : String?
    let l_name : String?
    let image : String?
    let rank : Int?

    enum CodingKeys: String, CodingKey {

        case f_name = "f_name"
        case l_name = "l_name"
        case image = "image"
        case rank = "rank"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        f_name = try values.decodeIfPresent(String.self, forKey: .f_name)
        l_name = try values.decodeIfPresent(String.self, forKey: .l_name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        rank = try values.decodeIfPresent(Int.self, forKey: .rank)
    }

}
