//
//  EncryptDataModel.swift
//  MaxPay
//
//  Created by Admin on 17/12/24.
//

import Foundation

struct EncryptDataModel: Codable {

    var data: String?

  enum CodingKeys: String, CodingKey {

    case data = "data"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    data = try values.decodeIfPresent(String.self , forKey: .data )
 
  }
 
}
