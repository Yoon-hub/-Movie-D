//
//  MovieSearchAPIManager.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/05.
//

import Foundation

import Alamofire
import SwiftyJSON


class MovieSearchAPIManger {
    
    private init() {}
    
    static let shared = MovieSearchAPIManger()
    typealias completionHandle = (Int, MovieCard)-> ()
    
    func requestMovieDate(startPage: Int,  completionHandler: @escaping completionHandle ) {
        let url = EndPoint.tmdbURL + "api_key=\(APIKey.TMDB_KEY)&page=\(startPage)"
        AF.request(url, method: .get).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
          //      print("JSON: \(json)")
                
               let totalPage = json["total_pages"].intValue
                
                for item in json["results"].arrayValue{
                    let id = item["id"].intValue
                    let title = item["title"].stringValue
                    let poster = "\(EndPoint.imageURL)\(item["poster_path"].stringValue)"
                    let overView = item["overview"].stringValue
                    let genre = "#" + CheckGenre.shared.checkGenre(number: item["genre_ids"][0].intValue)
                    let voteAverage = String(format: "%.1f", item["vote_average"].doubleValue)
                    let releaseDate = item["release_date"].stringValue
                    let backdrop = item["backdrop_path"].stringValue
                    
                    let movieCard = MovieCard(id: id, title: title, poster: poster, overView: overView, genre: genre, voteAverage: voteAverage, releaseDate: releaseDate, backdrop: backdrop)
                    
                    completionHandler(totalPage, movieCard)
                    
                }
                
                //print(self.movieCardList)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestCastDate(id: Int, completionHandler: @escaping (TableItem) -> ()) {
        
 
        let url = "\(EndPoint.castURL)\(id)/credits?api_key=\(APIKey.TMDB_KEY)"
        AF.request(url, method: .get).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                for i in json["cast"].arrayValue {
                    let name = i["name"].stringValue
                    let profile = i["profile_path"].stringValue
                    
                    completionHandler(TableItem(image: profile, name: name))
    
                    
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func requestTrailerDate(movieId: String, completionHandler: @escaping (String) -> () ) {
        let url = "\(EndPoint.trailerURL)\(movieId)/videos?api_key=\(APIKey.TMDB_KEY)&language=en-US"
        AF.request(url, method: .get).validate().responseJSON(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                let result = EndPoint.youTube + json["results"][0]["key"].stringValue
                completionHandler(result)
                
                
            case .failure(let error):
                
                print(error)
                
            }
        }
    }
 
    
}
