/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct BusListModel : Codable {
	let status : String?
	let message : String?
	//let buslist : Buslist?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		//case buslist = "buslist"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		//buslist = try values.decodeIfPresent(Buslist.self, forKey: .buslist)
	}

}

struct PreviousViewed: Codable {
    
    let origin: String?
    let destination: String?
    let journeyDate: String?
    let sourceID: Int?
    let destinationID: Int?
    
    enum CodingKeys: CodingKey {
        case origin
        case destination
        case journeyDate
        case sourceID
        case destinationID
    }
}

// wether

struct WeatherModel: Codable {
    let current: CurrentWeather?
    
    enum CodingKeys: String, CodingKey {
        case current = "current"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.current = try container.decodeIfPresent(CurrentWeather.self, forKey: .current)
    }
}

struct CurrentWeather: Codable {
    let condition: Condition?
    let tempC: Double?
    let tempF: Double?

    enum CodingKeys: String, CodingKey {
        case condition = "condition"
        case tempC = "temp_c"
        case tempF = "temp_f"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.condition = try container.decodeIfPresent(Condition.self, forKey: .condition)
        self.tempC = try container.decodeIfPresent(Double.self, forKey: .tempC)
        self.tempF = try container.decodeIfPresent(Double.self, forKey: .tempF)
    }
    
}

struct Condition: Codable {
    let code: Int?
    let icon: String?
    let text: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case icon = "icon"
        case text = "text"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decodeIfPresent(Int.self, forKey: .code)
        self.icon = try container.decodeIfPresent(String.self, forKey: .icon)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
    }
}


