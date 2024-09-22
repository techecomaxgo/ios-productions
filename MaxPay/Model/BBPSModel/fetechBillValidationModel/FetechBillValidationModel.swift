//
//  fetechBillValidationModel.swift
//  MaxPay
//
//  Created by india on 23/11/23.
//

import Foundation
import Foundation
struct FetechBillValidationModel: Codable {
    let status : String?
    let fetch_data : Fetch_data?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case fetch_data = "fetch_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        fetch_data = try values.decodeIfPresent(Fetch_data.self, forKey: .fetch_data)
    }

}
