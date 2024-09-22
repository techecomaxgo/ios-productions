//
//  SeatDetailsModel.swift
//  MaxPay
//
//  Created by Ios Developer on 09/01/24.
//

import Foundation

struct SeatDetailsModel : Codable {
    
    let message: String?

    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
 
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}
