/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct InterchangeFees : Codable {
	let interchangeFeeId : String?
	let feeCode : String?
	let feeDesc : String?
	let feeDirection : String?
	let interchangeFeeDetails : [InterchangeFeeDetails]?

	enum CodingKeys: String, CodingKey {

		case interchangeFeeId = "interchangeFeeId"
		case feeCode = "feeCode"
		case feeDesc = "feeDesc"
		case feeDirection = "feeDirection"
		case interchangeFeeDetails = "interchangeFeeDetails"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		interchangeFeeId = try values.decodeIfPresent(String.self, forKey: .interchangeFeeId)
		feeCode = try values.decodeIfPresent(String.self, forKey: .feeCode)
		feeDesc = try values.decodeIfPresent(String.self, forKey: .feeDesc)
		feeDirection = try values.decodeIfPresent(String.self, forKey: .feeDirection)
		interchangeFeeDetails = try values.decodeIfPresent([InterchangeFeeDetails].self, forKey: .interchangeFeeDetails)
	}

}