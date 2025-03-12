import Foundation

struct BillerPayuJsonResponse: Codable {
    var response: Response
    var status: String
    var message: String

    struct Response: Codable {
        var code: Int
        var status: String
        var platformFee: String
        var paymentAmountExactness: String
        var payload: Payload
        var customerParams: [String: String]

        struct Payload: Codable {
            var refId: String
            var requestTimeStamp: String
            var amount: Double
            var accountHolderName: String
            var dueDate: String
            var billDate: String
            var billerId: String
            var amountDetails: String
            var billNumber: String
            var billPeriod: String
            var approvalRefNum: String
            var additionalParams: [String: String]
            var couCustConvFee: Int
            var customerConvFee: Int
        }
    }
}
