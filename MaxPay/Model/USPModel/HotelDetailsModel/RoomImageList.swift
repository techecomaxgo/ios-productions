

import Foundation

struct RoomImageList : Codable {
	let engineType : Int?
	let iD : String?
	let imageCategory : String?
	let imageDescription : String?
	let roomType : String?
	let url : String?
	let type : String?

	enum CodingKeys: String, CodingKey {

		case engineType = "EngineType"
		case iD = "ID"
		case imageCategory = "ImageCategory"
		case imageDescription = "ImageDescription"
		case roomType = "RoomType"
		case url = "Url"
		case type = "type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		engineType = try values.decodeIfPresent(Int.self, forKey: .engineType)
		iD = try values.decodeIfPresent(String.self, forKey: .iD)
		imageCategory = try values.decodeIfPresent(String.self, forKey: .imageCategory)
		imageDescription = try values.decodeIfPresent(String.self, forKey: .imageDescription)
		roomType = try values.decodeIfPresent(String.self, forKey: .roomType)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		type = try values.decodeIfPresent(String.self, forKey: .type)
	}

}
