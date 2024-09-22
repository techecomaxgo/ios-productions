

import Foundation

struct PaxFares : Codable {
	let adminMarkUP : Int?
	let airlinePnr : String?
	let baggageUnit : String?
	let baggageWeight : String?
	let baseTransactionAmount : Int?
	let basicFare : Int?
	let branded : String?
	let cDValue : Int?
	let cancelPenalty : Int?
	let cashback : Int?
	let changePenalty : Int?
	let commission : Int?
	let dFValue : String?
	let equivCurrencyCode : String?
	let exSeatFare : Int?
	let exSeatFareStatus : Bool?
	let fare : [Fare]?
	let fareBasisCode : String?
	let fareInfoKey : String?
	let fareInfoValue : String?
	let gDSPnr : String?
	let insuranceAmount : Int?
	let isZeroCancellation : Bool?
	let markUP : Int?
	let paxType : Int?
	let refundable : Bool?
	let sTF : Int?
	let serviceFee : Int?
	let tDS : Double?
	let totalFare : Int?
	let totalTax : Int?
	let transactionAmount : Int?
	let transactionFee : Int?
	let zeroCancellationCharge : Int?
	let zeroCancellationValidity : String?

	enum CodingKeys: String, CodingKey {

		case adminMarkUP = "AdminMarkUP"
		case airlinePnr = "AirlinePnr"
		case baggageUnit = "BaggageUnit"
		case baggageWeight = "BaggageWeight"
		case baseTransactionAmount = "BaseTransactionAmount"
		case basicFare = "BasicFare"
		case branded = "Branded"
		case cDValue = "CDValue"
		case cancelPenalty = "CancelPenalty"
		case cashback = "Cashback"
		case changePenalty = "ChangePenalty"
		case commission = "Commission"
		case dFValue = "DFValue"
		case equivCurrencyCode = "EquivCurrencyCode"
		case exSeatFare = "ExSeatFare"
		case exSeatFareStatus = "ExSeatFareStatus"
		case fare = "Fare"
		case fareBasisCode = "FareBasisCode"
		case fareInfoKey = "FareInfoKey"
		case fareInfoValue = "FareInfoValue"
		case gDSPnr = "GDSPnr"
		case insuranceAmount = "InsuranceAmount"
		case isZeroCancellation = "IsZeroCancellation"
		case markUP = "MarkUP"
		case paxType = "PaxType"
		case refundable = "Refundable"
		case sTF = "STF"
		case serviceFee = "ServiceFee"
		case tDS = "TDS"
		case totalFare = "TotalFare"
		case totalTax = "TotalTax"
		case transactionAmount = "TransactionAmount"
		case transactionFee = "TransactionFee"
		case zeroCancellationCharge = "ZeroCancellationCharge"
		case zeroCancellationValidity = "ZeroCancellationValidity"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		adminMarkUP = try values.decodeIfPresent(Int.self, forKey: .adminMarkUP)
		airlinePnr = try values.decodeIfPresent(String.self, forKey: .airlinePnr)
		baggageUnit = try values.decodeIfPresent(String.self, forKey: .baggageUnit)
		baggageWeight = try values.decodeIfPresent(String.self, forKey: .baggageWeight)
		baseTransactionAmount = try values.decodeIfPresent(Int.self, forKey: .baseTransactionAmount)
		basicFare = try values.decodeIfPresent(Int.self, forKey: .basicFare)
		branded = try values.decodeIfPresent(String.self, forKey: .branded)
		cDValue = try values.decodeIfPresent(Int.self, forKey: .cDValue)
		cancelPenalty = try values.decodeIfPresent(Int.self, forKey: .cancelPenalty)
		cashback = try values.decodeIfPresent(Int.self, forKey: .cashback)
		changePenalty = try values.decodeIfPresent(Int.self, forKey: .changePenalty)
		commission = try values.decodeIfPresent(Int.self, forKey: .commission)
		dFValue = try values.decodeIfPresent(String.self, forKey: .dFValue)
		equivCurrencyCode = try values.decodeIfPresent(String.self, forKey: .equivCurrencyCode)
		exSeatFare = try values.decodeIfPresent(Int.self, forKey: .exSeatFare)
		exSeatFareStatus = try values.decodeIfPresent(Bool.self, forKey: .exSeatFareStatus)
		fare = try values.decodeIfPresent([Fare].self, forKey: .fare)
		fareBasisCode = try values.decodeIfPresent(String.self, forKey: .fareBasisCode)
		fareInfoKey = try values.decodeIfPresent(String.self, forKey: .fareInfoKey)
		fareInfoValue = try values.decodeIfPresent(String.self, forKey: .fareInfoValue)
		gDSPnr = try values.decodeIfPresent(String.self, forKey: .gDSPnr)
		insuranceAmount = try values.decodeIfPresent(Int.self, forKey: .insuranceAmount)
		isZeroCancellation = try values.decodeIfPresent(Bool.self, forKey: .isZeroCancellation)
		markUP = try values.decodeIfPresent(Int.self, forKey: .markUP)
		paxType = try values.decodeIfPresent(Int.self, forKey: .paxType)
		refundable = try values.decodeIfPresent(Bool.self, forKey: .refundable)
		sTF = try values.decodeIfPresent(Int.self, forKey: .sTF)
		serviceFee = try values.decodeIfPresent(Int.self, forKey: .serviceFee)
		tDS = try values.decodeIfPresent(Double.self, forKey: .tDS)
		totalFare = try values.decodeIfPresent(Int.self, forKey: .totalFare)
		totalTax = try values.decodeIfPresent(Int.self, forKey: .totalTax)
		transactionAmount = try values.decodeIfPresent(Int.self, forKey: .transactionAmount)
		transactionFee = try values.decodeIfPresent(Int.self, forKey: .transactionFee)
		zeroCancellationCharge = try values.decodeIfPresent(Int.self, forKey: .zeroCancellationCharge)
		zeroCancellationValidity = try values.decodeIfPresent(String.self, forKey: .zeroCancellationValidity)
	}

}
