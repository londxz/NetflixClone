//
//  Movie.swift
//  NetflixClone
//
//  Created by Родион Холодов on 31.07.2025.
//

struct Movie: Codable {
    let id: Int
    let originalTitle: String
    let title: String
    let overview: String
    let voteAverage: Double
    let popularity: Double
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case title
        case overview
        case voteAverage = "vote_average"
        case popularity
        case releaseDate = "release_date"
    }
}
