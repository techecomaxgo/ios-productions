/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct BillerResponse : Codable {
	let billId : String?
	let amount : String?
	let billDate : String?
	let billNumber : String?
	let billPeriod : String?
	let custConvFee : String?
	let couCustConvFee : String?
	let dueDate : String?
	let customerName : String?
	let amountOption : Bool?
	let tagList : String?

	enum CodingKeys: String, CodingKey {

		case billId = "billId"
		case amount = "amount"
		case billDate = "billDate"
		case billNumber = "billNumber"
		case billPeriod = "billPeriod"
		case custConvFee = "custConvFee"
		case couCustConvFee = "couCustConvFee"
		case dueDate = "dueDate"
		case customerName = "customerName"
		case amountOption = "amountOption"
		case tagList = "tagList"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		billId = try values.decodeIfPresent(String.self, forKey: .billId)
		amount = try values.decodeIfPresent(String.self, forKey: .amount)
		billDate = try values.decodeIfPresent(String.self, forKey: .billDate)
		billNumber = try values.decodeIfPresent(String.self, forKey: .billNumber)
		billPeriod = try values.decodeIfPresent(String.self, forKey: .billPeriod)
		custConvFee = try values.decodeIfPresent(String.self, forKey: .custConvFee)
		couCustConvFee = try values.decodeIfPresent(String.self, forKey: .couCustConvFee)
		dueDate = try values.decodeIfPresent(String.self, forKey: .dueDate)
		customerName = try values.decodeIfPresent(String.self, forKey: .customerName)
		amountOption = try values.decodeIfPresent(Bool.self, forKey: .amountOption)
		tagList = try values.decodeIfPresent(String.self, forKey: .tagList)
	}

}