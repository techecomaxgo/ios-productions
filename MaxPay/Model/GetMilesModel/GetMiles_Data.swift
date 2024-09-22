

import Foundation


struct GetMiles_Data : Codable {
    
	let total_spent_amount : Int?
	let total_miles : Int?

	enum CodingKeys: String, CodingKey {

		case total_spent_amount = "total_spent_amount"
		case total_miles = "total_miles"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		total_spent_amount = try values.decodeIfPresent(Int.self, forKey: .total_spent_amount)
		total_miles = try values.decodeIfPresent(Int.self, forKey: .total_miles)
	}

}
