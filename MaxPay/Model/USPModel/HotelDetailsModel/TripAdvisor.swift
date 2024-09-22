

import Foundation
struct TripAdvisor : Codable {
	let hotel_Web_url : String?
	let num_Reviews : String?
	let rankingString : String?
	let rating : String?
	let ratingView : [RatingView]?
	let rating_Image_Url : String?
	let tripID : String?
	let userReviews : [UserReviews]?
	let write_Review_Url : String?
	let reviewrating1 : String?
	let reviewrating2 : String?
	let reviewrating3 : String?
	let reviewrating4 : String?
	let reviewrating5 : String?

	enum CodingKeys: String, CodingKey {

		case hotel_Web_url = "Hotel_Web_url"
		case num_Reviews = "Num_Reviews"
		case rankingString = "RankingString"
		case rating = "Rating"
		case ratingView = "RatingView"
		case rating_Image_Url = "Rating_Image_Url"
		case tripID = "TripID"
		case userReviews = "UserReviews"
		case write_Review_Url = "Write_Review_Url"
		case reviewrating1 = "reviewrating1"
		case reviewrating2 = "reviewrating2"
		case reviewrating3 = "reviewrating3"
		case reviewrating4 = "reviewrating4"
		case reviewrating5 = "reviewrating5"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		hotel_Web_url = try values.decodeIfPresent(String.self, forKey: .hotel_Web_url)
		num_Reviews = try values.decodeIfPresent(String.self, forKey: .num_Reviews)
		rankingString = try values.decodeIfPresent(String.self, forKey: .rankingString)
		rating = try values.decodeIfPresent(String.self, forKey: .rating)
		ratingView = try values.decodeIfPresent([RatingView].self, forKey: .ratingView)
		rating_Image_Url = try values.decodeIfPresent(String.self, forKey: .rating_Image_Url)
		tripID = try values.decodeIfPresent(String.self, forKey: .tripID)
		userReviews = try values.decodeIfPresent([UserReviews].self, forKey: .userReviews)
		write_Review_Url = try values.decodeIfPresent(String.self, forKey: .write_Review_Url)
		reviewrating1 = try values.decodeIfPresent(String.self, forKey: .reviewrating1)
		reviewrating2 = try values.decodeIfPresent(String.self, forKey: .reviewrating2)
		reviewrating3 = try values.decodeIfPresent(String.self, forKey: .reviewrating3)
		reviewrating4 = try values.decodeIfPresent(String.self, forKey: .reviewrating4)
		reviewrating5 = try values.decodeIfPresent(String.self, forKey: .reviewrating5)
	}

}
