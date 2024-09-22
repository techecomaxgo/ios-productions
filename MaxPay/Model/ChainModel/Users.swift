

import Foundation

struct Users : Codable {
	let full_name : String?
	let spent : Int?
	let earned : Int?

	enum CodingKeys: String, CodingKey {

		case full_name = "full_name"
		case spent = "spent"
		case earned = "earned"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		full_name = try values.decodeIfPresent(String.self, forKey: .full_name)
		spent = try values.decodeIfPresent(Int.self, forKey: .spent)
		earned = try values.decodeIfPresent(Int.self, forKey: .earned)
	}

}
