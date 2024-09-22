

import Foundation

struct Operator_Base : Codable {
	let status : String?
	let responseData : [Operator_Data]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case responseData = "responseData"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		responseData = try values.decodeIfPresent([Operator_Data].self, forKey: .responseData)
	}

}
