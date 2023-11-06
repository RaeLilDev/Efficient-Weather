//
//  BaseVC.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/4/23.
//

import Foundation
import RxSwift
import RxCocoa

class BaseVC: UIViewController {
    
    var baseViewModel: BaseViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
    
    deinit {
        print("Deinit: - " + String(describing: type(of: self)))
    }
    
    func listen(for viewModel: BaseViewModel) {
        self.baseViewModel = viewModel
        
        listenStateChanges()
        
    }
    
    private func listenStateChanges() {
        baseViewModel.loadingObservable.subscribe(onNext: { [weak self] data in
            guard let self = self else  { return }
            if data {
//                self.startLoading()
            } else {
//                self.stopLoading()
            }
        }).disposed(by: disposeBag)
        
        baseViewModel.errorObservable.subscribe(onNext: {[weak self] error in
            guard let self = self else { return }
            
//            self.handleError(error: error)
            
        }).disposed(by: disposeBag)
    }
    
}
