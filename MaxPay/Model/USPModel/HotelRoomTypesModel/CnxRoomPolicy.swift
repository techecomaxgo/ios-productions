

import Foundation

struct CnxRoomPolicy : Codable {
	let curr : String?
	let panelty : String?
	let prefix : String?
	let endDate : String?
	let freeText : String?
	let penaltyType : String?
	let startDate : String?
	let type : String?

	enum CodingKeys: String, CodingKey {
		case curr = "Curr"
		case panelty = "Panelty"
		case prefix = "Prefix"
		case endDate = "endDate"
		case freeText = "freeText"
		case penaltyType = "penaltyType"
		case startDate = "startDate"
		case type = "type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		curr = try values.decodeIfPresent(String.self, forKey: .curr)
		panelty = try values.decodeIfPresent(String.self, forKey: .panelty)
		prefix = try values.decodeIfPresent(String.self, forKey: .prefix)
		endDate = try values.decodeIfPresent(String.self, forKey: .endDate)
		freeText = try values.decodeIfPresent(String.self, forKey: .freeText)
		penaltyType = try values.decodeIfPresent(String.self, forKey: .penaltyType)
		startDate = try values.decodeIfPresent(String.self, forKey: .startDate)
		type = try values.decodeIfPresent(String.self, forKey: .type)
	}

}
