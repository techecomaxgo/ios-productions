import Foundation

struct ResponseDataPayU: Codable {
    let billers: [Biller]
    let status: String
    let total: Int

    struct Biller: Codable {
        let billPayType: String
        let billerId: String
        let billerName: String
        let blrAdditionalInfo: [BlrAdditionalInfo]
        let category: String
        let customerParams: [CustomerParam]
        let flowType: String
        let isAdhoc: Bool
        let region: String
        let regionCode: String
        let state: String
        let paymentAmountExactness: String

        struct BlrAdditionalInfo: Codable {
            let dataType: String
            let optional: Bool
            let paramName: String
        }

        struct CustomerParam: Codable {
            let dataType: String
            let maxLength: Int
            let minLength: Int
            let optional: Bool
            let paramName: String
            let visibility: Bool
            let regex: String

            // Custom init for decoding
            init(dataType: String, maxLength: Int, minLength: Int, optional: Bool, paramName: String, visibility: Bool, regex: String) {
                self.dataType = dataType
                self.maxLength = maxLength
                self.minLength = minLength
                self.optional = optional
                self.paramName = paramName
                self.visibility = visibility
                self.regex = regex
            }

            // You can use the default Swift `Decodable` implementation, so no need to explicitly write encoding/decoding functions
        }
    }
}

