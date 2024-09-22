

import Foundation
struct Json4Swift_Base : Codable {
	let status : String?
	let data : Data?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		data = try values.decodeIfPresent(Data.self, forKey: .data)
	}

}
