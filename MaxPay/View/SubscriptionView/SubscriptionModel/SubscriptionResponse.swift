import Foundation
import Alamofire

// Define the model to represent each feature
struct Feature: Codable {
    let feature: String
    let description: String
    let price: String
    let duration: String
    let isActive: Bool
    
    enum CodingKeys: String, CodingKey {
        case feature
        case description
        case price
        case duration
        case isActive = "is_active"
    }
}

// Define the SubscriptionResponse model
struct SubscriptionResponse: Codable {
    let status: String
    let data: [Feature]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}
