//
//  ReusableView.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/16.
//

import UIKit

class ReusableView: UIView {
    @IBOutlet weak var toturialName: UIImageView!
    @IBOutlet weak var toturialLabel: UILabel!
    
    required init?(coder: NSCoder) {
            super.init(coder: coder)
            let view = UINib(nibName: "ReusableView", bundle: nil).instantiate(withOwner: self).first as! UIView
            view.frame = bounds
            view.layer.cornerRadius = 10
            self.addSubview(view)
        }
    
}
