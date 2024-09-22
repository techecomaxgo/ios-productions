

import Foundation

struct GetWalletDetailsApi_Data : Codable {
	let user_id : String?
	let wallet_id : String?
	let wallet_bal : String?

	enum CodingKeys: String, CodingKey {

		case user_id = "user_id"
		case wallet_id = "wallet_id"
		case wallet_bal = "wallet_bal"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
		wallet_id = try values.decodeIfPresent(String.self, forKey: .wallet_id)
		wallet_bal = try values.decodeIfPresent(String.self, forKey: .wallet_bal)
	}

}
