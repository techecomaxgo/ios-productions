//
//  CommanRoomTypeModel.swift
//  MaxPay
//
//  Created by Admin on 13/06/24.
//

import Foundation


struct CommanRoomTypeModel : Codable {
    let adult : Int?
    let amenity : String?
    let bedType : String?
    let bookingPolicy : String?
    let cancellationPolicy : String?
    let cashBack : String?
    let child : Int?
    let commission : String?
    let couponCode : String?
    let description : String?
    let eMTCommonId : String?
    let eMTFee : Double?
    let engine : Int?
    let hightRate : String?
    let hotelDiscount : Int?
    let hotelID : String?
    let id : Int?
    let isBreakFast : Bool?
    let isDefaultValue : Bool?
    let isHoldBooking : Bool?
    let markupValue : Int?
    let meal : String?
    let mealType : String?
    let nDFValue : Int?
    let nP : Int?
    let nT : Int?
    let offer : String?
    let payAtHotel : Bool?
    let price : Int?
    let recommended : Int?
    let salesTax : Int?
    let serviceFee : Int?
    let suppDetails : String?
    let totalPrice : Int?
    let withCC : Bool?
    let available_rooms : String?
    let bedid : String?
    let cdValue : Int?
    let cfValue : Int?
    let cnxPolicy : [CnxPolicy]?
    let currencyCode : String?
    let dfValue : Int?
    let diffValue : Int?
    let disc : Int?
    let promoDescription : String?
    let rateInfo : String?
    let rateKey : String?
    let ratePlanCode : String?
    let rm : String?
    let roomID : String?
    let roomImage : String?
    let roomRateDescription : String?
    let roomType : String?
    let roomTypeCode : String?
    let roomplanDescription : String?
    let surchargeTotal : Int?

    enum CodingKeys: String, CodingKey {

