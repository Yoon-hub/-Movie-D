//
//  MovieCollectionViewController.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/04.
//

import UIKit

import Alamofire
import JGProgressHUD
import Kingfisher
import SwiftyJSON



class MovieCollectionViewController: UICollectionViewController {
    
    var movieCardList: [MovieCard] = []
    let hud = JGProgressHUD()
    var startPage = 1
    var totalPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.desgin()
        requestMovie()
        collectionView.prefetchDataSource = self
    }
    
    func requestMovie() {
        hud.show(in: view)
        MovieSearchAPIManger.shared.requestMovieDate(startPage: startPage) { totalPage, movieCard in
            self.totalPage = totalPage
            self.movieCardList.append(movieCard)
            self.collectionView.reloadData()
            self.hud.dismiss(animated: true)
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
        cell.urlButton.tag = nowcell.id
        cell.urlButton.addTarget(self, action: #selector(requestTrailer(sender:)), for: .touchUpInside)
        
        return cell
        
    }
    
    @objc
    func requestTrailer(sender: UIButton){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: WebViewController.resuableIdentifer) as! WebViewController
        vc.movieId = String(sender.tag)
        
        navigationController?.pushViewController(vc, animated: true)

        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: DetailViewController.resuableIdentifer) as! DetailViewController
        
        vc.selectMovie = movieCardList[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

extension MovieCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for i in indexPaths{
            if i.item == movieCardList.count - 1 && movieCardList.count < totalPage{
                startPage += 1
                requestMovie()
            }
        }
            
    }
    
    
}
