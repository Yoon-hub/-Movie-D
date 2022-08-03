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
 
    func desginmovieView(){
        movieView.layer.borderWidth = 1
        movieView.layer.borderColor = UIColor.black.cgColor
        movieView.layer.cornerRadius = 15
        
    }
    
}
