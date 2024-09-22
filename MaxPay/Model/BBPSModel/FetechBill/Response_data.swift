/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Response_data : Codable {
	let billerId : String?
	let billerName : String?
	let billerAliasName : String?
	let billerCategoryName : String?
	let billerMode : String?
//	let billerAcceptsAdhoc : Bool?
//	let parentBiller : Bool?
//	let parentBillerId : String?
//	let billerOwnerShp : String?
//	let billerCoverage : String?
	let fetchRequirement : String?
	let paymentAmountExactness : String?
	let supportBillValidation : String?
//	let billerEffctvFrom : String?
//	let billerEffctvTo : String?
//	let billerTempDeactivationStart : String?
//	let billerTempDeactivationEnd : String?
//	let billerPaymentModes : [BillerPaymentModes]?
//	let billerPaymentChannels : [BillerPaymentChannels]?
//	let billerCustomerParams : [BillerCustomerParams]?
//	let customerParamGroups : CustomerParamGroups?
//	let billerResponseParams : BillerResponseParams?
//	let billerAdditionalInfos : [BillerAdditionalInfos]?
//	let billerAdditionalInfoPayments : [String]?
//	let interchangeFeeConves : [String]?
//	let interchangeFees : [InterchangeFees]?
//	let status : String?
//	let billerDescription : String?
//	let supportDeemed : String?
//	let supportPendingStatus : String?
//	let billerTimeOut : String?
//	let routeUrl : String?
//	let billerResponseType : String?
//	let billerPlanResponseParams : BillerPlanResponseParams?
//	let planMDMRequirement : String?
//	let planAdditionalInfos : [String]?

	enum CodingKeys: String, CodingKey {

		case billerId = "billerId"
		case billerName = "billerName"
		case billerAliasName = "billerAliasName"
		case billerCategoryName = "billerCategoryName"
		case billerMode = "billerMode"
//		case billerAcceptsAdhoc = "billerAcceptsAdhoc"
//		case parentBiller = "parentBiller"
//		case parentBillerId = "parentBillerId"
//		case billerOwnerShp = "billerOwnerShp"
//		case billerCoverage = "billerCoverage"
		case fetchRequirement = "fetchRequirement"
		case paymentAmountExactness = "paymentAmountExactness"
		case supportBillValidation = "supportBillValidation"
//		case billerEffctvFrom = "billerEffctvFrom"
//		case billerEffctvTo = "billerEffctvTo"
//		case billerTempDeactivationStart = "billerTempDeactivationStart"
//		case billerTempDeactivationEnd = "billerTempDeactivationEnd"
//		case billerPaymentModes = "billerPaymentModes"
//		case billerPaymentChannels = "billerPaymentChannels"
//		case billerCustomerParams = "billerCustomerParams"
//		case customerParamGroups = "customerParamGroups"
//		case billerResponseParams = "billerResponseParams"
//		case billerAdditionalInfos = "billerAdditionalInfos"
//		case billerAdditionalInfoPayments = "billerAdditionalInfoPayments"
//		case interchangeFeeConves = "interchangeFeeConves"
//		case interchangeFees = "interchangeFees"
//		case status = "status"
//		case billerDescription = "billerDescription"
//		case supportDeemed = "supportDeemed"
//		case supportPendingStatus = "supportPendingStatus"
//		case billerTimeOut = "billerTimeOut"
//		case routeUrl = "routeUrl"
//		case billerResponseType = "billerResponseType"
//		case billerPlanResponseParams = "billerPlanResponseParams"
//		case planMDMRequirement = "planMDMRequirement"
//		case planAdditionalInfos = "planAdditionalInfos"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		billerId = try values.decodeIfPresent(String.self, forKey: .billerId)
		billerName = try values.decodeIfPresent(String.self, forKey: .billerName)
		billerAliasName = try values.decodeIfPresent(String.self, forKey: .billerAliasName)
		billerCategoryName = try values.decodeIfPresent(String.self, forKey: .billerCategoryName)
		billerMode = try values.decodeIfPresent(String.self, forKey: .billerMode)
//		billerAcceptsAdhoc = try values.decodeIfPresent(Bool.self, forKey: .billerAcceptsAdhoc)
//		parentBiller = try values.decodeIfPresent(Bool.self, forKey: .parentBiller)
//		parentBillerId = try values.decodeIfPresent(String.self, forKey: .parentBillerId)
//		billerOwnerShp = try values.decodeIfPresent(String.self, forKey: .billerOwnerShp)
//		billerCoverage = try values.decodeIfPresent(String.self, forKey: .billerCoverage)
		fetchRequirement = try values.decodeIfPresent(String.self, forKey: .fetchRequirement)
		paymentAmountExactness = try values.decodeIfPresent(String.self, forKey: .paymentAmountExactness)
		supportBillValidation = try values.decodeIfPresent(String.self, forKey: .supportBillValidation)
//		billerEffctvFrom = try values.decodeIfPresent(String.self, forKey: .billerEffctvFrom)
//		billerEffctvTo = try values.decodeIfPresent(String.self, forKey: .billerEffctvTo)
//		billerTempDeactivationStart = try values.decodeIfPresent(String.self, forKey: .billerTempDeactivationStart)
//		billerTempDeactivationEnd = try values.decodeIfPresent(String.self, forKey: .billerTempDeactivationEnd)
//		billerPaymentModes = try values.decodeIfPresent([BillerPaymentModes].self, forKey: .billerPaymentModes)
//		billerPaymentChannels = try values.decodeIfPresent([BillerPaymentChannels].self, forKey: .billerPaymentChannels)
//		billerCustomerParams = try values.decodeIfPresent([BillerCustomerParams].self, forKey: .billerCustomerParams)
//		customerParamGroups = try values.decodeIfPresent(CustomerParamGroups.self, forKey: .customerParamGroups)
//		billerResponseParams = try values.decodeIfPresent(BillerResponseParams.self, forKey: .billerResponseParams)
//		billerAdditionalInfos = try values.decodeIfPresent([BillerAdditionalInfos].self, forKey: .billerAdditionalInfos)
//		billerAdditionalInfoPayments = try values.decodeIfPresent([String].self, forKey: .billerAdditionalInfoPayments)
//		interchangeFeeConves = try values.decodeIfPresent([String].self, forKey: .interchangeFeeConves)
//		interchangeFees = try values.decodeIfPresent([InterchangeFees].self, forKey: .interchangeFees)
//		status = try values.decodeIfPresent(String.self, forKey: .status)
//		billerDescription = try values.decodeIfPresent(String.self, forKey: .billerDescription)
//		supportDeemed = try values.decodeIfPresent(String.self, forKey: .supportDeemed)
//		supportPendingStatus = try values.decodeIfPresent(String.self, forKey: .supportPendingStatus)
//		billerTimeOut = try values.decodeIfPresent(String.self, forKey: .billerTimeOut)
//		routeUrl = try values.decodeIfPresent(String.self, forKey: .routeUrl)
//		billerResponseType = try values.decodeIfPresent(String.self, forKey: .billerResponseType)
//		billerPlanResponseParams = try values.decodeIfPresent(BillerPlanResponseParams.self, forKey: .billerPlanResponseParams)
//		planMDMRequirement = try values.decodeIfPresent(String.self, forKey: .planMDMRequirement)
//		planAdditionalInfos = try values.decodeIfPresent([String].self, forKey: .planAdditionalInfos)
	}

}
