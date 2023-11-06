//
//  ForecastDetailVC.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/4/23.
//

import UIKit

class ForecastDetailVC: UIViewController {

    @IBOutlet weak var tableViewForecast: UITableView!
    @IBOutlet weak var heightForecast: NSLayoutConstraint!
    @IBOutlet weak var contentContainer: UIStackView!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var ivClose: UIImageView!
    
    var viewModel: ForecastDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupView()
        updateTableView()
        setupGestureRecognizers()
    }
    
    private func setupTableView() {
        tableViewForecast.dataSource = self
        tableViewForecast.registerCell(from: ForecastByTimeCell.self)
    }
    
    private func setupView() {
        contentContainer.layer.cornerRadius = 16.0
        lblDay.text = viewModel.getDay()
    }
    
    private func updateTableView() {
        heightForecast.constant = CGFloat(93 * viewModel.getForecastCount())
        tableViewForecast.reloadData()
    }
    
    private func setupGestureRecognizers() {
        let tapClose = UITapGestureRecognizer(target: self, action: #selector(onTapClose))
        ivClose.isUserInteractionEnabled = true
        ivClose.addGestureRecognizer(tapClose)
    }
    
    @objc private func onTapClose() {
        self.dismiss(animated: true)
    }

}

extension ForecastDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getForecastCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(from: ForecastByTimeCell.self, at: indexPath)
        cell.data = viewModel.getForecast(by: indexPath.row)
        return cell
    }
}
