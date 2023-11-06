//
//  UIWindow++.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/5/23.
//

import Foundation
import UIKit

extension UIWindow {
    
    static func switchRootView(_ root: UIViewController) {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
        window.rootViewController = root
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3
        UIView.transition(with: window, duration: duration, options: options, animations: nil, completion: nil)
    }
}
