
import Foundation

struct AllmilesTransModelData : Codable {
    
	let id : Int?
	let spent_amount : String?
	let miles : Int?
	let service_type : String?
	let status : String?
	let expiry_date : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case spent_amount = "spent_amount"
		case miles = "miles"
		case service_type = "service_type"
		case status = "status"
		case expiry_date = "expiry_date"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		spent_amount = try values.decodeIfPresent(String.self, forKey: .spent_amount)
		miles = try values.decodeIfPresent(Int.self, forKey: .miles)
		service_type = try values.decodeIfPresent(String.self, forKey: .service_type)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		expiry_date = try values.decodeIfPresent(String.self, forKey: .expiry_date)
	}

}
