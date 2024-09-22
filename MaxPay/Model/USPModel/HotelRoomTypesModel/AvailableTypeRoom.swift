

import Foundation

struct AvailableTypeRoom : Codable {
    
	let deluxeDuplex : [DeluxeDuplex]?
	let executiveRoom : [ExecutiveRoom]?
	let suite : [Suite]?

	enum CodingKeys: String, CodingKey {

		case deluxeDuplex = "Deluxe Duplex"
		case executiveRoom = "Executive Room"
		case suite = "Suite"
	}

	init(from decoder: Decoder) throws {
        
		let values = try decoder.container(keyedBy: CodingKeys.self)
		deluxeDuplex = try values.decodeIfPresent([DeluxeDuplex].self, forKey: .deluxeDuplex)
		executiveRoom = try values.decodeIfPresent([ExecutiveRoom].self, forKey: .executiveRoom)
		suite = try values.decodeIfPresent([Suite].self, forKey: .suite)
        
	}

}
