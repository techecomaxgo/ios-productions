//
//  RootClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on May 18, 2024
//
import Foundation

struct RechargeAllPlans_Model: Codable {

	let status: String?
	let data: DataSubPlans

	private enum CodingKeys: String, CodingKey {
		case status = "status"
		case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decode(String.self, forKey: .status)
		data = try values.decode(DataSubPlans.self, forKey: .data)
	}

}
