

import Foundation
struct Hotellist : Codable {
    let availableRoom : [AvailableRoom]?
    let cashBack : String?
    let category : String?
    let chName : String?
    let checkInTime : String?
    let checkOutTime : String?
    let commission : String?
    let couponCode : String?
    let distance : String?
    let eMTCommonID : String?
    let engineType : Int?
    let hotelHighlights : String?
    let hotelURL : String?
    let imageThumbUrl : String?
    let inclusions : String?
    let isBreakFast : Bool?
    let isCached : Bool?
    let isDefaultValue : Bool?
    let isSafety : Bool?
    let location : String?
    let mostViewed : Bool?
    let mostViewedNo : Int?
    let promoDescription : String?
    let recommended : Int?
    let suppDetails : String?
    let totalPrice : Int?
    let address : String?
    let cdValue : Int?
    let city : String?
    let countryCode : String?
    let currencyCode : String?
    let dfValue : Int?
    let diffValue : Int?
    let hdiscount : Int?
    let hotelID : String?
    let hotelName : String?
    let htlPlcy : String?
    let latitude : String?
    let longtitude : String?
    let nUrl : String?
    let nidhiRating : String?
    let plcy : String?
    let price : Int?
    let ranking : String?
    let rankingoutof : String?
    let rating : String?
    let surchargeTotal : Int?
    var tripAdvisorRating : Int?
    let tripAdvisorRatingUrl : String?
    let tripAdvisorReviewCount : Int?
    let tripAdvisorReviewUrl : String?
    let tripType : String?
    let tripid : String?

    enum CodingKeys: String, CodingKey {

