//
//  MainTableViewCell.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/09.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
        
    }
    
    func setUI() {
        typeLabel.textColor = .white
        typeLabel.font = UIFont.boldSystemFont(ofSize: 17)
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = collectionViewLayout()
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout =  UICollectionViewFlowLayout()
        let spacing : CGFloat = 4
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3.5, height: 150)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 0
        
        return layout
    }

}
