
import Foundation


struct ChainModel_Base : Codable {
	let status : String?
	let count : Int?
	let total_earned : Int?
	let users : [Users]?
    let isActive : Bool?
    let data: String?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case count = "count"
		case total_earned = "total_earned"
		case users = "users"
        case isActive = "isActive"
        case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		count = try values.decodeIfPresent(Int.self, forKey: .count)
		total_earned = try values.decodeIfPresent(Int.self, forKey: .total_earned)
		users = try values.decodeIfPresent([Users].self, forKey: .users)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        data = try values.decodeIfPresent(String.self, forKey: .data)
	}

}
