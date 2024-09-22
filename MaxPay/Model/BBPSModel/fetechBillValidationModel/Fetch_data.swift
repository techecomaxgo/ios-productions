/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Fetch_data : Codable {
	let genericResponse : GenericResponse?
	let billId : String?
	let refId : String?
	let billerId : String?
	let status : String?
	let actionType : String?
	let userId : String?
	let billerResponse : BillerResponse?
	let additionalInfo : [AdditionalInfo]?
	let customerParams : [CustomerParams]?
	let creationDate : String?
	let modifiedDate : String?
	let createdEpochDate : Int?
	let modifiedEpochDate : Int?
	let billerResponseList : String?

	enum CodingKeys: String, CodingKey {

		case genericResponse = "genericResponse"
		case billId = "billId"
		case refId = "refId"
		case billerId = "billerId"
		case status = "status"
		case actionType = "actionType"
		case userId = "userId"
		case billerResponse = "billerResponse"
		case additionalInfo = "additionalInfo"
		case customerParams = "customerParams"
		case creationDate = "creationDate"
		case modifiedDate = "modifiedDate"
		case createdEpochDate = "createdEpochDate"
		case modifiedEpochDate = "modifiedEpochDate"
		case billerResponseList = "billerResponseList"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		genericResponse = try values.decodeIfPresent(GenericResponse.self, forKey: .genericResponse)
		billId = try values.decodeIfPresent(String.self, forKey: .billId)
		refId = try values.decodeIfPresent(String.self, forKey: .refId)
		billerId = try values.decodeIfPresent(String.self, forKey: .billerId)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		actionType = try values.decodeIfPresent(String.self, forKey: .actionType)
		userId = try values.decodeIfPresent(String.self, forKey: .userId)
		billerResponse = try values.decodeIfPresent(BillerResponse.self, forKey: .billerResponse)
		additionalInfo = try values.decodeIfPresent([AdditionalInfo].self, forKey: .additionalInfo)
		customerParams = try values.decodeIfPresent([CustomerParams].self, forKey: .customerParams)
		creationDate = try values.decodeIfPresent(String.self, forKey: .creationDate)
		modifiedDate = try values.decodeIfPresent(String.self, forKey: .modifiedDate)
		createdEpochDate = try values.decodeIfPresent(Int.self, forKey: .createdEpochDate)
		modifiedEpochDate = try values.decodeIfPresent(Int.self, forKey: .modifiedEpochDate)
		billerResponseList = try values.decodeIfPresent(String.self, forKey: .billerResponseList)
	}

}