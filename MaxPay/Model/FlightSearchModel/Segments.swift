

import Foundation

struct Segments : Codable {
	let bondType : String?
	var bonds : [Bonds]?
	let currencyCode : String?
	let deeplink : String?
	let engineID : Int?
	let extSeatAvailStatus : Bool?
	let fare : Fare?
	let fareCategory : Int?
	let fareIndicator : Int?
	let fareRule : String?
	let fares : String?
	let insuranceProvider : Int?
	let isBaggageFare : Bool?
	let isBrandAvailable : Bool?
	let isBranded : Bool?
	let isCache : Bool?
	let isHoldBooking : Bool?
	let isInsurance : Bool?
	let isInternational : Bool?
	let isRoundTrip : Bool?
	let isSegmentChanged : Bool?
	let isSpecial : Bool?
	let isSpecialId : Bool?
	let itineraryKey : String?
	let journeyIndex : Int?
	let memoryCreationTime : String?
	let nearByAirport : Bool?
	let paxSSRs : String?
	let promoCode : String?
	let remark : String?
	let sSDetails : String?
	let sSRDetails : String?
	let searchId : String?
	let sessionfilepath : String?
	let shellPNR : String?
	let visaInfo : String?
	let zCStatus : Bool?
	let description : String?

	enum CodingKeys: String, CodingKey {

		case bondType = "BondType"
		case bonds = "Bonds"
		case currencyCode = "CurrencyCode"
		case deeplink = "Deeplink"
		case engineID = "EngineID"
		case extSeatAvailStatus = "ExtSeatAvailStatus"
		case fare = "Fare"
		case fareCategory = "FareCategory"
		case fareIndicator = "FareIndicator"
		case fareRule = "FareRule"
		case fares = "Fares"
		case insuranceProvider = "InsuranceProvider"
		case isBaggageFare = "IsBaggageFare"
		case isBrandAvailable = "IsBrandAvailable"
		case isBranded = "IsBranded"
		case isCache = "IsCache"
		case isHoldBooking = "IsHoldBooking"
		case isInsurance = "IsInsurance"
		case isInternational = "IsInternational"
		case isRoundTrip = "IsRoundTrip"
		case isSegmentChanged = "IsSegmentChanged"
		case isSpecial = "IsSpecial"
		case isSpecialId = "IsSpecialId"
		case itineraryKey = "ItineraryKey"
		case journeyIndex = "JourneyIndex"
		case memoryCreationTime = "MemoryCreationTime"
		case nearByAirport = "NearByAirport"
		case paxSSRs = "PaxSSRs"
		case promoCode = "PromoCode"
		case remark = "Remark"
		case sSDetails = "SSDetails"
		case sSRDetails = "SSRDetails"
		case searchId = "SearchId"
		case sessionfilepath = "Sessionfilepath"
		case shellPNR = "ShellPNR"
		case visaInfo = "VisaInfo"
		case zCStatus = "ZCStatus"
		case description = "description"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		bondType = try values.decodeIfPresent(String.self, forKey: .bondType)
		bonds = try values.decodeIfPresent([Bonds].self, forKey: .bonds)
		currencyCode = try values.decodeIfPresent(String.self, forKey: .currencyCode)
		deeplink = try values.decodeIfPresent(String.self, forKey: .deeplink)
		engineID = try values.decodeIfPresent(Int.self, forKey: .engineID)
		extSeatAvailStatus = try values.decodeIfPresent(Bool.self, forKey: .extSeatAvailStatus)
		fare = try values.decodeIfPresent(Fare.self, forKey: .fare)
		fareCategory = try values.decodeIfPresent(Int.self, forKey: .fareCategory)
		fareIndicator = try values.decodeIfPresent(Int.self, forKey: .fareIndicator)
		fareRule = try values.decodeIfPresent(String.self, forKey: .fareRule)
		fares = try values.decodeIfPresent(String.self, forKey: .fares)
		insuranceProvider = try values.decodeIfPresent(Int.self, forKey: .insuranceProvider)
		isBaggageFare = try values.decodeIfPresent(Bool.self, forKey: .isBaggageFare)
		isBrandAvailable = try values.decodeIfPresent(Bool.self, forKey: .isBrandAvailable)
		isBranded = try values.decodeIfPresent(Bool.self, forKey: .isBranded)
		isCache = try values.decodeIfPresent(Bool.self, forKey: .isCache)
		isHoldBooking = try values.decodeIfPresent(Bool.self, forKey: .isHoldBooking)
		isInsurance = try values.decodeIfPresent(Bool.self, forKey: .isInsurance)
		isInternational = try values.decodeIfPresent(Bool.self, forKey: .isInternational)
		isRoundTrip = try values.decodeIfPresent(Bool.self, forKey: .isRoundTrip)
		isSegmentChanged = try values.decodeIfPresent(Bool.self, forKey: .isSegmentChanged)
		isSpecial = try values.decodeIfPresent(Bool.self, forKey: .isSpecial)
		isSpecialId = try values.decodeIfPresent(Bool.self, forKey: .isSpecialId)
		itineraryKey = try values.decodeIfPresent(String.self, forKey: .itineraryKey)
		journeyIndex = try values.decodeIfPresent(Int.self, forKey: .journeyIndex)
		memoryCreationTime = try values.decodeIfPresent(String.self, forKey: .memoryCreationTime)
		nearByAirport = try values.decodeIfPresent(Bool.self, forKey: .nearByAirport)
		paxSSRs = try values.decodeIfPresent(String.self, forKey: .paxSSRs)
		promoCode = try values.decodeIfPresent(String.self, forKey: .promoCode)
		remark = try values.decodeIfPresent(String.self, forKey: .remark)
		sSDetails = try values.decodeIfPresent(String.self, forKey: .sSDetails)
		sSRDetails = try values.decodeIfPresent(String.self, forKey: .sSRDetails)
		searchId = try values.decodeIfPresent(String.self, forKey: .searchId)
		sessionfilepath = try values.decodeIfPresent(String.self, forKey: .sessionfilepath)
		shellPNR = try values.decodeIfPresent(String.self, forKey: .shellPNR)
		visaInfo = try values.decodeIfPresent(String.self, forKey: .visaInfo)
		zCStatus = try values.decodeIfPresent(Bool.self, forKey: .zCStatus)
		description = try values.decodeIfPresent(String.self, forKey: .description)
	}

}
