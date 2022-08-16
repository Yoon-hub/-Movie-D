//
//  SecondViewController.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/16.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var reuseableView: ReusableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        reuseableView.toturialName.image = UIImage(named: "2")
        reuseableView.toturialLabel.text = "선택한 영화의 세부 정보를 보여줍니다"
    }
    
}
