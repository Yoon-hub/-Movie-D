//
//  FirstViewController.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/16.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var reuseableView: ReusableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        reuseableView.toturialName.image = UIImage(named: "1")
        reuseableView.toturialLabel.text = "현재 영화의 순위를 보여 줍니다"
    }
    
}
