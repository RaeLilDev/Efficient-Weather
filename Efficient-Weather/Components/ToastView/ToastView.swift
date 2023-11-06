//
//  ToastView.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/6/23.
//

import Foundation
import UIKit

class ToastView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    
    
    init(with message: String) {
        super.init(frame: UIScreen.main.bounds)
        buildView(with: message)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private func buildView(with message: String) {
        Bundle.main.loadNibNamed(String(describing: ToastView.self), owner: self)
        
        let screenWidth = UIScreen.main.bounds.width
        let attribute: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16, weight: .medium)]
        let width: CGFloat = screenWidth - 112
        let messageHeight: CGFloat = message.heightWithConstrainedWidth(attributes: attribute, width: width)
        
        let height: CGFloat = messageHeight + 28
    
        containerView.frame = CGRect(x: 0, y: 48, width: screenWidth, height:  height)
        containerView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        addSubview(containerView)
    }
    
    func present(_ message: String) {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        frame = window.frame
        window.addSubview(self)
        lblMessage.text = message
        alpha = 0
        UIView.animate(withDuration: 0.5) { self.alpha = 1 }
        Timer.scheduledTimer(withTimeInterval: 3.5, repeats: false) { _ in
            UIView.animate(withDuration: 0.5) { self.alpha = 0 } completion: { _ in self.removeFromSuperview() }
        }
    }
    
}

extension ToastView {
    static func show(_ message: String) {
        let toast = ToastView(with: message)
        toast.present(message)
    }
}
