/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct DataBusRevieweModel : Codable {
	let error : String?
	let isTransactionCreated : Bool?
	let transactionScreenId : String?
    let transactionid : String?
    let validFor : String?
	let totalAmount : Double?
    let discount: Double?

	enum CodingKeys: String, CodingKey {

		case error = "error"
		case isTransactionCreated = "isTransactionCreated"
		case transactionScreenId = "transactionScreenId"
        case transactionid = "transactionid"
		case totalAmount = "totalAmount"
        case validFor = "validFor"
        case discount = "discount"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		error = try values.decodeIfPresent(String.self, forKey: .error)
		isTransactionCreated = try values.decodeIfPresent(Bool.self, forKey: .isTransactionCreated)
		transactionScreenId = try values.decodeIfPresent(String.self, forKey: .transactionScreenId)
        transactionid = try values.decodeIfPresent(String.self, forKey: .transactionid)
		totalAmount = try values.decodeIfPresent(Double.self, forKey: .totalAmount)
        validFor = try values.decodeIfPresent(String.self, forKey: .validFor)
        discount = try values.decodeIfPresent(Double.self, forKey: .discount)
	}

}


struct DataBusBookModel : Codable {
    let ticketpnr : String?
    let operator_pnr : String?
    let isticket : Bool?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case ticketpnr = "ticketpnr"
        case operator_pnr = "operator_pnr"
        case isticket = "isticket"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ticketpnr = try values.decodeIfPresent(String.self, forKey: .ticketpnr)
        operator_pnr = try values.decodeIfPresent(String.self, forKey: .operator_pnr)
        isticket = try values.decodeIfPresent(Bool.self, forKey: .isticket)
        message = try values.decodeIfPresent(String.self, forKey: .message)
       
    }

}
