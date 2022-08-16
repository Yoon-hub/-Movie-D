//
//  CardView.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/09.
//

import UIKit

class CardView: UIView {
    
    @IBOutlet weak var postImageView: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds
        view.backgroundColor = .black
       
        self.addSubview(view)
    }
    
}
