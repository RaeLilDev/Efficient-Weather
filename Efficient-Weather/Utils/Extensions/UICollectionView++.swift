//
//  UICollectionView++.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/4/23.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func registerCell<T: UICollectionViewCell>(from type: T.Type) {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        register(nib, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueCell<T: UICollectionViewCell>(from type: T.Type, at indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
}
