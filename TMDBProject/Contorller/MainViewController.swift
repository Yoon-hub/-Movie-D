//
//  MainViewController.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/09.
//

import UIKit

import Kingfisher

class MainViewController: UIViewController {
    var list: [[String]] = []
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.backgroundColor = .clear
        
        MovieSearchAPIManger.shared.requestRecommendations { value in
            self.list = value
            dump(self.list)
            self.mainTableView.reloadData()
        }
    }
    

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.resuableIdentifer, for: indexPath) as! MainTableViewCell
        cell.typeLabel.text = "\(MovieSearchAPIManger.shared.movieList[indexPath.section].0)와 유사한 작품"
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.tag = indexPath.section
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.resuableIdentifer, for: indexPath) as! MainCollectionViewCell
        let url = URL(string: "\(EndPoint.imageURL)\(list[collectionView.tag][indexPath.item])")
        
        cell.cardView.postImageView.kf.setImage(with: url)
        
        return cell
    }
    
    
}
