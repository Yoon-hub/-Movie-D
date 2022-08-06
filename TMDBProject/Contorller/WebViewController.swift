//
//  WebViewController.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/05.
//

import UIKit
import WebKit

import Alamofire
import SwiftyJSON
import JGProgressHUD

class WebViewController: UIViewController {
    
    @IBOutlet weak var trailerWebView: WKWebView!
    var movieId: String!
    
    let hud = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTrailer()
    }
    
    func requestTrailer() {
        let url = "\(EndPoint.trailerURL)\(movieId!)/videos?api_key=\(APIKey.TMDB_KEY)&language=en-US"
        hud.show(in: view)
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                let result = EndPoint.youTube + json["results"][0]["key"].stringValue
                self.openWebPage(urlStr: result)
                self.hud.dismiss(animated: true)
            case .failure(let error):
                
                print(error)
                self.hud.dismiss(animated: true)
            }
        }
    }
    
    func openWebPage(urlStr: String) {
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        trailerWebView.load(request)
        
    }
    
    
}
