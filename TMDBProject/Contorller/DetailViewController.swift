//
//  DetailViewController.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/05.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher
import JGProgressHUD

class DetailViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titlLabel: UILabel!
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var selectMovie: MovieCard!
    var tableList: [TableItem] = []
    
    let hud = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTableView.rowHeight = 90
        detailTableView.dataSource = self
        backgroundImageView.kf.setImage(with: URL(string: EndPoint.imageURL + selectMovie.backdrop))
        posterImageView.kf.setImage(with: URL(string: selectMovie.poster))
        titlLabel.text = selectMovie.title
        requestCast()
        
    }
    
    func requestCast() {
        hud.show(in: view)
        let url = "\(EndPoint.castURL)\(selectMovie.id)/credits?api_key=\(APIKey.TMDB_KEY)"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                for i in json["cast"].arrayValue {
                    let name = i["name"].stringValue
                    let profile = i["profile_path"].stringValue
                    
                    self.tableList.append(TableItem(image: profile, name: name))
                }
                print(self.tableList)
                self.detailTableView.reloadData()
                self.hud.dismiss(animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cast"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.resuableIdentifer, for: indexPath) as! DetailTableViewCell
        cell.faceImageView.kf.setImage(with: URL(string: EndPoint.imageURL+tableList[indexPath.row].image))
        cell.nameLabel.text = tableList[indexPath.row].name
        cell.faceImageView.layer.cornerRadius = 5
        return cell
    }
    
    
}
