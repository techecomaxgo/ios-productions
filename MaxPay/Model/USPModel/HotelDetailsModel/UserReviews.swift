

import Foundation
struct UserReviews : Codable {
	let helpFulVotes : String?
	let rating : String?
	let reviewText : String?
	let reviewType : String?
	let reviewUrl : String?
	let title : String?
	let travel_Date : String?
	let trip_Type : String?
	let url : String?
	let userName : String?

	enum CodingKeys: String, CodingKey {

		case helpFulVotes = "HelpFulVotes"
		case rating = "Rating"
		case reviewText = "ReviewText"
		case reviewType = "ReviewType"
		case reviewUrl = "ReviewUrl"
		case title = "Title"
		case travel_Date = "Travel_Date"
		case trip_Type = "Trip_Type"
		case url = "Url"
		case userName = "UserName"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		helpFulVotes = try values.decodeIfPresent(String.self, forKey: .helpFulVotes)
		rating = try values.decodeIfPresent(String.self, forKey: .rating)
		reviewText = try values.decodeIfPresent(String.self, forKey: .reviewText)
		reviewType = try values.decodeIfPresent(String.self, forKey: .reviewType)
		reviewUrl = try values.decodeIfPresent(String.self, forKey: .reviewUrl)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		travel_Date = try values.decodeIfPresent(String.self, forKey: .travel_Date)
		trip_Type = try values.decodeIfPresent(String.self, forKey: .trip_Type)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		userName = try values.decodeIfPresent(String.self, forKey: .userName)
	}

}
