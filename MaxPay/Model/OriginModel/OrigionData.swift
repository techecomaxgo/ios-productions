

import Foundation

struct OrigionData : Codable {
    
	let airports : [Airports]?

	enum CodingKeys: String, CodingKey {

		case airports = "airports"
	}

	init(from decoder: Decoder) throws {
        
		let values = try decoder.container(keyedBy: CodingKeys.self)
		airports = try values.decodeIfPresent([Airports].self, forKey: .airports)
        
	}

}
