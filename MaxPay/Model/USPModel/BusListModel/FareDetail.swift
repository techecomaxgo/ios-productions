/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct FareDetail : Codable {
	let baseFare : String?
	let markupFareAbsolute : String?
	let markupFarePercentage : String?
	let operatorServiceChargeAbsolute : String?
	let operatorServiceChargePercentage : String?
	let serviceTaxAbsolute : String?
	let serviceTaxPercentage : String?
	let totalFare : String?
	let lavyFare : String?
	let tollFee : String?
	let srtFee : String?
	let bookingFee : String?
	let bankTrexAmt : String?
	let totalTax : String?

	enum CodingKeys: String, CodingKey {

		case baseFare = "baseFare"
		case markupFareAbsolute = "markupFareAbsolute"
		case markupFarePercentage = "markupFarePercentage"
		case operatorServiceChargeAbsolute = "operatorServiceChargeAbsolute"
		case operatorServiceChargePercentage = "operatorServiceChargePercentage"
		case serviceTaxAbsolute = "serviceTaxAbsolute"
		case serviceTaxPercentage = "serviceTaxPercentage"
		case totalFare = "totalFare"
		case lavyFare = "lavyFare"
		case tollFee = "tollFee"
		case srtFee = "srtFee"
		case bookingFee = "bookingFee"
		case bankTrexAmt = "bankTrexAmt"
		case totalTax = "totalTax"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		baseFare = try values.decodeIfPresent(String.self, forKey: .baseFare)
		markupFareAbsolute = try values.decodeIfPresent(String.self, forKey: .markupFareAbsolute)
		markupFarePercentage = try values.decodeIfPresent(String.self, forKey: .markupFarePercentage)
		operatorServiceChargeAbsolute = try values.decodeIfPresent(String.self, forKey: .operatorServiceChargeAbsolute)
		operatorServiceChargePercentage = try values.decodeIfPresent(String.self, forKey: .operatorServiceChargePercentage)
		serviceTaxAbsolute = try values.decodeIfPresent(String.self, forKey: .serviceTaxAbsolute)
		serviceTaxPercentage = try values.decodeIfPresent(String.self, forKey: .serviceTaxPercentage)
		totalFare = try values.decodeIfPresent(String.self, forKey: .totalFare)
		lavyFare = try values.decodeIfPresent(String.self, forKey: .lavyFare)
		tollFee = try values.decodeIfPresent(String.self, forKey: .tollFee)
		srtFee = try values.decodeIfPresent(String.self, forKey: .srtFee)
		bookingFee = try values.decodeIfPresent(String.self, forKey: .bookingFee)
		bankTrexAmt = try values.decodeIfPresent(String.self, forKey: .bankTrexAmt)
		totalTax = try values.decodeIfPresent(String.self, forKey: .totalTax)
	}

}