

import Foundation

struct Fare : Codable {
	let basicFare : Int?
	let brandKeys : String?
	let discountValue : Int?
	let dueAmount : Int?
	let exchangeRate : Int?
	let fareName : Int?
	let offeredFare : Int?
	let pNRAmount : Int?
	let paxFares : [PaxFares]?
	let refundAmount : Int?
	let requestedFare : Int?
	let seatCharge : Int?
	let totalCommission : Int?
	let totalFareWithOutMarkUp : Int?
	let totalSSRAmount : Int?
	let totalTDS : Int?
	let totalTaxWithOutMarkUp : Int?

	enum CodingKeys: String, CodingKey {

		case basicFare = "BasicFare"
		case brandKeys = "BrandKeys"
		case discountValue = "DiscountValue"
		case dueAmount = "DueAmount"
		case exchangeRate = "ExchangeRate"
		case fareName = "FareName"
		case offeredFare = "OfferedFare"
		case pNRAmount = "PNRAmount"
		case paxFares = "PaxFares"
		case refundAmount = "RefundAmount"
		case requestedFare = "RequestedFare"
		case seatCharge = "SeatCharge"
		case totalCommission = "TotalCommission"
		case totalFareWithOutMarkUp = "TotalFareWithOutMarkUp"
		case totalSSRAmount = "TotalSSRAmount"
		case totalTDS = "TotalTDS"
		case totalTaxWithOutMarkUp = "TotalTaxWithOutMarkUp"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		basicFare = try values.decodeIfPresent(Int.self, forKey: .basicFare)
		brandKeys = try values.decodeIfPresent(String.self, forKey: .brandKeys)
		discountValue = try values.decodeIfPresent(Int.self, forKey: .discountValue)
		dueAmount = try values.decodeIfPresent(Int.self, forKey: .dueAmount)
		exchangeRate = try values.decodeIfPresent(Int.self, forKey: .exchangeRate)
		fareName = try values.decodeIfPresent(Int.self, forKey: .fareName)
		offeredFare = try values.decodeIfPresent(Int.self, forKey: .offeredFare)
		pNRAmount = try values.decodeIfPresent(Int.self, forKey: .pNRAmount)
		paxFares = try values.decodeIfPresent([PaxFares].self, forKey: .paxFares)
		refundAmount = try values.decodeIfPresent(Int.self, forKey: .refundAmount)
		requestedFare = try values.decodeIfPresent(Int.self, forKey: .requestedFare)
		seatCharge = try values.decodeIfPresent(Int.self, forKey: .seatCharge)
		totalCommission = try values.decodeIfPresent(Int.self, forKey: .totalCommission)
		totalFareWithOutMarkUp = try values.decodeIfPresent(Int.self, forKey: .totalFareWithOutMarkUp)
		totalSSRAmount = try values.decodeIfPresent(Int.self, forKey: .totalSSRAmount)
		totalTDS = try values.decodeIfPresent(Int.self, forKey: .totalTDS)
		totalTaxWithOutMarkUp = try values.decodeIfPresent(Int.self, forKey: .totalTaxWithOutMarkUp)
	}

}
