

import Foundation

struct LimitDataCk : Codable {
	let bindAttemptLimit : Int?

	enum CodingKeys: String, CodingKey {

		case bindAttemptLimit = "limit"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		bindAttemptLimit = try values.decodeIfPresent(Int.self, forKey: .bindAttemptLimit)
	}

}
