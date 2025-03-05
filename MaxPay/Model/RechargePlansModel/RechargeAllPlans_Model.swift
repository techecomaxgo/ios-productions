import Foundation

struct RechargeAllPlans_Model: Codable {
    let status: String?
    let platformFee: Int?
    let token: String?
    let data: DataResponse?

    private enum CodingKeys: String, CodingKey {
        case status, platformFee, token, data
    }
}

struct DataResponse: Codable {
    let status: String?
    let circle: String?
    let error: String?
    let message: String?
    let operatorName: String?
    let plans: [String: [Plan]]?
    //let plans: PlansCategory?

    enum CodingKeys: String, CodingKey {
        case status, circle, error, message, plans
        case operatorName = "operator"
    }
}

struct PlansCategory: Codable {
    let fullTT: [Plan]?
    let romaing: [Plan]?
    let topup: [Plan]?

    enum CodingKeys: String, CodingKey {
        case fullTT = "FULLTT "
        case romaing = "Romaing"
        case topup = "TOPUP"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: DynamicCodingKeys.self)

        // Handle dynamic keys for fullTT, romaing, and topup
        var fullTTPlans: [Plan]? = nil
        let fullTTKeys = ["FULLTT", "FULLTT "]

        for key in fullTTKeys {
            if let plans = try? values.decode([Plan].self, forKey: DynamicCodingKeys(stringValue: key)!) {
                fullTTPlans = plans
                break
            }
        }

        fullTT = fullTTPlans ?? []  // Assign an empty array if no plans found
        romaing = try? values.decode([Plan].self, forKey: DynamicCodingKeys(stringValue: "Romaing")!)  // Default to empty array
        topup = try? values.decode([Plan].self, forKey: DynamicCodingKeys(stringValue: "TOPUP")!) // Default to empty array
    }
}

struct Plan: Codable {
    let type: String?
    let desc: String?
    let rs: Int?
    let validity: String?

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case desc, rs, validity
    }
}

// MARK: - Dynamic Coding Key Handling
struct DynamicCodingKeys: CodingKey {
    var stringValue: String
    var intValue: Int? { return nil }

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        return nil
    }
}
