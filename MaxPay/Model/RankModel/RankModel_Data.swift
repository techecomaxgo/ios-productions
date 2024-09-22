

import Foundation

struct RankModel_Data : Codable {
	let myrank : Myrank?
	let allrank : [Allrank]?

	enum CodingKeys: String, CodingKey {

		case myrank = "myrank"
		case allrank = "allrank"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		myrank = try values.decodeIfPresent(Myrank.self, forKey: .myrank)
		allrank = try values.decodeIfPresent([Allrank].self, forKey: .allrank)
	}

}
