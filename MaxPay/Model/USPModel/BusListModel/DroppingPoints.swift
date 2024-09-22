/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct DroppingPoints : Codable {
	let dpId : String?
	let dpName : String?
	let locatoin : String?
	let prime : String?
	let dpTime : String?
	let contactNumber : String?

	enum CodingKeys: String, CodingKey {

		case dpId = "dpId"
		case dpName = "dpName"
		case locatoin = "locatoin"
		case prime = "prime"
		case dpTime = "dpTime"
		case contactNumber = "contactNumber"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		dpId = try values.decodeIfPresent(String.self, forKey: .dpId)
		dpName = try values.decodeIfPresent(String.self, forKey: .dpName)
		locatoin = try values.decodeIfPresent(String.self, forKey: .locatoin)
		prime = try values.decodeIfPresent(String.self, forKey: .prime)
		dpTime = try values.decodeIfPresent(String.self, forKey: .dpTime)
		contactNumber = try values.decodeIfPresent(String.self, forKey: .contactNumber)
	}

}