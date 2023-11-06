//
//  LoadingView.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/6/23.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    
    static let shared = LoadingView()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        buildView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildView()
    }
    
    private func buildView() {
        Bundle.main.loadNibNamed(String(describing: LoadingView.self), owner: self)
        containerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height)
        containerView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        addSubview(containerView)
    }
    
    func startLoading() {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        frame = window.frame
        window.addSubview(self)
    }
    
    func hideLoading() {
        removeFromSuperview()
    }
    
}
