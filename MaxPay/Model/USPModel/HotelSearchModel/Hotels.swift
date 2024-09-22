

import Foundation



import Foundation
struct Hotels : Codable {
    let checkInDate : String?
    let checkOutDate : String?
    let error : String?
    let hotelCount : Int?
    let nights : Int?
    let searchKey : String?
    let timeSpan : String?
    let totalHotel : Int?
    let elapsedTime : Double?
    let hotellist : [Hotellist]?
    let htlPlcy : String?
    let insertedon : String?
    let ipaddress : String?
    let responsetime : String?
    let sessionID : String?
    let traceid : String?
    let username : String?
    let vid : String?

    enum CodingKeys: String, CodingKey {

        case checkInDate = "CheckInDate"
        case checkOutDate = "CheckOutDate"
        case error = "Error"
        case hotelCount = "HotelCount"
        case nights = "Nights"
        case searchKey = "SearchKey"
        case timeSpan = "TimeSpan"
        case totalHotel = "TotalHotel"
        case elapsedTime = "elapsedTime"
        case hotellist = "hotellist"
        case htlPlcy = "htlPlcy"
        case insertedon = "insertedon"
        case ipaddress = "ipaddress"
        case responsetime = "responsetime"
        case sessionID = "sessionID"
        case traceid = "traceid"
        case username = "username"
        case vid = "vid"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        checkInDate = try values.decodeIfPresent(String.self, forKey: .checkInDate)
        checkOutDate = try values.decodeIfPresent(String.self, forKey: .checkOutDate)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        hotelCount = try values.decodeIfPresent(Int.self, forKey: .hotelCount)
        nights = try values.decodeIfPresent(Int.self, forKey: .nights)
        searchKey = try values.decodeIfPresent(String.self, forKey: .searchKey)
        timeSpan = try values.decodeIfPresent(String.self, forKey: .timeSpan)
        totalHotel = try values.decodeIfPresent(Int.self, forKey: .totalHotel)
        elapsedTime = try values.decodeIfPresent(Double.self, forKey: .elapsedTime)
        hotellist = try values.decodeIfPresent([Hotellist].self, forKey: .hotellist)
        htlPlcy = try values.decodeIfPresent(String.self, forKey: .htlPlcy)
        insertedon = try values.decodeIfPresent(String.self, forKey: .insertedon)
        ipaddress = try values.decodeIfPresent(String.self, forKey: .ipaddress)
        responsetime = try values.decodeIfPresent(String.self, forKey: .responsetime)
        sessionID = try values.decodeIfPresent(String.self, forKey: .sessionID)
        traceid = try values.decodeIfPresent(String.self, forKey: .traceid)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        vid = try values.decodeIfPresent(String.self, forKey: .vid)
    }

}
