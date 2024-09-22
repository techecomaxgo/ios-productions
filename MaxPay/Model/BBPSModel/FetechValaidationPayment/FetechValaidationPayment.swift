//
//  FetechValaidationPayment.swift
//  MaxPay
//
//  Created by india on 23/11/23.
//

import Foundation

struct FetechValaidationPayment: Codable {
    let status : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        
    }

}
