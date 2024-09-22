//
//  LatestWalletTransactionResponse.swift
//  MaxPay
//
//  Created by Admin on 01/09/24.
//

import Foundation


//struct LatestWalletTransactionResponse: Codable {
//    let status: String
//    let message: String
//}


struct LatestWalletTransactionResponse: Codable {
    let status: String
    let message: String
    let data: [data]

    struct data: Codable {
        let id: String
        let transaction_id: String
        let user_phone: String
        let amount: String // Adjust type based on your data format
        let facility: String
        let t_type: String
        let status: String
        let category: String
        let createdAt: String
        let updatedAt:String
        
    }
}
