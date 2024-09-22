//
//  SeatModel.swift
//  MaxPay
//
//  Created by india on 09/12/23.
//

import Foundation
struct SeatModel : Codable {
    let status : String?
    let message : String?
   // let data : Data_Seat?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
      //  case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
      //  data = try values.decodeIfPresent(Data_Seat.self, forKey: .data)
    }

}
