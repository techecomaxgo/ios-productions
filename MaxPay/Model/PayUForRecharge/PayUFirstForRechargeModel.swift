//
//  File.swift
//  MaxPay
//
//  Created by Admin on 19/02/25.
//

import Foundation


struct PayUFirstForRecharge : Codable {
    let metaData : PayURechargeMetadata?
    let result : PayURechargeResult?

//    enum CodingKeys: String, CodingKey {
//        case metaData = "metaData"
//        case result = "result"
//    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        metaData = try values.decodeIfPresent(String.self, forKey: .metaData)
//        result = try values.decodeIfPresent(String.self, forKey: .result)
//    }

}
struct PayURechargeMetadata: Codable{
    let message: String?
    let referenceId: String?
    let statusCode: String?
    let txnId: String?
    let txnStatus: String?
    let unmappedStatus: String?
}
struct PayURechargeResult: Codable{
    let paymentId: String?
    let merchantName: String?
    let merchantVpa: String?
    let amount: String?
    let intentURIData: String?
    let acsTemplate: String?
    let otpPostUrl: String?
}
