//
//  MovieCollectionViewCell.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/04.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieView: UIView!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    
    func desginmovieView(){
        movieView.layer.cornerRadius = 10
        
        movieView.layer.masksToBounds = false

        movieView.layer.shadowOffset = CGSize(width: 5 , height: 5)
        movieView.layer.shadowOpacity = 0.5
        movieView.layer.shadowRadius = 10
        voteAverageLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
    
    }
    
}
