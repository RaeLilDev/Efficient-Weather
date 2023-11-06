//
//  DispatchQueue++.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/4/23.
//

import Foundation

extension DispatchQueue {
    static var background: DispatchQueue {
        DispatchQueue.global(qos: .background)
    }
}
