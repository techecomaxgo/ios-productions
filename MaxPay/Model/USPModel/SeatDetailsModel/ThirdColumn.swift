/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ThirdColumn : Codable {
	let available : Bool?
	let baseFare : Int?
	let column : String?
	let ladiesSeat : String?
	let length : String?
	let seatAvail : Int?
	let name : String?
	let row : String?
	let id : String?
	let seatStyle : String?
	let width : String?
	let zIndex : String?
	let fare : Int?
	let seatType : String?
	let imageUrl : String?
	let isSleeper : Bool?
	let isAc : Bool?
	let upperShow : Bool?
	let lowerShow : Bool?
	let gender : String?
	let columnNo : Int?
	let rowNo : Int?
	let seqNo : Int?
	let actualfare : Int?
	let lavyFare : Int?
	let tollFee : Int?
	let srtFee : Int?
	let bookingFee : Int?
	let bankTrexAmt : Int?
	let concession : Int?
	let serviceTaxAbsolute : Int?
	let serviceTaxPercent : Int?
	let convenienceTaxPercent : Int?
	let convenienceCharge : Int?
	let totalBookingAmount : Int?
	let isSemiSleeper : Bool?
	let uniqueId : String?
	let type : String?
	let baseCFare : Int?
	let cFare : Int?
	let cConcession : Int?
	let cBookingFee : Int?
	let cTollFee : Int?
	let cLavyFee : Int?
	let cTaxAbsoluteFee : Int?
	let isVertical : Bool?
	let seatDiscountFare : Int?
	let seatCouponCode : String?
	let serviceFee_ : Int?

	enum CodingKeys: String, CodingKey {

		case available = "available"
		case baseFare = "baseFare"
		case column = "column"
		case ladiesSeat = "ladiesSeat"
		case length = "length"
		case seatAvail = "seatAvail"
		case name = "name"
		case row = "row"
		case id = "id"
		case seatStyle = "seatStyle"
		case width = "width"
		case zIndex = "zIndex"
		case fare = "fare"
		case seatType = "seatType"
		case imageUrl = "ImageUrl"
		case isSleeper = "isSleeper"
		case isAc = "isAc"
		case upperShow = "upperShow"
		case lowerShow = "lowerShow"
		case gender = "gender"
		case columnNo = "columnNo"
		case rowNo = "rowNo"
		case seqNo = "seqNo"
		case actualfare = "actualfare"
		case lavyFare = "lavyFare"
		case tollFee = "tollFee"
		case srtFee = "srtFee"
		case bookingFee = "bookingFee"
		case bankTrexAmt = "bankTrexAmt"
		case concession = "concession"
		case serviceTaxAbsolute = "serviceTaxAbsolute"
		case serviceTaxPercent = "serviceTaxPercent"
		case convenienceTaxPercent = "convenienceTaxPercent"
		case convenienceCharge = "convenienceCharge"
		case totalBookingAmount = "TotalBookingAmount"
		case isSemiSleeper = "isSemiSleeper"
		case uniqueId = "UniqueId"
		case type = "Type"
		case baseCFare = "BaseCFare"
		case cFare = "CFare"
		case cConcession = "CConcession"
		case cBookingFee = "CBookingFee"
		case cTollFee = "CTollFee"
		case cLavyFee = "CLavyFee"
		case cTaxAbsoluteFee = "CTaxAbsoluteFee"
		case isVertical = "IsVertical"
		case seatDiscountFare = "seatDiscountFare"
		case seatCouponCode = "seatCouponCode"
		case serviceFee_ = "ServiceFee_"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		available = try values.decodeIfPresent(Bool.self, forKey: .available)
		baseFare = try values.decodeIfPresent(Int.self, forKey: .baseFare)
		column = try values.decodeIfPresent(String.self, forKey: .column)
		ladiesSeat = try values.decodeIfPresent(String.self, forKey: .ladiesSeat)
		length = try values.decodeIfPresent(String.self, forKey: .length)
		seatAvail = try values.decodeIfPresent(Int.self, forKey: .seatAvail)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		row = try values.decodeIfPresent(String.self, forKey: .row)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		seatStyle = try values.decodeIfPresent(String.self, forKey: .seatStyle)
		width = try values.decodeIfPresent(String.self, forKey: .width)
		zIndex = try values.decodeIfPresent(String.self, forKey: .zIndex)
		fare = try values.decodeIfPresent(Int.self, forKey: .fare)
		seatType = try values.decodeIfPresent(String.self, forKey: .seatType)
		imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
		isSleeper = try values.decodeIfPresent(Bool.self, forKey: .isSleeper)
		isAc = try values.decodeIfPresent(Bool.self, forKey: .isAc)
		upperShow = try values.decodeIfPresent(Bool.self, forKey: .upperShow)
		lowerShow = try values.decodeIfPresent(Bool.self, forKey: .lowerShow)
		gender = try values.decodeIfPresent(String.self, forKey: .gender)
		columnNo = try values.decodeIfPresent(Int.self, forKey: .columnNo)
		rowNo = try values.decodeIfPresent(Int.self, forKey: .rowNo)
		seqNo = try values.decodeIfPresent(Int.self, forKey: .seqNo)
		actualfare = try values.decodeIfPresent(Int.self, forKey: .actualfare)
		lavyFare = try values.decodeIfPresent(Int.self, forKey: .lavyFare)
		tollFee = try values.decodeIfPresent(Int.self, forKey: .tollFee)
		srtFee = try values.decodeIfPresent(Int.self, forKey: .srtFee)
		bookingFee = try values.decodeIfPresent(Int.self, forKey: .bookingFee)
		bankTrexAmt = try values.decodeIfPresent(Int.self, forKey: .bankTrexAmt)
		concession = try values.decodeIfPresent(Int.self, forKey: .concession)
		serviceTaxAbsolute = try values.decodeIfPresent(Int.self, forKey: .serviceTaxAbsolute)
		serviceTaxPercent = try values.decodeIfPresent(Int.self, forKey: .serviceTaxPercent)
		convenienceTaxPercent = try values.decodeIfPresent(Int.self, forKey: .convenienceTaxPercent)
		convenienceCharge = try values.decodeIfPresent(Int.self, forKey: .convenienceCharge)
		totalBookingAmount = try values.decodeIfPresent(Int.self, forKey: .totalBookingAmount)
		isSemiSleeper = try values.decodeIfPresent(Bool.self, forKey: .isSemiSleeper)
		uniqueId = try values.decodeIfPresent(String.self, forKey: .uniqueId)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		baseCFare = try values.decodeIfPresent(Int.self, forKey: .baseCFare)
		cFare = try values.decodeIfPresent(Int.self, forKey: .cFare)
		cConcession = try values.decodeIfPresent(Int.self, forKey: .cConcession)
		cBookingFee = try values.decodeIfPresent(Int.self, forKey: .cBookingFee)
		cTollFee = try values.decodeIfPresent(Int.self, forKey: .cTollFee)
		cLavyFee = try values.decodeIfPresent(Int.self, forKey: .cLavyFee)
		cTaxAbsoluteFee = try values.decodeIfPresent(Int.self, forKey: .cTaxAbsoluteFee)
		isVertical = try values.decodeIfPresent(Bool.self, forKey: .isVertical)
		seatDiscountFare = try values.decodeIfPresent(Int.self, forKey: .seatDiscountFare)
		seatCouponCode = try values.decodeIfPresent(String.self, forKey: .seatCouponCode)
		serviceFee_ = try values.decodeIfPresent(Int.self, forKey: .serviceFee_)
	}

}