/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct FetechBillModel : Codable {
    
	let status : String?
    let message : String
	let response : FetchBillResponseModel?

	enum CodingKeys: String, CodingKey {
		case status = "status"
		case message, response
	}
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        message = try container.decode(String.self, forKey: .message)
        response = try container.decodeIfPresent(FetchBillResponseModel.self, forKey: .response)
    }

}

struct FetchBillResponseModel: Codable {
    
//    let additionalInfo: [String: String]
    let code: Int
    let couCustConvFee: Double
    let customerConvFee: Double
//    let customerParams: CustomerParams
    let payload: FetchBillResponsePayload
    let paymentAmountExactness: String
    let platformFee: Double
    let status: String
    
}

struct FetchBillResponsePayload: Codable {
    let accountHolderName: String?
    let additionalParams: FetchBillResponseAdditionalParams
    let amount: Double?
    let amountDetails: String?
    let approvalRefNum: String?
    let billDate: String?
    let billNumber: String?
    let billPeriod: String?
    let billerId: String?
    let dueDate: String?
    let refId: String?
    let requestTimeStamp: String?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accountHolderName = try container.decodeIfPresent(String.self, forKey: .accountHolderName)
        additionalParams = try container.decode(FetchBillResponseAdditionalParams.self, forKey: .additionalParams)
        amount = try container.decodeIfPresent(Double.self, forKey: .amount)
        amountDetails = try container.decodeIfPresent(String.self, forKey: .amountDetails)
        approvalRefNum = try container.decodeIfPresent(String.self, forKey: .approvalRefNum)
        billDate = try container.decodeIfPresent(String.self, forKey: .billDate)
        billNumber = try container.decodeIfPresent(String.self, forKey: .billNumber)
        billPeriod = try container.decodeIfPresent(String.self, forKey: .billPeriod)
        billerId = try container.decodeIfPresent(String.self, forKey: .billerId)
        dueDate = try container.decodeIfPresent(String.self, forKey: .dueDate)
        refId = try container.decodeIfPresent(String.self, forKey: .refId)
        requestTimeStamp = try container.decodeIfPresent(String.self, forKey: .requestTimeStamp)
    }
    
}

struct FetchBillResponseAdditionalParams: Codable {
    let availableBalance: String?
    let availableRechargeLimit: String?
    let status: String?
    let tagId: String?
    let vehicleClass: String?
    let vehicleClassDesc: String?
    
    let currentOutstanding: String?
    let minimumOutstanding: String?
    
    enum CodingKeys: String, CodingKey {
        case availableBalance = "Available Balance"
        case availableRechargeLimit = "Available Recharge Limit"
        case currentOutstanding = "Current Outstanding Amount"
        case minimumOutstanding = "Minimum Amount Due"
        case status
        case tagId
        case vehicleClass
        case vehicleClassDesc
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        availableBalance = try container.decodeIfPresent(String.self, forKey: .availableBalance)
        availableRechargeLimit = try container.decodeIfPresent(String.self, forKey: .availableRechargeLimit)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        tagId = try container.decodeIfPresent(String.self, forKey: .tagId)
        vehicleClass = try container.decodeIfPresent(String.self, forKey: .vehicleClass)
        vehicleClassDesc = try container.decodeIfPresent(String.self, forKey: .vehicleClassDesc)
        
        currentOutstanding = try container.decodeIfPresent(String.self, forKey: .currentOutstanding)
        minimumOutstanding = try container.decodeIfPresent(String.self, forKey: .minimumOutstanding)
    }
    
}
