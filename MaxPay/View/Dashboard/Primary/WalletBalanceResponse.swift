//
//  WalletBalanceResponse.swift
//  MaxPay
//
//  Created by Admin on 01/09/24.
//

//import Foundation
//
//struct WalletBalanceResponse: Codable {
//    let message: String
//    let status: String
//    let data: WalletData
//}
//
//struct WalletData: Codable {
//    let phone: String
//    let balance: Bool
//}


//import Foundation
//
//// Define the model for the response
//struct WalletBalanceResponse: Codable {
//    let status: String
//    let message: WalletMessage
//}
//
//struct WalletMessage: Codable {
//    let cardNumber: String
//    let primaryWalletBalance: String
//    let cardExpiry: String
//
//    // Define custom coding keys to map JSON keys to property names
//    enum CodingKeys: String, CodingKey {
//        case cardNumber = "card_number"
//        case primaryWalletBalance = "primary_wallet_balance"
//        case cardExpiry = "card_expiry"
//    }
//}
//


import Foundation

// Define the model for the response
struct CardDetailsResponse: Codable {
    let status: String
    let message: CardDetailsMessage
}

struct CardDetailsMessage: Codable {
    let cardNumber: String
    let primaryWalletBalance: String
    let cardExpiry: String

    // Define custom coding keys to map JSON keys to property names
    enum CodingKeys: String, CodingKey {
        case cardNumber = "card_number"
        case primaryWalletBalance = "primary_wallet_balance"
        case cardExpiry = "card_expiry"
    }
}
