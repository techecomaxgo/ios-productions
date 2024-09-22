/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct AvailableTrips : Codable {
	let aC : Bool?
	let arrivalTime : String?
	let availableSeats : String?
	let busType : String?
	let busTypeId : String?
	let cancellationPolicy : String?
	let departureTime : String?
	let doj : String?
	let duration : String?
	let bdPoints : [BdPoints]?
	let dpPoints : [DpPoints]?
	let fareDetail : [FareDetail]?
	let fares : [String]?
	let travels : String?
	let id : String?
	let routeId : String?
	let price : String?
	let seater : Bool?
	let sleeper : Bool?
	let idProofRequired : String?
	let liveTrackingAvailable : Bool?
	let nonAC : Bool?
	let operatorid : String?
	let partialCancellationAllowed : String?
	let tatkalTime : String?
	let vehicleType : String?
	let zeroCancellationTime : String?
	let mTicketEnabled : String?
	let sortDepTime : Int?
	let engineId : Int?
	let cancelPolicyList : [CancelPolicyList]?
	let isVolvo : Bool?
	let isCancellable : Bool?
	let status : String?
	let totalSeat : String?
	let departureDate : String?
	let arrivalDate : String?
	let discount : Int?
	let commission : Int?
	let markup : String?
	let tDS : Int?
	let sTF : Int?
	let lstamenities : [String]?
	let isSemiSleeper : Bool?
	let bookedSeats : String?
	let fareString : String?
	let lstSeat : String?
	let bpId : String?
	let dpId : String?
	let bpDpLayout : Bool?
	let refrenceNumber : String?
	let isSpecial : Bool?
	let displayMsg : String?
	let isBordDropFirst : Int?
	let isSingleLeady : Int?
	let allowedConcessions : String?
	let rt : String?
	let rtCus : String?
	let isCache : Bool?
	let isCovidSafe : Bool?
	let ststatus : Bool?
	let cpnCode : String?
	let cpMsg : String?
	let priceWithOutDiscount : String?
	let operatordiscount : Int?
	let serviceFee_ : Int?
	let isGovtBus : Bool?
	let serviceId : String?

	enum CodingKeys: String, CodingKey {

		case aC = "AC"
		case arrivalTime = "ArrivalTime"
		case availableSeats = "AvailableSeats"
		case busType = "busType"
		case busTypeId = "BusTypeId"
		case cancellationPolicy = "CancellationPolicy"
		case departureTime = "departureTime"
		case doj = "doj"
		case duration = "duration"
		case bdPoints = "bdPoints"
		case dpPoints = "dpPoints"
		case fareDetail = "fareDetail"
		case fares = "fares"
		case travels = "Travels"
		case id = "id"
		case routeId = "routeId"
		case price = "price"
		case seater = "seater"
		case sleeper = "sleeper"
		case idProofRequired = "idProofRequired"
		case liveTrackingAvailable = "liveTrackingAvailable"
		case nonAC = "nonAC"
		case operatorid = "operatorid"
		case partialCancellationAllowed = "partialCancellationAllowed"
		case tatkalTime = "tatkalTime"
		case vehicleType = "vehicleType"
		case zeroCancellationTime = "zeroCancellationTime"
		case mTicketEnabled = "mTicketEnabled"
		case sortDepTime = "sortDepTime"
		case engineId = "engineId"
		case cancelPolicyList = "cancelPolicyList"
		case isVolvo = "isVolvo"
		case isCancellable = "isCancellable"
		case status = "status"
		case totalSeat = "totalSeat"
		case departureDate = "departureDate"
		case arrivalDate = "arrivalDate"
		case discount = "Discount"
		case commission = "Commission"
		case markup = "markup"
		case tDS = "TDS"
		case sTF = "STF"
		case lstamenities = "lstamenities"
		case isSemiSleeper = "isSemiSleeper"
		case bookedSeats = "bookedSeats"
		case fareString = "fareString"
		case lstSeat = "lstSeat"
		case bpId = "BpId"
		case dpId = "DpId"
		case bpDpLayout = "BpDpLayout"
		case refrenceNumber = "RefrenceNumber"
		case isSpecial = "IsSpecial"
		case displayMsg = "DisplayMsg"
		case isBordDropFirst = "isBordDropFirst"
		case isSingleLeady = "IsSingleLeady"
		case allowedConcessions = "allowedConcessions"
		case rt = "rt"
		case rtCus = "rtCus"
		case isCache = "IsCache"
		case isCovidSafe = "IsCovidSafe"
		case ststatus = "ststatus"
		case cpnCode = "cpnCode"
		case cpMsg = "cpMsg"
		case priceWithOutDiscount = "priceWithOutDiscount"
		case operatordiscount = "operatordiscount"
		case serviceFee_ = "ServiceFee_"
		case isGovtBus = "IsGovtBus"
		case serviceId = "ServiceId"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		aC = try values.decodeIfPresent(Bool.self, forKey: .aC)
		arrivalTime = try values.decodeIfPresent(String.self, forKey: .arrivalTime)
		availableSeats = try values.decodeIfPresent(String.self, forKey: .availableSeats)
		busType = try values.decodeIfPresent(String.self, forKey: .busType)
		busTypeId = try values.decodeIfPresent(String.self, forKey: .busTypeId)
		cancellationPolicy = try values.decodeIfPresent(String.self, forKey: .cancellationPolicy)
		departureTime = try values.decodeIfPresent(String.self, forKey: .departureTime)
		doj = try values.decodeIfPresent(String.self, forKey: .doj)
		duration = try values.decodeIfPresent(String.self, forKey: .duration)
		bdPoints = try values.decodeIfPresent([BdPoints].self, forKey: .bdPoints)
		dpPoints = try values.decodeIfPresent([DpPoints].self, forKey: .dpPoints)
		fareDetail = try values.decodeIfPresent([FareDetail].self, forKey: .fareDetail)
		fares = try values.decodeIfPresent([String].self, forKey: .fares)
		travels = try values.decodeIfPresent(String.self, forKey: .travels)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		routeId = try values.decodeIfPresent(String.self, forKey: .routeId)
		price = try values.decodeIfPresent(String.self, forKey: .price)
		seater = try values.decodeIfPresent(Bool.self, forKey: .seater)
		sleeper = try values.decodeIfPresent(Bool.self, forKey: .sleeper)
		idProofRequired = try values.decodeIfPresent(String.self, forKey: .idProofRequired)
		liveTrackingAvailable = try values.decodeIfPresent(Bool.self, forKey: .liveTrackingAvailable)
		nonAC = try values.decodeIfPresent(Bool.self, forKey: .nonAC)
		operatorid = try values.decodeIfPresent(String.self, forKey: .operatorid)
		partialCancellationAllowed = try values.decodeIfPresent(String.self, forKey: .partialCancellationAllowed)
		tatkalTime = try values.decodeIfPresent(String.self, forKey: .tatkalTime)
		vehicleType = try values.decodeIfPresent(String.self, forKey: .vehicleType)
		zeroCancellationTime = try values.decodeIfPresent(String.self, forKey: .zeroCancellationTime)
		mTicketEnabled = try values.decodeIfPresent(String.self, forKey: .mTicketEnabled)
		sortDepTime = try values.decodeIfPresent(Int.self, forKey: .sortDepTime)
		engineId = try values.decodeIfPresent(Int.self, forKey: .engineId)
		cancelPolicyList = try values.decodeIfPresent([CancelPolicyList].self, forKey: .cancelPolicyList)
		isVolvo = try values.decodeIfPresent(Bool.self, forKey: .isVolvo)
		isCancellable = try values.decodeIfPresent(Bool.self, forKey: .isCancellable)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		totalSeat = try values.decodeIfPresent(String.self, forKey: .totalSeat)
		departureDate = try values.decodeIfPresent(String.self, forKey: .departureDate)
		arrivalDate = try values.decodeIfPresent(String.self, forKey: .arrivalDate)
		discount = try values.decodeIfPresent(Int.self, forKey: .discount)
		commission = try values.decodeIfPresent(Int.self, forKey: .commission)
		markup = try values.decodeIfPresent(String.self, forKey: .markup)
		tDS = try values.decodeIfPresent(Int.self, forKey: .tDS)
		sTF = try values.decodeIfPresent(Int.self, forKey: .sTF)
		lstamenities = try values.decodeIfPresent([String].self, forKey: .lstamenities)
		isSemiSleeper = try values.decodeIfPresent(Bool.self, forKey: .isSemiSleeper)
		bookedSeats = try values.decodeIfPresent(String.self, forKey: .bookedSeats)
		fareString = try values.decodeIfPresent(String.self, forKey: .fareString)
		lstSeat = try values.decodeIfPresent(String.self, forKey: .lstSeat)
		bpId = try values.decodeIfPresent(String.self, forKey: .bpId)
		dpId = try values.decodeIfPresent(String.self, forKey: .dpId)
		bpDpLayout = try values.decodeIfPresent(Bool.self, forKey: .bpDpLayout)
		refrenceNumber = try values.decodeIfPresent(String.self, forKey: .refrenceNumber)
		isSpecial = try values.decodeIfPresent(Bool.self, forKey: .isSpecial)
		displayMsg = try values.decodeIfPresent(String.self, forKey: .displayMsg)
		isBordDropFirst = try values.decodeIfPresent(Int.self, forKey: .isBordDropFirst)
		isSingleLeady = try values.decodeIfPresent(Int.self, forKey: .isSingleLeady)
		allowedConcessions = try values.decodeIfPresent(String.self, forKey: .allowedConcessions)
		rt = try values.decodeIfPresent(String.self, forKey: .rt)
		rtCus = try values.decodeIfPresent(String.self, forKey: .rtCus)
		isCache = try values.decodeIfPresent(Bool.self, forKey: .isCache)
		isCovidSafe = try values.decodeIfPresent(Bool.self, forKey: .isCovidSafe)
		ststatus = try values.decodeIfPresent(Bool.self, forKey: .ststatus)
		cpnCode = try values.decodeIfPresent(String.self, forKey: .cpnCode)
		cpMsg = try values.decodeIfPresent(String.self, forKey: .cpMsg)
		priceWithOutDiscount = try values.decodeIfPresent(String.self, forKey: .priceWithOutDiscount)
		operatordiscount = try values.decodeIfPresent(Int.self, forKey: .operatordiscount)
		serviceFee_ = try values.decodeIfPresent(Int.self, forKey: .serviceFee_)
		isGovtBus = try values.decodeIfPresent(Bool.self, forKey: .isGovtBus)
		serviceId = try values.decodeIfPresent(String.self, forKey: .serviceId)
	}

}
