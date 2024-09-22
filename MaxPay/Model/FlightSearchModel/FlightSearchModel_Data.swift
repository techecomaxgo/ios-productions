

import Foundation

struct FlightSearchModel_Data : Codable {
	let errors : String?
	let insurance : String?
	let journeys : [Journeys]?
	let resTime : Double?
	let traceId : String?

	enum CodingKeys: String, CodingKey {

		case errors = "Errors"
		case insurance = "Insurance"
		case journeys = "Journeys"
		case resTime = "ResTime"
		case traceId = "TraceId"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		errors = try values.decodeIfPresent(String.self, forKey: .errors)
		insurance = try values.decodeIfPresent(String.self, forKey: .insurance)
		journeys = try values.decodeIfPresent([Journeys].self, forKey: .journeys)
		resTime = try values.decodeIfPresent(Double.self, forKey: .resTime)
		traceId = try values.decodeIfPresent(String.self, forKey: .traceId)
	}

}
