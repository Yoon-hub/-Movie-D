//
//  MainViewController.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/09.
//

import UIKit

class MainViewController: UIViewController {
    let list = ["아는 와이프와 비슷한 콘텐츠", "미스터 션샤인과 비슷한 콘텐츠", "액션SF", "미국TV 프로그램"]
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.backgroundColor = .clear
        
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
        cell.typeLabel.text = list[indexPath.section]
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.resuableIdentifer, for: indexPath) as! MainCollectionViewCell
        
        return cell
    }
    
    
}
