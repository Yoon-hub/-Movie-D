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
        hud.show(in: view)
        MovieSearchAPIManger.shared.requestTrailerDate(movieId: movieId!) { result in
            DispatchQueue.main.async {
                self.openWebPage(urlStr: result)
            }
          
            self.hud.dismiss(animated: true)
        }
    }
    
    func openWebPage(urlStr: String) {
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        trailerWebView.load(request)
        
    }
    
    
}
