//
//  Movie.swift
//  RappiTest
//
//  Created by Juan Esteban Pelaez on 9/12/21.
//
import Foundation

// MARK: - ResultMovie
struct ResultMovie: Decodable {
    let page: Int
    let results: [MovieItem]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieItem: Decodable {
    
    //let adult: Bool
    let backdropPath: String
    //let genreIDS: [Int]
    let id: Int32
    //let originalTitle: String
    let overview: String
    //let popularity: Double
    let posterPath, releaseDate, title: String
    //let video: Bool
    let voteAverage: Double
    //let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        //case adult
        case backdropPath = "backdrop_path"
        //case genreIDS = "genre_ids"
        case id
        //case originalTitle = "original_title"
        case overview
        //case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        //case video
        case voteAverage = "vote_average"
        //case voteCount = "vote_count"
    }
    
    init?(data: Movie) {
        self.id = data.id
        self.backdropPath = data.backdropPath!
        self.overview = data.overview!
        self.posterPath = data.posterPath!
        self.releaseDate = data.releaseDate!
        self.title = data.title!
        self.voteAverage = data.voteAverage
    }
}
