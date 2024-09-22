

import Foundation

struct HotelAmenitiesList : Codable {
    
	let amenity : String?
	let amenityId : String?
	let category : String?
	let value : String?

	enum CodingKeys: String, CodingKey {

		case amenity = "Amenity"
		case amenityId = "AmenityId"
		case category = "Category"
		case value = "Value"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		amenity = try values.decodeIfPresent(String.self, forKey: .amenity)
		amenityId = try values.decodeIfPresent(String.self, forKey: .amenityId)
		category = try values.decodeIfPresent(String.self, forKey: .category)
		value = try values.decodeIfPresent(String.self, forKey: .value)
	}

}
