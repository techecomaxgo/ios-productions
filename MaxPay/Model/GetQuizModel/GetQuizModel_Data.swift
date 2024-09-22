

import Foundation

struct GetQuizModel_Data : Codable {
    
	let id : Int?
	let question : String?
	let options : Options?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case question = "question"
		case options = "options"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		question = try values.decodeIfPresent(String.self, forKey: .question)
		options = try values.decodeIfPresent(Options.self, forKey: .options)
	}

}
