


import Foundation

struct DataSubPlans: Codable {

	let success: Bool?
	//let hitCredit: String?
	//let apiStarted: String?
	//let apiExpiry: String?
	let operatorField: String?
	let circle: String?
	let message: String?
	let plans: Plans?

	private enum CodingKeys: String, CodingKey {
		case success = "success"
		//case hitCredit = "hit_credit"
		//case apiStarted = "api_started"
		//case apiExpiry = "api_expiry"
		case operatorField = "operator"
		case circle = "circle"
		case message = "message"
		case plans = "plans"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		success = try values.decode(Bool.self, forKey: .success)
		//hitCredit = try values.decode(String.self, forKey: .hitCredit)
		//apiStarted = try values.decode(String.self, forKey: .apiStarted)
		//apiExpiry = try values.decode(String.self, forKey: .apiExpiry)
		operatorField = try values.decode(String.self, forKey: .operatorField)
		circle = try values.decode(String.self, forKey: .circle)
		message = try values.decode(String.self, forKey: .message)
		plans = try values.decode(Plans.self, forKey: .plans)
	}

}
