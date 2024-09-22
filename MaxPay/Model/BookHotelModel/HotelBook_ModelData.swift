

import Foundation

struct HotelBook_ModelData : Codable {
    
	let error : String?
	let hotelEmailAddress : String?
	let hotelPhoneNumber : String?
	let importantInfo : String?
	let confirmationNumbers : [String]?
	let itineraryId : String?
	let processWithConfirmation : String?
	let rateKey : String?
	let reservationNumbers : String?
	let reservationStatusCode : String?
	let transactionid : Int?

	enum CodingKeys: String, CodingKey {

		case error = "Error"
		case hotelEmailAddress = "HotelEmailAddress"
		case hotelPhoneNumber = "HotelPhoneNumber"
		case importantInfo = "ImportantInfo"
		case confirmationNumbers = "confirmationNumbers"
		case itineraryId = "itineraryId"
		case processWithConfirmation = "processWithConfirmation"
		case rateKey = "rateKey"
		case reservationNumbers = "reservationNumbers"
		case reservationStatusCode = "reservationStatusCode"
		case transactionid = "transactionid"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		error = try values.decodeIfPresent(String.self, forKey: .error)
		hotelEmailAddress = try values.decodeIfPresent(String.self, forKey: .hotelEmailAddress)
		hotelPhoneNumber = try values.decodeIfPresent(String.self, forKey: .hotelPhoneNumber)
		importantInfo = try values.decodeIfPresent(String.self, forKey: .importantInfo)
		confirmationNumbers = try values.decodeIfPresent([String].self, forKey: .confirmationNumbers)
		itineraryId = try values.decodeIfPresent(String.self, forKey: .itineraryId)
		processWithConfirmation = try values.decodeIfPresent(String.self, forKey: .processWithConfirmation)
		rateKey = try values.decodeIfPresent(String.self, forKey: .rateKey)
		reservationNumbers = try values.decodeIfPresent(String.self, forKey: .reservationNumbers)
		reservationStatusCode = try values.decodeIfPresent(String.self, forKey: .reservationStatusCode)
		transactionid = try values.decodeIfPresent(Int.self, forKey: .transactionid)
	}

}
