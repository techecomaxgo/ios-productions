/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Lower : Codable {
	let firstColumn : [FirstColumn]?
	let secondColumn : [String]?
	let thirdColumn : [ThirdColumn]?
	let fourthColumn : [FourthColumn]?
	let fifthColumn : [FifthColumn]?
	let sixthColumn : [SixthColumn]?
	let seventhColumn : [SeventhColumn]?
	let eightColumn : [EightColumn]?
	let ninethColumn : [NinethColumn]?
	let tenthColumn : [String]?
	let eleventhColumn : [EleventhColumn]?
	let tevelthColumn : [TevelthColumn]?
	let thirteenColumn : [String]?
	let fourteenColumn : String?

	enum CodingKeys: String, CodingKey {

		case firstColumn = "firstColumn"
		case secondColumn = "SecondColumn"
		case thirdColumn = "ThirdColumn"
		case fourthColumn = "FourthColumn"
		case fifthColumn = "FifthColumn"
		case sixthColumn = "SixthColumn"
		case seventhColumn = "seventhColumn"
		case eightColumn = "eightColumn"
		case ninethColumn = "ninethColumn"
		case tenthColumn = "tenthColumn"
		case eleventhColumn = "eleventhColumn"
		case tevelthColumn = "tevelthColumn"
		case thirteenColumn = "thirteenColumn"
		case fourteenColumn = "fourteenColumn"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		firstColumn = try values.decodeIfPresent([FirstColumn].self, forKey: .firstColumn)
		secondColumn = try values.decodeIfPresent([String].self, forKey: .secondColumn)
		thirdColumn = try values.decodeIfPresent([ThirdColumn].self, forKey: .thirdColumn)
		fourthColumn = try values.decodeIfPresent([FourthColumn].self, forKey: .fourthColumn)
		fifthColumn = try values.decodeIfPresent([FifthColumn].self, forKey: .fifthColumn)
		sixthColumn = try values.decodeIfPresent([SixthColumn].self, forKey: .sixthColumn)
		seventhColumn = try values.decodeIfPresent([SeventhColumn].self, forKey: .seventhColumn)
		eightColumn = try values.decodeIfPresent([EightColumn].self, forKey: .eightColumn)
		ninethColumn = try values.decodeIfPresent([NinethColumn].self, forKey: .ninethColumn)
		tenthColumn = try values.decodeIfPresent([String].self, forKey: .tenthColumn)
		eleventhColumn = try values.decodeIfPresent([EleventhColumn].self, forKey: .eleventhColumn)
		tevelthColumn = try values.decodeIfPresent([TevelthColumn].self, forKey: .tevelthColumn)
		thirteenColumn = try values.decodeIfPresent([String].self, forKey: .thirteenColumn)
		fourteenColumn = try values.decodeIfPresent(String.self, forKey: .fourteenColumn)
	}

}