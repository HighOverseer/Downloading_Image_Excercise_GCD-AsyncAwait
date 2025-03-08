//
//  MovieModel.swift
//  DownloadingImageExcercise
//
//  Created by fajar on 07/03/25.
//

import Foundation
import UIKit

enum DownloadState{
    case new, downloaded, failed
}

class Movie {
    let title: String
    let genres:[Int]
    let popularity:Double
    let voteAverage:Double
    let overview: String
    let releaseDate: Date
    let posterPath:URL
    
  var state: DownloadState = .new
  var image:UIImage?
 
  init(
    title: String,
    posterPath: URL,
    genres:[Int],
    popularity:Double,
    voteAverage:Double,
    overview: String,
    releaseDate: Date
  ) {
      self.title = title
      self.posterPath = posterPath
      self.genres = genres
      self.popularity = popularity
      self.voteAverage = voteAverage
      self.overview = overview
      self.releaseDate = releaseDate
  }
}

struct MovieResponses:Codable{
    let page:Int
    let totalResults:Int
    let totalPages:Int
    let movies:[MovieResponse]
    
    enum CodingKeys:String, CodingKey{
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
    
}

struct MovieResponse:Codable{
    let popularity:Double
    let posterPath:URL
    let releaseDate:Date
    let title:String
    let voteAverage:Double
    let genreIds:[Int]
    let overview:String
    
    enum CodingKeys: String, CodingKey{
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case genreIds = "genre_ids"
        case overview
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        
        let path = try container.decode(String.self, forKey: .posterPath)
        self.posterPath = URL(string: "https://image.tmdb.org/t/p/w300\(path)")!
        
        let dateString = try container.decode(String.self, forKey: .releaseDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.releaseDate = dateFormatter.date(from: dateString)!
        
        self.title = try container.decode(String.self, forKey: .title)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.genreIds = try container.decode([Int].self, forKey: .genreIds)
        self.overview = try container.decode(String.self, forKey: .overview)
    }
}

