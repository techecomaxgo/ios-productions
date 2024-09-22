

import Foundation

struct Myrank : Codable {
	let full_name : String?
	let spent : Int?
	let rank : Int?

	enum CodingKeys: String, CodingKey {

		case full_name = "full_name"
		case spent = "spent"
		case rank = "rank"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		full_name = try values.decodeIfPresent(String.self, forKey: .full_name)
		spent = try values.decodeIfPresent(Int.self, forKey: .spent)
		rank = try values.decodeIfPresent(Int.self, forKey: .rank)
	}

}
