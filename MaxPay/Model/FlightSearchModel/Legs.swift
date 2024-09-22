

import Foundation

struct Legs : Codable {
	let aircraftCode : String?
	let aircraftType : String?
	let airlineName : String?
	let airlinePnr : String?
	let arrivalDate : String?
	let arrivalTerminal : String?
	let arrivalTime : String?
	let availableSeat : String?
	let baggageUnit : String?
	let baggageWeight : String?
	let bookSeat : String?
	let boundType : String?
	let cabin : String?
	let cabinBagUT : String?
	let cabinBagWT : String?
	let cabinClasses : String?
	let capacity : Int?
	let carrierCode : String?
	let currencyCode : String?
	let departureDate : String?
	let departureTerminal : String?
	let departureTime : String?
	let destination : String?
	let duration : String?
	let fareBasisCode : String?
	let fareClassOfService : String?
	let fareRulesKey : String?
	let flightDesignator : String?
	let flightDetailRefKey : String?
	let flightName : String?
	let flightNumber : String?
	let gDSPnr : String?
	let group : String?
	let isConnecting : Bool?
	let isSeatOpen : Bool?
	let layoverArrDT : String?
	let layoverAt : String?
	let layoverDepDT : String?
	let layoverDuration : String?
	let numberOfStops : String?
	let openSegment : Bool?
	let operatedBy : String?
	let origin : String?
	let providerCode : String?
	let remarks : String?
	let sSRDetails : String?
	let sold : Int?
	let status : String?

	enum CodingKeys: String, CodingKey {

		case aircraftCode = "AircraftCode"
		case aircraftType = "AircraftType"
		case airlineName = "AirlineName"
		case airlinePnr = "AirlinePnr"
		case arrivalDate = "ArrivalDate"
		case arrivalTerminal = "ArrivalTerminal"
		case arrivalTime = "ArrivalTime"
		case availableSeat = "AvailableSeat"
		case baggageUnit = "BaggageUnit"
		case baggageWeight = "BaggageWeight"
		case bookSeat = "BookSeat"
		case boundType = "BoundType"
		case cabin = "Cabin"
		case cabinBagUT = "CabinBagUT"
		case cabinBagWT = "CabinBagWT"
		case cabinClasses = "CabinClasses"
		case capacity = "Capacity"
		case carrierCode = "CarrierCode"
		case currencyCode = "CurrencyCode"
		case departureDate = "DepartureDate"
		case departureTerminal = "DepartureTerminal"
		case departureTime = "DepartureTime"
		case destination = "Destination"
		case duration = "Duration"
		case fareBasisCode = "FareBasisCode"
		case fareClassOfService = "FareClassOfService"
		case fareRulesKey = "FareRulesKey"
		case flightDesignator = "FlightDesignator"
		case flightDetailRefKey = "FlightDetailRefKey"
		case flightName = "FlightName"
		case flightNumber = "FlightNumber"
		case gDSPnr = "GDSPnr"
		case group = "Group"
		case isConnecting = "IsConnecting"
		case isSeatOpen = "IsSeatOpen"
		case layoverArrDT = "LayoverArrDT"
		case layoverAt = "LayoverAt"
		case layoverDepDT = "LayoverDepDT"
		case layoverDuration = "LayoverDuration"
		case numberOfStops = "NumberOfStops"
		case openSegment = "OpenSegment"
		case operatedBy = "OperatedBy"
		case origin = "Origin"
		case providerCode = "ProviderCode"
		case remarks = "Remarks"
		case sSRDetails = "SSRDetails"
		case sold = "Sold"
		case status = "Status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		aircraftCode = try values.decodeIfPresent(String.self, forKey: .aircraftCode)
		aircraftType = try values.decodeIfPresent(String.self, forKey: .aircraftType)
		airlineName = try values.decodeIfPresent(String.self, forKey: .airlineName)
		airlinePnr = try values.decodeIfPresent(String.self, forKey: .airlinePnr)
		arrivalDate = try values.decodeIfPresent(String.self, forKey: .arrivalDate)
		arrivalTerminal = try values.decodeIfPresent(String.self, forKey: .arrivalTerminal)
		arrivalTime = try values.decodeIfPresent(String.self, forKey: .arrivalTime)
		availableSeat = try values.decodeIfPresent(String.self, forKey: .availableSeat)
		baggageUnit = try values.decodeIfPresent(String.self, forKey: .baggageUnit)
		baggageWeight = try values.decodeIfPresent(String.self, forKey: .baggageWeight)
		bookSeat = try values.decodeIfPresent(String.self, forKey: .bookSeat)
		boundType = try values.decodeIfPresent(String.self, forKey: .boundType)
		cabin = try values.decodeIfPresent(String.self, forKey: .cabin)
		cabinBagUT = try values.decodeIfPresent(String.self, forKey: .cabinBagUT)
		cabinBagWT = try values.decodeIfPresent(String.self, forKey: .cabinBagWT)
		cabinClasses = try values.decodeIfPresent(String.self, forKey: .cabinClasses)
		capacity = try values.decodeIfPresent(Int.self, forKey: .capacity)
		carrierCode = try values.decodeIfPresent(String.self, forKey: .carrierCode)
		currencyCode = try values.decodeIfPresent(String.self, forKey: .currencyCode)
		departureDate = try values.decodeIfPresent(String.self, forKey: .departureDate)
		departureTerminal = try values.decodeIfPresent(String.self, forKey: .departureTerminal)
		departureTime = try values.decodeIfPresent(String.self, forKey: .departureTime)
		destination = try values.decodeIfPresent(String.self, forKey: .destination)
		duration = try values.decodeIfPresent(String.self, forKey: .duration)
		fareBasisCode = try values.decodeIfPresent(String.self, forKey: .fareBasisCode)
		fareClassOfService = try values.decodeIfPresent(String.self, forKey: .fareClassOfService)
		fareRulesKey = try values.decodeIfPresent(String.self, forKey: .fareRulesKey)
		flightDesignator = try values.decodeIfPresent(String.self, forKey: .flightDesignator)
		flightDetailRefKey = try values.decodeIfPresent(String.self, forKey: .flightDetailRefKey)
		flightName = try values.decodeIfPresent(String.self, forKey: .flightName)
		flightNumber = try values.decodeIfPresent(String.self, forKey: .flightNumber)
		gDSPnr = try values.decodeIfPresent(String.self, forKey: .gDSPnr)
		group = try values.decodeIfPresent(String.self, forKey: .group)
		isConnecting = try values.decodeIfPresent(Bool.self, forKey: .isConnecting)
		isSeatOpen = try values.decodeIfPresent(Bool.self, forKey: .isSeatOpen)
		layoverArrDT = try values.decodeIfPresent(String.self, forKey: .layoverArrDT)
		layoverAt = try values.decodeIfPresent(String.self, forKey: .layoverAt)
		layoverDepDT = try values.decodeIfPresent(String.self, forKey: .layoverDepDT)
		layoverDuration = try values.decodeIfPresent(String.self, forKey: .layoverDuration)
		numberOfStops = try values.decodeIfPresent(String.self, forKey: .numberOfStops)
		openSegment = try values.decodeIfPresent(Bool.self, forKey: .openSegment)
		operatedBy = try values.decodeIfPresent(String.self, forKey: .operatedBy)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		providerCode = try values.decodeIfPresent(String.self, forKey: .providerCode)
		remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
		sSRDetails = try values.decodeIfPresent(String.self, forKey: .sSRDetails)
		sold = try values.decodeIfPresent(Int.self, forKey: .sold)
		status = try values.decodeIfPresent(String.self, forKey: .status)
	}

}
