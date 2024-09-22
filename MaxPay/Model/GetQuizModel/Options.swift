

import Foundation

struct Options : Codable {
	let a : String?
	let b : String?
	let c : String?
	let d : String?

	enum CodingKeys: String, CodingKey {

		case a = "A"
		case b = "B"
		case c = "C"
		case d = "D"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		a = try values.decodeIfPresent(String.self, forKey: .a)
		b = try values.decodeIfPresent(String.self, forKey: .b)
		c = try values.decodeIfPresent(String.self, forKey: .c)
		d = try values.decodeIfPresent(String.self, forKey: .d)
	}

}
