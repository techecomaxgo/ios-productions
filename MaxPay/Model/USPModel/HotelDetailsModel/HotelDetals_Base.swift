
import Foundation

struct HotelDetals_Base : Codable {
	let status : String?
	let message : String?
	let hotelDetail : HotelDetail?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case hotelDetail = "hotelDetail"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		hotelDetail = try values.decodeIfPresent(HotelDetail.self, forKey: .hotelDetail)
	}

}
