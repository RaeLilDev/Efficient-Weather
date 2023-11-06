//
//  HomeVC.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/4/23.
//

import UIKit

class HomeVC: BaseVC {

    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    @IBOutlet weak var lblMinTemp: UILabel!
    @IBOutlet weak var lblFeelsLike: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var lblVisibility: UILabel!
    @IBOutlet weak var lblForecastTitle: UILabel!
    @IBOutlet weak var viewForecast: UIStackView!
    @IBOutlet weak var viewFeelsLike: UIStackView!
    @IBOutlet weak var viewHumidity: UIStackView!
    @IBOutlet weak var viewWind: UIStackView!
    @IBOutlet weak var viewVisibility: UIStackView!
    @IBOutlet weak var tableViewForecast: UITableView!
    @IBOutlet weak var heightForecast: NSLayoutConstraint!
    
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listen(for: viewModel)
        setupView()
        setupTableView()
        viewModel.fetchAllData()
        observeData()
        viewModel.initObservers()
    }
    
    private func setupView() {
        viewForecast.layer.cornerRadius = 16.0
        viewFeelsLike.layer.cornerRadius = 16.0
        viewHumidity.layer.cornerRadius = 16.0
        viewWind.layer.cornerRadius = 16.0
        viewVisibility.layer.cornerRadius = 16.0
    }
    
    private func setupTableView() {
        tableViewForecast.dataSource = self
        tableViewForecast.registerCell(from: DailyForecastCell.self)
    }
    
    private func observeData() {
        viewModel.homeItems.subscribe(onNext: {[weak self] data in
                guard let self = self else { return }
                debugPrint("Bind data is called")
                self.bindData()
            }).disposed(by: disposeBag)
    }
    
    private func bindData() {
        lblTemp.text = viewModel.getTemp()
        lblMaxTemp.text = viewModel.getMaxTemp()
        lblMinTemp.text = viewModel.getMinTemp()
        lblDesc.text = viewModel.getDesc()
        lblCity.text = viewModel.getCity()
        lblForecastTitle.text = "\(viewModel.getForecastCount())-Day FORECAST"
        lblFeelsLike.text = viewModel.getFeelsLikeTemp()
        lblVisibility.text = viewModel.getVisibility()
        lblHumidity.text = viewModel.getHumidity()
        lblWind.text = viewModel.getWindSpeed()
        updateForecastTable()
    }
    
    private func updateForecastTable() {
        let rowCount = viewModel.getForecastCount()
        heightForecast.constant = CGFloat(rowCount * 49)
        tableViewForecast.reloadData()
    }

}

extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getForecastCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(from: DailyForecastCell.self, at: indexPath)
        cell.bind(with: viewModel.getDay(by: indexPath.row), data: viewModel.getForecast(by: indexPath.row))
        return cell
    }
    
    
}
