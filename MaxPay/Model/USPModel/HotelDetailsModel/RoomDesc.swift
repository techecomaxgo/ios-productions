
import Foundation

struct RoomDesc : Codable {
    let amenity : [String]?
    let desc : String?
    let iD : String?

    enum CodingKeys: String, CodingKey {

        case amenity = "Amenity"
        case desc = "Desc"
        case iD = "ID"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amenity = try values.decodeIfPresent([String].self, forKey: .amenity)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        iD = try values.decodeIfPresent(String.self, forKey: .iD)
    }

}
