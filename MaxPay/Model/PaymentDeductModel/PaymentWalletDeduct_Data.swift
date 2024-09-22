

import Foundation


struct PaymentWalletDeduct_Data : Codable {
    
	let user_phone : String?
	let balance : String?
	let txn_id : String?

	enum CodingKeys: String, CodingKey {

		case user_phone = "user_phone"
		case balance = "balance"
		case txn_id = "txn_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		user_phone = try values.decodeIfPresent(String.self, forKey: .user_phone)
		balance = try values.decodeIfPresent(String.self, forKey: .balance)
		txn_id = try values.decodeIfPresent(String.self, forKey: .txn_id)
	}

}
