//
//  CollectionView+Extension.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/04.
//
import UIKit

extension UICollectionView {
    
    func desgin() {
        
        let layout =  UICollectionViewFlowLayout()
        let spacing : CGFloat = 14
        let width = UIScreen.main.bounds.width - (spacing * 2)
        layout.itemSize = CGSize(width: width, height: width / 0.9)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = 25
        layout.minimumInteritemSpacing = spacing
        self.collectionViewLayout = layout
    }
}
