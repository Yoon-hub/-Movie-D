//
//  MovieCollectionViewController.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/04.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class MovieCollectionViewController: UICollectionViewController {
    
    var movieCardList: [MovieCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.desgin()
        requestMovie()
    }
    
    func requestMovie() {
        let url = EndPoint.tmdbURL + "api_key=\(APIKey.TMDB_KEY)"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
          //      print("JSON: \(json)")
                
                for item in json["results"].arrayValue{
                    let id = item["id"].intValue
                    let title = item["title"].stringValue
                    let poster = "\(EndPoint.imageURL)\(item["poster_path"].stringValue)"
                    let overView = item["overview"].stringValue
                    let genre = self.checkGenre(number: item["genre_ids"][0].intValue)
                    let voteAverage = String(format: "%.1f", item["vote_average"].doubleValue)
                    let releaseDate = item["release_date"].stringValue
                    
                    self.movieCardList.append(MovieCard(id: id, title: title, poster: poster, overView: overView, genre: genre, voteAverage: voteAverage, releaseDate: releaseDate))
                    
                }
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    func checkGenre(number: Int) -> String {
        switch number {
        case 28: return "Action"
        case 12: return "Adventure"
        case 16: return "Animation"
        case 35: return "Comedy"
        case 80: return "Crime"
        case 99: return "Documentary"
        case 18: return "Drama"
        case 10751: return "Family"
        case 14: return "Fantasy"
        case 36: return "History"
        case 27: return "Horror"
        case 10402: return "Music"
        case 9648: return "Mystery"
        case 10749: return "Romance"
        case 878: return "Science Fiction"
        case 10770: return "TV Movie"
        case 53: return "Thriller"
        case 10753: return "War"
        case 37: return "Western"
            
        default : return "ETC"
        }
    }
    
    
    //MARK: -
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCardList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.resuableIdentifer, for: indexPath) as! MovieCollectionViewCell
        let nowcell = movieCardList[indexPath.row]
        cell.desginmovieView()
        cell.releaseLabel.text = nowcell.releaseDate
        cell.genreLabel.text = nowcell.genre
        cell.posterImageView.kf.setImage(with: URL(string: nowcell.poster))
        cell.overViewLabel.text = nowcell.overView
        cell.titleLabel.text = nowcell.title
        cell.voteAverageLabel.text = nowcell.voteAverage
        
        return cell
        
    }
    
    
}
