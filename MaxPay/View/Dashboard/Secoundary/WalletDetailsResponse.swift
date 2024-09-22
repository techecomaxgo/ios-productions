//
//  WalletDetailsResponse.swift
//  MaxPay
//
//  Created by Admin on 01/09/24.
//

//import Foundation
//
//struct WalletDetailsResponse: Codable {
//    let message: String
//    let status: String
//    let data: data
//}
//
//struct data: Codable {
//    let user_phone: String
//    let wallet_id: String
//    let balance: String
//    
//    enum CodingKeys: String, CodingKey {
//        case user_phone = "user_phone"
//        case walletId = "wallet_id"
//        case walletBal = "balance"
//    }
//}


import Foundation


struct WalletDetailsResponse: Codable {
    let message: String
    let status: String
    let data: WalletDatas
}

struct WalletDatas: Codable {
    let userPhone: String
    let walletId: String
    let balance: String

   
    enum CodingKeys: String, CodingKey {
        case userPhone = "user_phone"
        case walletId = "wallet_id"
        case balance
    }
}