        case adult = "Adult"
        case amenity = "Amenity"
        case bedType = "BedType"
        case bookingPolicy = "BookingPolicy"
        case cancellationPolicy = "CancellationPolicy"
        case cashBack = "CashBack"
        case child = "Child"
        case commission = "Commission"
        case couponCode = "CouponCode"
        case description = "Description"
        case eMTCommonId = "EMTCommonId"
        case eMTFee = "EMTFee"
        case engine = "Engine"
        case hightRate = "HightRate"
        case hotelDiscount = "HotelDiscount"
        case hotelID = "HotelID"
        case id = "Id"
        case isBreakFast = "IsBreakFast"
        case isDefaultValue = "IsDefaultValue"
        case isHoldBooking = "IsHoldBooking"
        case markupValue = "MarkupValue"
        case meal = "Meal"
        case mealType = "MealType"
        case nDFValue = "NDFValue"
        case nP = "NP"
        case nT = "NT"
        case offer = "Offer"
        case payAtHotel = "PayAtHotel"
        case price = "Price"
        case recommended = "Recommended"
        case salesTax = "SalesTax"
        case serviceFee = "ServiceFee"
        case suppDetails = "SuppDetails"
        case totalPrice = "TotalPrice"
        case withCC = "WithCC"
        case available_rooms = "available_rooms"
        case bedid = "bedid"
        case cdValue = "cdValue"
        case cfValue = "cfValue"
        case cnxPolicy = "cnxPolicy"
        case currencyCode = "currencyCode"
        case dfValue = "dfValue"
        case diffValue = "diffValue"
        case disc = "disc"
        case promoDescription = "promoDescription"
        case rateInfo = "rateInfo"
        case rateKey = "rateKey"
        case ratePlanCode = "ratePlanCode"
        case rm = "rm"
        case roomID = "roomID"
        case roomImage = "roomImage"
        case roomRateDescription = "roomRateDescription"
        case roomType = "roomType"
        case roomTypeCode = "roomTypeCode"
        case roomplanDescription = "roomplanDescription"
        case surchargeTotal = "surchargeTotal"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decodeIfPresent(Int.self, forKey: .adult)
        amenity = try values.decodeIfPresent(String.self, forKey: .amenity)
        bedType = try values.decodeIfPresent(String.self, forKey: .bedType)
        bookingPolicy = try values.decodeIfPresent(String.self, forKey: .bookingPolicy)
        cancellationPolicy = try values.decodeIfPresent(String.self, forKey: .cancellationPolicy)
        cashBack = try values.decodeIfPresent(String.self, forKey: .cashBack)
        child = try values.decodeIfPresent(Int.self, forKey: .child)
        commission = try values.decodeIfPresent(String.self, forKey: .commission)
        couponCode = try values.decodeIfPresent(String.self, forKey: .couponCode)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        eMTCommonId = try values.decodeIfPresent(String.self, forKey: .eMTCommonId)
        eMTFee = try values.decodeIfPresent(Double.self, forKey: .eMTFee)
        engine = try values.decodeIfPresent(Int.self, forKey: .engine)
        hightRate = try values.decodeIfPresent(String.self, forKey: .hightRate)
        hotelDiscount = try values.decodeIfPresent(Int.self, forKey: .hotelDiscount)
        hotelID = try values.decodeIfPresent(String.self, forKey: .hotelID)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        isBreakFast = try values.decodeIfPresent(Bool.self, forKey: .isBreakFast)
        isDefaultValue = try values.decodeIfPresent(Bool.self, forKey: .isDefaultValue)
        isHoldBooking = try values.decodeIfPresent(Bool.self, forKey: .isHoldBooking)
        markupValue = try values.decodeIfPresent(Int.self, forKey: .markupValue)
        meal = try values.decodeIfPresent(String.self, forKey: .meal)
        mealType = try values.decodeIfPresent(String.self, forKey: .mealType)
        nDFValue = try values.decodeIfPresent(Int.self, forKey: .nDFValue)
        nP = try values.decodeIfPresent(Int.self, forKey: .nP)
        nT = try values.decodeIfPresent(Int.self, forKey: .nT)
        offer = try values.decodeIfPresent(String.self, forKey: .offer)
        payAtHotel = try values.decodeIfPresent(Bool.self, forKey: .payAtHotel)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        recommended = try values.decodeIfPresent(Int.self, forKey: .recommended)
        salesTax = try values.decodeIfPresent(Int.self, forKey: .salesTax)
        serviceFee = try values.decodeIfPresent(Int.self, forKey: .serviceFee)
        suppDetails = try values.decodeIfPresent(String.self, forKey: .suppDetails)
        totalPrice = try values.decodeIfPresent(Int.self, forKey: .totalPrice)
        withCC = try values.decodeIfPresent(Bool.self, forKey: .withCC)
        available_rooms = try values.decodeIfPresent(String.self, forKey: .available_rooms)
        bedid = try values.decodeIfPresent(String.self, forKey: .bedid)
        cdValue = try values.decodeIfPresent(Int.self, forKey: .cdValue)
        cfValue = try values.decodeIfPresent(Int.self, forKey: .cfValue)
        cnxPolicy = try values.decodeIfPresent([CnxPolicy].self, forKey: .cnxPolicy)
        currencyCode = try values.decodeIfPresent(String.self, forKey: .currencyCode)
        dfValue = try values.decodeIfPresent(Int.self, forKey: .dfValue)
        diffValue = try values.decodeIfPresent(Int.self, forKey: .diffValue)
        disc = try values.decodeIfPresent(Int.self, forKey: .disc)
        promoDescription = try values.decodeIfPresent(String.self, forKey: .promoDescription)
        rateInfo = try values.decodeIfPresent(String.self, forKey: .rateInfo)
        rateKey = try values.decodeIfPresent(String.self, forKey: .rateKey)
        ratePlanCode = try values.decodeIfPresent(String.self, forKey: .ratePlanCode)
        rm = try values.decodeIfPresent(String.self, forKey: .rm)
        roomID = try values.decodeIfPresent(String.self, forKey: .roomID)
        roomImage = try values.decodeIfPresent(String.self, forKey: .roomImage)
        roomRateDescription = try values.decodeIfPresent(String.self, forKey: .roomRateDescription)
        roomType = try values.decodeIfPresent(String.self, forKey: .roomType)
        roomTypeCode = try values.decodeIfPresent(String.self, forKey: .roomTypeCode)
        roomplanDescription = try values.decodeIfPresent(String.self, forKey: .roomplanDescription)
        surchargeTotal = try values.decodeIfPresent(Int.self, forKey: .surchargeTotal)
    }

}
