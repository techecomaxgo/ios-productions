

import Foundation

struct HotelBook_Model : Codable {
	let status : String?
	let message : String?
	let data : HotelBook_ModelData?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		data = try values.decodeIfPresent(HotelBook_ModelData.self, forKey: .data)
	}

}
