

import Foundation

struct Airports : Codable {
	let id : Int?
	let cityCode : String?
	let cityName : String?
	let countryName : String?
	let synonyms : String?
	let airportName : String?
	let domestic : Int?
	let activeStatus : Int?
	let timeStamp : Int?
	let continent : String?
	let latitude : Double?
	let longitude : Double?
	let otherName : String?
	let countryCounter : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case cityCode = "CityCode"
		case cityName = "CityName"
		case countryName = "CountryName"
		case synonyms = "Synonyms"
		case airportName = "AirportName"
		case domestic = "Domestic"
		case activeStatus = "ActiveStatus"
		case timeStamp = "TimeStamp"
		case continent = "Continent"
		case latitude = "Latitude"
		case longitude = "Longitude"
		case otherName = "OtherName"
		case countryCounter = "CountryCounter"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		cityCode = try values.decodeIfPresent(String.self, forKey: .cityCode)
		cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
		countryName = try values.decodeIfPresent(String.self, forKey: .countryName)
		synonyms = try values.decodeIfPresent(String.self, forKey: .synonyms)
		airportName = try values.decodeIfPresent(String.self, forKey: .airportName)
		domestic = try values.decodeIfPresent(Int.self, forKey: .domestic)
		activeStatus = try values.decodeIfPresent(Int.self, forKey: .activeStatus)
		timeStamp = try values.decodeIfPresent(Int.self, forKey: .timeStamp)
		continent = try values.decodeIfPresent(String.self, forKey: .continent)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
		otherName = try values.decodeIfPresent(String.self, forKey: .otherName)
		countryCounter = try values.decodeIfPresent(Int.self, forKey: .countryCounter)
	}

}
