/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Filtered_categories : Codable, Equatable {
	let categoryId : String?
	let categoryName : String?
	let categoryIcon : String?
	let categoryDomain : String?
	let buttonName : String?
	let textArea : String?
	let faqDetailsList : [FaqDetailsList]?

	enum CodingKeys: String, CodingKey {

		case categoryId = "categoryId"
		case categoryName = "categoryName"
		case categoryIcon = "categoryIcon"
		case categoryDomain = "categoryDomain"
		case buttonName = "buttonName"
		case textArea = "textArea"
		case faqDetailsList = "faqDetailsList"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
		categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
		categoryIcon = try values.decodeIfPresent(String.self, forKey: .categoryIcon)
		categoryDomain = try values.decodeIfPresent(String.self, forKey: .categoryDomain)
		buttonName = try values.decodeIfPresent(String.self, forKey: .buttonName)
		textArea = try values.decodeIfPresent(String.self, forKey: .textArea)
		faqDetailsList = try values.decodeIfPresent([FaqDetailsList].self, forKey: .faqDetailsList)
	}
    
    // Implement the '==' operator for Equatable conformance
    static func == (lhs: Filtered_categories, rhs: Filtered_categories) -> Bool {
        // Implement the logic for equality based on your class properties
        // For example, compare properties like ID, name, etc.
        return lhs.categoryId == rhs.categoryId
    }

}
