

import Foundation

struct GetWalletDetailsApi_Base : Codable {
    
	let message : String?
	let status : String?
	let data : Data?

	enum CodingKeys: String, CodingKey {

		case message = "message"
		case status = "status"
		case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		data = try values.decodeIfPresent(Data.self, forKey: .data)
	}
    

}
