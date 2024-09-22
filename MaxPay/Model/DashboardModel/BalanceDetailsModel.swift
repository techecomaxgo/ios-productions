//
//  BalanceDetailsModel.swift
//  MaxPay
//
//  Created by india on 10/11/23.
//

import Foundation
struct BalanceDetailsModel : Codable {
    let status : String?
    let messageBalance : MessageBalance?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case messageBalance = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        messageBalance = try values.decodeIfPresent(MessageBalance.self, forKey: .messageBalance)
    }

}
struct MessageBalance : Codable {
    let card_number : String?
    let primary_wallet_balance : String?
    let card_expiry : String?

    enum CodingKeys: String, CodingKey {

        case card_number = "card_number"
        case primary_wallet_balance = "primary_wallet_balance"
        case card_expiry = "card_expiry"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        card_number = try values.decodeIfPresent(String.self, forKey: .card_number)
        primary_wallet_balance = try values.decodeIfPresent(String.self, forKey: .primary_wallet_balance)
        card_expiry = try values.decodeIfPresent(String.self, forKey: .card_expiry)
    }

}
