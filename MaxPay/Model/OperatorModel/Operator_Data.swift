

import Foundation

struct Operator_Data : Codable {
	let operator_name : String?
	let service_type : String?

	enum CodingKeys: String, CodingKey {

		case operator_name = "operator_name"
		case service_type = "service_type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		operator_name = try values.decodeIfPresent(String.self, forKey: .operator_name)
		service_type = try values.decodeIfPresent(String.self, forKey: .service_type)
	}

}
