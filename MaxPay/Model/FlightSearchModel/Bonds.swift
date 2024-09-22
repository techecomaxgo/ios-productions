

import Foundation

struct Bonds : Codable {
	let boundType : String?
	let isBaggageFare : Bool?
	let isSSR : Bool?
	let itineraryKey : String?
	let journeyTime : String?
	var legs : [Legs]?
	let addOnDetail : String?

	enum CodingKeys: String, CodingKey {

		case boundType = "BoundType"
		case isBaggageFare = "IsBaggageFare"
		case isSSR = "IsSSR"
		case itineraryKey = "ItineraryKey"
		case journeyTime = "JourneyTime"
		case legs = "Legs"
		case addOnDetail = "addOnDetail"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		boundType = try values.decodeIfPresent(String.self, forKey: .boundType)
		isBaggageFare = try values.decodeIfPresent(Bool.self, forKey: .isBaggageFare)
		isSSR = try values.decodeIfPresent(Bool.self, forKey: .isSSR)
		itineraryKey = try values.decodeIfPresent(String.self, forKey: .itineraryKey)
		journeyTime = try values.decodeIfPresent(String.self, forKey: .journeyTime)
		legs = try values.decodeIfPresent([Legs].self, forKey: .legs)
		addOnDetail = try values.decodeIfPresent(String.self, forKey: .addOnDetail)
	}

}
