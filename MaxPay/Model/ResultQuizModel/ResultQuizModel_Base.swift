//
//  ResultQuizModel_Base.swift
//  MaxPay
//
//  Created by Admin on 02/02/25.
//

import Foundation

struct ResultQuizModel_Base : Codable {
    let status: String?
    let rankedResult: [RankedResult]?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case rankedResult = "ranked_results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        rankedResult = try values.decodeIfPresent([RankedResult].self, forKey: .rankedResult)
    }

}


// Root model


// Ranked Result model
struct RankedResult: Codable {
    let questionID: String?
    let duration: String?
    let user: User?
    let rank: Int?

    enum CodingKeys: String, CodingKey {
        case questionID = "question_id"
        case duration = "duration"
        case user = "user"
        case rank = "rank"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        questionID = try values.decodeIfPresent(String.self, forKey: .questionID)
        duration = try values.decodeIfPresent(String.self, forKey: .duration)
        
        user = try values.decodeIfPresent(User.self, forKey: .user)
        rank = try values.decodeIfPresent(Int.self, forKey: .rank)
    }
}

// User model
struct User: Codable {
    let firstName: String?
    let lastName: String?
    let city: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case city = "city"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        
        city = try values.decodeIfPresent(String.self, forKey: .city)
        
    }
}

