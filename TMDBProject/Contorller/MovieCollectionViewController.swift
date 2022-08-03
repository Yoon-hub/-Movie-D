//
//  MovieCollectionViewController.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/04.
//

import UIKit

class MovieCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        desginCollectionView()
        
    }
    
    func desginCollectionView() {
        let layout =  UICollectionViewFlowLayout()
        let spacing : CGFloat = 14
        let width = UIScreen.main.bounds.width - (spacing * 2)
        layout.itemSize = CGSize(width: width, height: width / 0.8)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = 25
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
    
    //MARK: -
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.resuableIdentifer, for: indexPath) as! MovieCollectionViewCell
        cell.desginmovieView()
        
        return cell
        
    }


}
