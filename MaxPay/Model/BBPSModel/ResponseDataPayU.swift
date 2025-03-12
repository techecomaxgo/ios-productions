import Foundation

struct ResponseDataPayU: Codable {
    let billers: [Biller]?
    let status: String?
    let total: Int?

    struct Biller: Codable {
        let billPayType: String?
        let billerId: String?
        let billerName: String?
        let blrAdditionalInfo: [BlrAdditionalInfo]?
        let category: String?
        let customerParams: [CustomerParam]?
        let flowType: String?
        let isAdhoc: Bool?
        let region: String?
        let regionCode: String?
        let state: String?
        let paymentAmountExactness: String?

        struct BlrAdditionalInfo: Codable {
            let dataType: String?
            let optional: Bool?
            let paramName: String?
        }

        struct CustomerParam: Codable {
            let dataType: String?
            let maxLength: Int?
            let minLength: Int?
            let optional: Bool?
            let paramName: String?
            let visibility: Bool?
            let regex: String?
        }
    }

    // Custom Decoding Logic to handle dynamic and missing keys
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode optional properties that may be missing or null in the response
        status = try container.decodeIfPresent(String.self, forKey: .status)
        total = try container.decodeIfPresent(Int.self, forKey: .total)
        billers = try container.decodeIfPresent([Biller].self, forKey: .billers)
    }
}

