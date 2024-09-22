

import Foundation

struct HotelSearchModel_Base : Codable {
    
	let status : String?
	let message : String?
	let hotels : Hotels?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case hotels = "hotels"
	}

	init(from decoder: Decoder) throws {
        
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		hotels = try values.decodeIfPresent(Hotels.self, forKey: .hotels)
        
	}

}
