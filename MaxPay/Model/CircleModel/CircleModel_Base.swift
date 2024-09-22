

import Foundation

struct CircleModel_Base : Codable {
    
	let status : String?
	let circle_names : [String]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case circle_names = "circle_names"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		circle_names = try values.decodeIfPresent([String].self, forKey: .circle_names)
	}

}
