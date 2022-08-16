//
//  ThridViewController.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/16.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var reuseableView: ReusableView!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reuseableView.toturialName.image = UIImage(named: "3")
        reuseableView.toturialLabel.text = "영화의 예고편을 보여줍니다"
        
        var config = UIButton.Configuration.filled()
        config.title = "확인"
        config.baseForegroundColor = .yellow
        doneButton.configuration = config
        
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        //첫시작을 트로루 변경
        UserDefaults.standard.set(true, forKey: "FirstTime")
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: MovieCollectionViewController.resuableIdentifer) as? MovieCollectionViewController
                              
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()

    }
    
}
