

import Foundation

struct Journeys : Codable {
	let destination : String?
	let journeyDetail : String?
	let origin : String?
	let segments : [Segments]?

	enum CodingKeys: String, CodingKey {

		case destination = "Destination"
		case journeyDetail = "JourneyDetail"
		case origin = "Origin"
		case segments = "Segments"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		destination = try values.decodeIfPresent(String.self, forKey: .destination)
		journeyDetail = try values.decodeIfPresent(String.self, forKey: .journeyDetail)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		segments = try values.decodeIfPresent([Segments].self, forKey: .segments)
	}

}
