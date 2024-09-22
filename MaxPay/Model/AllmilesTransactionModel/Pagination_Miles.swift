
import Foundation

struct Pagination_Miles : Codable {
    
	let currentPage : Int?
	let pageSize : Int?
	let totalPages : Int?
	let totalItems : Int?

	enum CodingKeys: String, CodingKey {

		case currentPage = "currentPage"
		case pageSize = "pageSize"
		case totalPages = "totalPages"
		case totalItems = "totalItems"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		currentPage = try values.decodeIfPresent(Int.self, forKey: .currentPage)
		pageSize = try values.decodeIfPresent(Int.self, forKey: .pageSize)
		totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
		totalItems = try values.decodeIfPresent(Int.self, forKey: .totalItems)
	}

}
