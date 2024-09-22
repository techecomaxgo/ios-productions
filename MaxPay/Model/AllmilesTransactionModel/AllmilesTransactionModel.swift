

import Foundation

struct AllmilesTransactionModel : Codable {
    
	let status : String?
	let count : Int?
	let data : [AllmilesTransModelData]?
    
	let pagination : Pagination_Miles?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case count = "count"
		case data = "data"
		case pagination = "pagination"
	}

	init(from decoder: Decoder) throws {
        
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		count = try values.decodeIfPresent(Int.self, forKey: .count)
		data = try values.decodeIfPresent([AllmilesTransModelData].self, forKey: .data)
		pagination = try values.decodeIfPresent(Pagination_Miles.self, forKey: .pagination)
        
	}

}
