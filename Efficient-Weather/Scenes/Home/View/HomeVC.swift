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
    @IBOutlet weak var viewLocation: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ivBackground: UIImageView!
    
    var viewModel: HomeViewModel!
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listen(for: viewModel)
        setupView()
        setupTableView()
        setupRefreshControl()
        viewModel.fetchAllData()
        observeData()
        viewModel.initObservers()
        setupGestureRecognizer()
    }
    //MARK: - Setup View
    private func setupView() {
        viewForecast.layer.cornerRadius = 16.0
        viewFeelsLike.layer.cornerRadius = 16.0
        viewHumidity.layer.cornerRadius = 16.0
        viewWind.layer.cornerRadius = 16.0
        viewVisibility.layer.cornerRadius = 16.0
        viewLocation.layer.cornerRadius = viewLocation.bounds.height / 2
    }
    
    private func setupTableView() {
        tableViewForecast.dataSource = self
        tableViewForecast.delegate = self
        scrollView.delegate = self
        tableViewForecast.registerCell(from: DailyForecastCell.self)
    }
    
    private func setupRefreshControl() {
        refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        scrollView.addSubview(refreshControl)
    }
    
    private func setupGestureRecognizer() {
        let tapLocation = UITapGestureRecognizer(target: self, action: #selector(onTapLocation))
        viewLocation.isUserInteractionEnabled = true
        viewLocation.addGestureRecognizer(tapLocation)
    }
    
    //MARK: - Bind Data
    private func observeData() {
        viewModel.homeItems.subscribe(onNext: {[weak self] data in
                guard let self = self else { return }
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
    
    //MARK: - Action Callbacks
    @objc private func onTapLocation() {
        presentChooseLocationVC()
    }
    
    @objc private func refreshData() {
        viewModel.fetchAllData()
        refreshControl.endRefreshing()
    }
    
    
    //MARK: - Routers
    private func presentChooseLocationVC() {
        let vc = ChooseLocationVC()
        vc.viewModel = ChooseLocationViewModel(placeModel: PlaceModelImpl.shared, selectedPlace: viewModel.getPlace())
        if #available(iOS 15.0, *) {
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [.large()]
                sheet.prefersGrabberVisible = true
            }
        } else {
            vc.modalPresentationStyle = .overCurrentContext
        }
        present(vc)
    }
    
    private func presentForecastDetail(_ day: String, _ forecastList: [WeatherForecastVO]) {
        let vc = ForecastDetailVC()
        vc.viewModel = ForecastDetailViewModel(day: day, forecastList: forecastList)
        if #available(iOS 15.0, *) {
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [.large()]
                sheet.prefersGrabberVisible = true
            }
        } else {
            vc.modalPresentationStyle = .overCurrentContext
        }
        present(vc)
    }
}

//MARK: - TableView Datasource
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

//MARK: - TableView Delegate
extension HomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let day = viewModel.getDay(by: indexPath.row)
        let forecastList = viewModel.getforecastList(by: indexPath.row)
        presentForecastDetail(day, forecastList)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let showLocationBg = scrollView.contentOffset.y >= 40.0
        viewLocation.backgroundColor = showLocationBg ? .black : .clear
    }
    
    
}
