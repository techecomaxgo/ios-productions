/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Buslist : Codable {
	let bdPoints : [BdPoints]?
	let totalSeats : Int?
	let availableTrips : [AvailableTrips]?
	let specialTrips : [SpecialTrips]?
	let droppingPoints : [DroppingPoints]?
	let minDeptTime : String?
	let maxDeptTime : String?
	let maxPrice : String?
	let journeyDate : String?
	let minPrice : String?
	let totalTrips : Int?
	let source : String?
	let sourceId : Int?
	let destination : String?
	let destinationId : Int?
	let busOperator : String?
	let sessionId : String?
	let creationDate : String?
	let sortDate : String?
	let sortMaxDepTime : Int?
	let sortMinDepTime : Int?
	let isBusAvailable : Bool?
	let traceId : String?
	let isCache : Bool?
	let responseTime : String?
	let dataParsingTime : String?
	let sTTrips : String?
	let sT : [ST]?

	enum CodingKeys: String, CodingKey {

		case bdPoints = "bdPoints"
		case totalSeats = "TotalSeats"
		case availableTrips = "AvailableTrips"
		case specialTrips = "SpecialTrips"
		case droppingPoints = "droppingPoints"
		case minDeptTime = "MinDeptTime"
		case maxDeptTime = "MaxDeptTime"
		case maxPrice = "MaxPrice"
		case journeyDate = "JourneyDate"
		case minPrice = "MinPrice"
		case totalTrips = "TotalTrips"
		case source = "Source"
		case sourceId = "sourceId"
		case destination = "Destination"
		case destinationId = "destinationId"
		case busOperator = "busOperator"
		case sessionId = "sessionId"
		case creationDate = "creationDate"
		case sortDate = "sortDate"
		case sortMaxDepTime = "sortMaxDepTime"
		case sortMinDepTime = "sortMinDepTime"
		case isBusAvailable = "isBusAvailable"
		case traceId = "TraceId"
		case isCache = "IsCache"
		case responseTime = "ResponseTime"
		case dataParsingTime = "DataParsingTime"
		case sTTrips = "STTrips"
		case sT = "ST"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		bdPoints = try values.decodeIfPresent([BdPoints].self, forKey: .bdPoints)
		totalSeats = try values.decodeIfPresent(Int.self, forKey: .totalSeats)
		availableTrips = try values.decodeIfPresent([AvailableTrips].self, forKey: .availableTrips)
		specialTrips = try values.decodeIfPresent([SpecialTrips].self, forKey: .specialTrips)
		droppingPoints = try values.decodeIfPresent([DroppingPoints].self, forKey: .droppingPoints)
		minDeptTime = try values.decodeIfPresent(String.self, forKey: .minDeptTime)
		maxDeptTime = try values.decodeIfPresent(String.self, forKey: .maxDeptTime)
		maxPrice = try values.decodeIfPresent(String.self, forKey: .maxPrice)
		journeyDate = try values.decodeIfPresent(String.self, forKey: .journeyDate)
		minPrice = try values.decodeIfPresent(String.self, forKey: .minPrice)
		totalTrips = try values.decodeIfPresent(Int.self, forKey: .totalTrips)
		source = try values.decodeIfPresent(String.self, forKey: .source)
		sourceId = try values.decodeIfPresent(Int.self, forKey: .sourceId)
		destination = try values.decodeIfPresent(String.self, forKey: .destination)
		destinationId = try values.decodeIfPresent(Int.self, forKey: .destinationId)
		busOperator = try values.decodeIfPresent(String.self, forKey: .busOperator)
		sessionId = try values.decodeIfPresent(String.self, forKey: .sessionId)
		creationDate = try values.decodeIfPresent(String.self, forKey: .creationDate)
		sortDate = try values.decodeIfPresent(String.self, forKey: .sortDate)
		sortMaxDepTime = try values.decodeIfPresent(Int.self, forKey: .sortMaxDepTime)
		sortMinDepTime = try values.decodeIfPresent(Int.self, forKey: .sortMinDepTime)
		isBusAvailable = try values.decodeIfPresent(Bool.self, forKey: .isBusAvailable)
		traceId = try values.decodeIfPresent(String.self, forKey: .traceId)
		isCache = try values.decodeIfPresent(Bool.self, forKey: .isCache)
		responseTime = try values.decodeIfPresent(String.self, forKey: .responseTime)
		dataParsingTime = try values.decodeIfPresent(String.self, forKey: .dataParsingTime)
		sTTrips = try values.decodeIfPresent(String.self, forKey: .sTTrips)
		sT = try values.decodeIfPresent([ST].self, forKey: .sT)
	}

}