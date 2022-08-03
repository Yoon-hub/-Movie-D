//
//  ReuseableViewProtocol.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/04.
//

import Foundation
import UIKit

protocol ReuseableViewProtocol {
    static var resuableIdentifer : String { get }
}

extension UICollectionViewCell: ReuseableViewProtocol {
    static var resuableIdentifer: String {
        return String(describing: self)
    }
}
