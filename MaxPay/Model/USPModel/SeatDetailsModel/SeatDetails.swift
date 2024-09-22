/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct SeatDetails : Codable {
	let upperShow : Bool?
	let lowerShow : Bool?
	let lower : Lower?
	let upper : Upper?
	let listBoardingPoint : [ListBoardingPoint]?
	let listDropPoint : [ListDropPoint]?
	let maxcolumn : Int?
	let maxrow : Int?
	let seatAcFare : Int?
	let seatNacFare : Int?
	let sleepAcFare : Int?
	let sleepNacFare : Int?
	let minFare : Int?
	let maxFare : Int?
	let cancelPolicyListSeat : [CancelPolicyListSeat]?
	let uniquefares : String?
	let traceId : String?
	let isCovidSafe : Bool?
	let cRate : Int?
	let childCon : Int?
	let fCon : Bool?
	let vnCon : Bool?

	enum CodingKeys: String, CodingKey {

		case upperShow = "UpperShow"
		case lowerShow = "LowerShow"
		case lower = "Lower"
		case upper = "Upper"
		case listBoardingPoint = "listBoardingPoint"
		case listDropPoint = "listDropPoint"
		case maxcolumn = "maxcolumn"
		case maxrow = "maxrow"
		case seatAcFare = "seatAcFare"
		case seatNacFare = "seatNacFare"
		case sleepAcFare = "sleepAcFare"
		case sleepNacFare = "sleepNacFare"
		case minFare = "minFare"
		case maxFare = "maxFare"
		case cancelPolicyListSeat = "cancelPolicyList"
		case uniquefares = "uniquefares"
		case traceId = "TraceId"
		case isCovidSafe = "IsCovidSafe"
		case cRate = "cRate"
		case childCon = "childCon"
		case fCon = "fCon"
		case vnCon = "vnCon"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		upperShow = try values.decodeIfPresent(Bool.self, forKey: .upperShow)
		lowerShow = try values.decodeIfPresent(Bool.self, forKey: .lowerShow)
		lower = try values.decodeIfPresent(Lower.self, forKey: .lower)
		upper = try values.decodeIfPresent(Upper.self, forKey: .upper)
		listBoardingPoint = try values.decodeIfPresent([ListBoardingPoint].self, forKey: .listBoardingPoint)
		listDropPoint = try values.decodeIfPresent([ListDropPoint].self, forKey: .listDropPoint)
		maxcolumn = try values.decodeIfPresent(Int.self, forKey: .maxcolumn)
		maxrow = try values.decodeIfPresent(Int.self, forKey: .maxrow)
		seatAcFare = try values.decodeIfPresent(Int.self, forKey: .seatAcFare)
		seatNacFare = try values.decodeIfPresent(Int.self, forKey: .seatNacFare)
		sleepAcFare = try values.decodeIfPresent(Int.self, forKey: .sleepAcFare)
		sleepNacFare = try values.decodeIfPresent(Int.self, forKey: .sleepNacFare)
		minFare = try values.decodeIfPresent(Int.self, forKey: .minFare)
		maxFare = try values.decodeIfPresent(Int.self, forKey: .maxFare)
        cancelPolicyListSeat = try values.decodeIfPresent([CancelPolicyListSeat].self, forKey: .cancelPolicyListSeat)
		uniquefares = try values.decodeIfPresent(String.self, forKey: .uniquefares)
		traceId = try values.decodeIfPresent(String.self, forKey: .traceId)
		isCovidSafe = try values.decodeIfPresent(Bool.self, forKey: .isCovidSafe)
		cRate = try values.decodeIfPresent(Int.self, forKey: .cRate)
		childCon = try values.decodeIfPresent(Int.self, forKey: .childCon)
		fCon = try values.decodeIfPresent(Bool.self, forKey: .fCon)
		vnCon = try values.decodeIfPresent(Bool.self, forKey: .vnCon)
	}

}
