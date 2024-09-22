


import Foundation

struct DATA : Codable {
    
	let rs : Int?
	let validity : String?
	let desc : String?
	let type : String?

	enum CodingKeys: String, CodingKey {

		case rs = "rs"
		case validity = "validity"
		case desc = "desc"
		case type = "Type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		rs = try values.decodeIfPresent(Int.self, forKey: .rs)
		validity = try values.decodeIfPresent(String.self, forKey: .validity)
		desc = try values.decodeIfPresent(String.self, forKey: .desc)
		type = try values.decodeIfPresent(String.self, forKey: .type)
	}

}