        case availableRoom = "AvailableRoom"
        case cashBack = "CashBack"
        case category = "Category"
        case chName = "ChName"
        case checkInTime = "CheckInTime"
        case checkOutTime = "CheckOutTime"
        case commission = "Commission"
        case couponCode = "CouponCode"
        case distance = "Distance"
        case eMTCommonID = "EMTCommonID"
        case engineType = "EngineType"
        case hotelHighlights = "HotelHighlights"
        case hotelURL = "HotelURL"
        case imageThumbUrl = "ImageThumbUrl"
        case inclusions = "Inclusions"
        case isBreakFast = "IsBreakFast"
        case isCached = "IsCached"
        case isDefaultValue = "IsDefaultValue"
        case isSafety = "IsSafety"
        case location = "Location"
        case mostViewed = "MostViewed"
        case mostViewedNo = "MostViewedNo"
        case promoDescription = "PromoDescription"
        case recommended = "Recommended"
        case suppDetails = "SuppDetails"
        case totalPrice = "TotalPrice"
        case address = "address"
        case cdValue = "cdValue"
        case city = "city"
        case countryCode = "countryCode"
        case currencyCode = "currencyCode"
        case dfValue = "dfValue"
        case diffValue = "diffValue"
        case hdiscount = "hdiscount"
        case hotelID = "hotelID"
        case hotelName = "hotelName"
        case htlPlcy = "htlPlcy"
        case latitude = "latitude"
        case longtitude = "longtitude"
        case nUrl = "nUrl"
        case nidhiRating = "nidhiRating"
        case plcy = "plcy"
        case price = "price"
        case ranking = "ranking"
        case rankingoutof = "rankingoutof"
        case rating = "rating"
        case surchargeTotal = "surchargeTotal"
        case tripAdvisorRating = "tripAdvisorRating"
        case tripAdvisorRatingUrl = "tripAdvisorRatingUrl"
        case tripAdvisorReviewCount = "tripAdvisorReviewCount"
        case tripAdvisorReviewUrl = "tripAdvisorReviewUrl"
        case tripType = "tripType"
        case tripid = "tripid"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        availableRoom = try values.decodeIfPresent([AvailableRoom].self, forKey: .availableRoom)
        cashBack = try values.decodeIfPresent(String.self, forKey: .cashBack)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        chName = try values.decodeIfPresent(String.self, forKey: .chName)
        checkInTime = try values.decodeIfPresent(String.self, forKey: .checkInTime)
        checkOutTime = try values.decodeIfPresent(String.self, forKey: .checkOutTime)
        commission = try values.decodeIfPresent(String.self, forKey: .commission)
        couponCode = try values.decodeIfPresent(String.self, forKey: .couponCode)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
        eMTCommonID = try values.decodeIfPresent(String.self, forKey: .eMTCommonID)
        engineType = try values.decodeIfPresent(Int.self, forKey: .engineType)
        hotelHighlights = try values.decodeIfPresent(String.self, forKey: .hotelHighlights)
        hotelURL = try values.decodeIfPresent(String.self, forKey: .hotelURL)
        imageThumbUrl = try values.decodeIfPresent(String.self, forKey: .imageThumbUrl)
        inclusions = try values.decodeIfPresent(String.self, forKey: .inclusions)
        isBreakFast = try values.decodeIfPresent(Bool.self, forKey: .isBreakFast)
        isCached = try values.decodeIfPresent(Bool.self, forKey: .isCached)
        isDefaultValue = try values.decodeIfPresent(Bool.self, forKey: .isDefaultValue)
        isSafety = try values.decodeIfPresent(Bool.self, forKey: .isSafety)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        mostViewed = try values.decodeIfPresent(Bool.self, forKey: .mostViewed)
        mostViewedNo = try values.decodeIfPresent(Int.self, forKey: .mostViewedNo)
        promoDescription = try values.decodeIfPresent(String.self, forKey: .promoDescription)
        recommended = try values.decodeIfPresent(Int.self, forKey: .recommended)
        suppDetails = try values.decodeIfPresent(String.self, forKey: .suppDetails)
        totalPrice = try values.decodeIfPresent(Int.self, forKey: .totalPrice)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        cdValue = try values.decodeIfPresent(Int.self, forKey: .cdValue)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        currencyCode = try values.decodeIfPresent(String.self, forKey: .currencyCode)
        dfValue = try values.decodeIfPresent(Int.self, forKey: .dfValue)
        diffValue = try values.decodeIfPresent(Int.self, forKey: .diffValue)
        hdiscount = try values.decodeIfPresent(Int.self, forKey: .hdiscount)
        hotelID = try values.decodeIfPresent(String.self, forKey: .hotelID)
        hotelName = try values.decodeIfPresent(String.self, forKey: .hotelName)
        htlPlcy = try values.decodeIfPresent(String.self, forKey: .htlPlcy)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longtitude = try values.decodeIfPresent(String.self, forKey: .longtitude)
        nUrl = try values.decodeIfPresent(String.self, forKey: .nUrl)
        nidhiRating = try values.decodeIfPresent(String.self, forKey: .nidhiRating)
        plcy = try values.decodeIfPresent(String.self, forKey: .plcy)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        ranking = try values.decodeIfPresent(String.self, forKey: .ranking)
        rankingoutof = try values.decodeIfPresent(String.self, forKey: .rankingoutof)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        surchargeTotal = try values.decodeIfPresent(Int.self, forKey: .surchargeTotal)
        
        tripAdvisorRating = try values.decodeIfPresent(Int.self, forKey: .tripAdvisorRating)
        
        if let Value =  try values.decodeIfPresent(Float.self, forKey: .tripAdvisorRating){
            
            tripAdvisorRating = Int(Value)
        }else{
            
            tripAdvisorRating =  try values.decodeIfPresent(Int.self, forKey: .tripAdvisorRating)
            
        }
        
        tripAdvisorRatingUrl = try values.decodeIfPresent(String.self, forKey: .tripAdvisorRatingUrl)
        tripAdvisorReviewCount = try values.decodeIfPresent(Int.self, forKey: .tripAdvisorReviewCount)
        tripAdvisorReviewUrl = try values.decodeIfPresent(String.self, forKey: .tripAdvisorReviewUrl)
        tripType = try values.decodeIfPresent(String.self, forKey: .tripType)
        tripid = try values.decodeIfPresent(String.self, forKey: .tripid)
    }

}

