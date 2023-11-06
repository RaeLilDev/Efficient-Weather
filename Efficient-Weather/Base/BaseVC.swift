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
        baseViewModel.loadingObservable.subscribe(onNext: { [weak self] isLoading in
            guard let self = self else  { return }
            isLoading ? self.startLoading() : self.stopLoading()
        }).disposed(by: disposeBag)
        
        baseViewModel.errorObservable.subscribe(onNext: {[weak self] error in
            guard let self = self else { return }
            
            self.handleError(error: error)
            
        }).disposed(by: disposeBag)
    }
    
    func startLoading() {
        LoadingView.shared.startLoading()
    }
    
    func stopLoading() {
        LoadingView.shared.hideLoading()
    }
    
    func handleError(error: ApiError) {
        switch error {
        case .noConnection:
            self.showMessage("The internet connection appears to be offline.")
            
        default:
            self.showMessage(error.description)
        }
    }
    
    func showMessage(_ message: String) {
        ToastView.show(message)
    }
    
}

extension BaseVC {
    func present(_ vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
