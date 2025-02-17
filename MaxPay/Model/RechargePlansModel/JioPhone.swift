//
//  JioPhone.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on May 18, 2024
//
import Foundation

struct JioPhone: Codable {

	let rs: Int?
	let validity: String?
	let desc: String?
	let TypeField: String?

	private enum CodingKeys: String, CodingKey {
		case rs = "rs"
		case validity = "validity"
		case desc = "desc"
		case TypeField = "Type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		rs = try values.decode(Int.self, forKey: .rs)
		validity = try values.decode(String.self, forKey: .validity)
		desc = try values.decode(String.self, forKey: .desc)
		TypeField = try values.decode(String.self, forKey: .TypeField)
	}

}
