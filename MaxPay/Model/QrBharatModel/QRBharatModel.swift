//
//  QRBharatModel.swift
//  MaxPay
//
//  Created by Ios Developer on 11/05/24.
//

import Foundation


struct QRBharatModel : Codable {
    let status : String?
    let message : String?
    let data : QrData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(QrData.self, forKey: .data)
    }

}

struct QrData : Codable {
    let qrresponse : String?

    enum CodingKeys: String, CodingKey {

        case qrresponse = "qrresponse"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        qrresponse = try values.decodeIfPresent(String.self, forKey: .qrresponse)
    }

}
