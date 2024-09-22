

import Foundation

struct Origin_Base : Codable {
	let status : String?
	let message : String?
	let data : OrigionData?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		data = try values.decodeIfPresent(OrigionData.self, forKey: .data)
	}

}
