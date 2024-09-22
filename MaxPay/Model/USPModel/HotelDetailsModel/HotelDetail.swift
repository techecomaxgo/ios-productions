



import Foundation

struct HotelDetail : Codable {
    
    let bookingPolicy : String?
    let description : String?
    let hotelAmenitiesList : [HotelAmenitiesList]?
    let hotelHighlights : String?
    let hotelImagesDetail : [HotelImagesDetail]?
    let ratingViews : String?
    let roomAmenitiesList : [String]?
    let roomDesc : [RoomDesc]?
    let roomImageList : [RoomImageList]?
    let specialInstruction : String?
    let tripAdvisor : TripAdvisor?
    let _dictList : String?
    let address : String?
    let city : String?
    let country : String?
    let distanceSorting : String?
    let error : String?
    let hotelattraction : String?
    let lat : String?
    let lon : String?
    let nUrl : String?
    let name : String?
    let rating : String?
    let specialOffer : String?
    let vervoTechId : String?
    let zipcode : String?

    enum CodingKeys: String, CodingKey {

        case bookingPolicy = "BookingPolicy"
        case description = "Description"
        case hotelAmenitiesList = "HotelAmenitiesList"
        case hotelHighlights = "HotelHighlights"
        case hotelImagesDetail = "HotelImagesDetail"
        case ratingViews = "RatingViews"
        case roomAmenitiesList = "RoomAmenitiesList"
        case roomDesc = "RoomDesc"
        case roomImageList = "RoomImageList"
        case specialInstruction = "SpecialInstruction"
        case tripAdvisor = "TripAdvisor"
        case _dictList = "_dictList"
        case address = "address"
        case city = "city"
        case country = "country"
        case distanceSorting = "distanceSorting"
        case error = "error"
        case hotelattraction = "hotelattraction"
        case lat = "lat"
        case lon = "lon"
        case nUrl = "nUrl"
        case name = "name"
        case rating = "rating"
        case specialOffer = "specialOffer"
        case vervoTechId = "vervoTechId"
        case zipcode = "zipcode"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bookingPolicy = try values.decodeIfPresent(String.self, forKey: .bookingPolicy)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        hotelAmenitiesList = try values.decodeIfPresent([HotelAmenitiesList].self, forKey: .hotelAmenitiesList)
        hotelHighlights = try values.decodeIfPresent(String.self, forKey: .hotelHighlights)
        hotelImagesDetail = try values.decodeIfPresent([HotelImagesDetail].self, forKey: .hotelImagesDetail)
        ratingViews = try values.decodeIfPresent(String.self, forKey: .ratingViews)
        roomAmenitiesList = try values.decodeIfPresent([String].self, forKey: .roomAmenitiesList)
        roomDesc = try values.decodeIfPresent([RoomDesc].self, forKey: .roomDesc)
        roomImageList = try values.decodeIfPresent([RoomImageList].self, forKey: .roomImageList)
        specialInstruction = try values.decodeIfPresent(String.self, forKey: .specialInstruction)
        tripAdvisor = try values.decodeIfPresent(TripAdvisor.self, forKey: .tripAdvisor)
        _dictList = try values.decodeIfPresent(String.self, forKey: ._dictList)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        distanceSorting = try values.decodeIfPresent(String.self, forKey: .distanceSorting)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        hotelattraction = try values.decodeIfPresent(String.self, forKey: .hotelattraction)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        nUrl = try values.decodeIfPresent(String.self, forKey: .nUrl)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        specialOffer = try values.decodeIfPresent(String.self, forKey: .specialOffer)
        vervoTechId = try values.decodeIfPresent(String.self, forKey: .vervoTechId)
        zipcode = try values.decodeIfPresent(String.self, forKey: .zipcode)
    }

}
