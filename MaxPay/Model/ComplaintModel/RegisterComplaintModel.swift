//
//  RegisterComplaintModel.swift
//  MaxPay
//
//  Created by Ios Developer on 25/01/24.
//

import Foundation

struct RegisterComplaintModel: Codable {
    let status: String?
    let message: String?
    let responseData: ResponseData?
    
    enum CodingKeys: CodingKey {
        case status
        case message
        case responseData
    }
}
