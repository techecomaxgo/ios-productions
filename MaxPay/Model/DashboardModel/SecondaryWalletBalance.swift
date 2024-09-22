//
//  SecondaryWalletBalance.swift
//  MaxPay
//
//  Created by india on 10/11/23.
//

import Foundation
struct SecondaryWalletBalance : Codable {
    let message : String?
    let status : String?
    let secondaryBalanceData : SecondaryBalanceData?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        case secondaryBalanceData = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        secondaryBalanceData = try values.decodeIfPresent(SecondaryBalanceData.self, forKey: .secondaryBalanceData)
    }

}
struct SecondaryBalanceData : Codable {
    
   // let id : String?
    let user_id : String?
    let wallet_id:String?
    let wallet_bal :String?
    
//    let user_phone : String?
//    let secondary_wallet_id : String?
//    let secondary_wallet_balance : String?
//    let secondary_wallet_status : Bool?
//    let proxy_number : String?
//    let createdAt : String?
//    let updatedAt : String?

    enum CodingKeys: String, CodingKey {

        //case id = "id"
        case user_id = "user_id"
        case wallet_id = "wallet_id"
        case wallet_bal = "wallet_bal"
        
//        case user_phone = "user_phone"
//        case secondary_wallet_id = "secondary_wallet_id"
//        case secondary_wallet_balance = "secondary_wallet_balance"
//        case secondary_wallet_status = "secondary_wallet_status"
//        case proxy_number = "proxy_number"
//        case createdAt = "createdAt"
//        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       // id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        
        wallet_id = try values.decodeIfPresent(String.self, forKey: .wallet_id)
        wallet_bal = try values.decodeIfPresent(String.self, forKey: .wallet_bal)

        
        
        
//        user_phone = try values.decodeIfPresent(String.self, forKey: .user_phone)
//        secondary_wallet_id = try values.decodeIfPresent(String.self, forKey: .secondary_wallet_id)
//        secondary_wallet_balance = try values.decodeIfPresent(String.self, forKey: .secondary_wallet_balance)
//        secondary_wallet_status = try values.decodeIfPresent(Bool.self, forKey: .secondary_wallet_status)
//        proxy_number = try values.decodeIfPresent(String.self, forKey: .proxy_number)
//        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
//        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }

}
