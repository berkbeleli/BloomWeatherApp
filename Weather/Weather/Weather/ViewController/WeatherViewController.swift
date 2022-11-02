//
//  WeatherViewController.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-02.
//

import UIKit

class WeatherViewController: UIViewController {
  @IBOutlet private weak var updateScrollView: UIScrollView!
  @IBOutlet private weak var shadowContainerView: UIView!
  @IBOutlet private weak var actualWeatherContainerView: UIView!
  @IBOutlet private weak var currentTemperatueLbl: UILabel!
  @IBOutlet private weak var feelingLbl: UILabel!
  @IBOutlet private weak var currentFeelingLbl: UILabel!
  @IBOutlet private weak var maxTemperatureLbl: UILabel!
  @IBOutlet private weak var currentMaxTemperatureLbl: UILabel!
  @IBOutlet private weak var currentHumidityLbl: UILabel!
  @IBOutlet private weak var humidityLbl: UILabel!
  @IBOutlet private weak var currentWeatherImage: UIImageView!
  @IBOutlet private weak var minTemperatureLbl: UILabel!
  @IBOutlet private weak var currentMinTemperatureLbl: UILabel!
  @IBOutlet private weak var pressureLbl: UILabel!
  @IBOutlet private weak var currentPressureLbl: UILabel!
  @IBOutlet private weak var currrentDescription: UILabel!
  @IBOutlet private weak var windSpeedLbl: UILabel!
  @IBOutlet private weak var currentWindSpeedLbl: UILabel!
  @IBOutlet private weak var currentTimeLbl: UILabel!
  @IBOutlet private weak var dailyCollectionView: UICollectionView!
  @IBOutlet private weak var hourlyCollectionView: UICollectionView!
  @IBOutlet private weak var backgroundImageView: UIImageView!
  
  @IBOutlet private weak var dailyLbl: UILabel!
  @IBOutlet private weak var hourlyLbl: UILabel!
  
  private let refreshControl = UIRefreshControl()
  var viewModel = WeatherViewModel()
  
  override func viewDidLoad() {
        super.viewDidLoad()
        bindDatas()
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateUI()
    updateScrollView.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(refreshWeatherData), for: .valueChanged)
  }
  
  private func setupCollections() {
    dailyCollectionView.delegate = self
    dailyCollectionView.dataSource = self
    hourlyCollectionView.delegate = self
    hourlyCollectionView.dataSource = self
  }
  
  private func updateUI() {
    refreshControl.tintColor = .white
    shadowContainerView.layer.cornerRadius = 25
    actualWeatherContainerView.layer.cornerRadius = 25
    actualWeatherContainerView.backgroundColor = .black.withAlphaComponent(0.5)
    actualWeatherContainerView.alpha = 0
    self.navigationItem.setHidesBackButton(true, animated: true)
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    currentWeatherImage.contentMode = .scaleAspectFit
    backgroundImageView.addImageGradient()
    maxTemperatureLbl.text = "Max".localize
    minTemperatureLbl.text = "Min".localize
    feelingLbl.text = "Feeling".localize
    pressureLbl.text = "Pressure".localize
    windSpeedLbl.text = "Wind speed".localize
    humidityLbl.text = "Humidity".localize
    dailyLbl.text = "Daily".localize
    hourlyLbl.text = "Hourly".localize
    backGroundImageAnimation()
    weatherAnimation()
  }
  
  private func backGroundImageAnimation() {
    backgroundImageView.frame.origin.x = 0
    UIView.animate(withDuration: 15, delay: 0, options: [.repeat,.autoreverse]) {
      self.backgroundImageView.frame.origin.x -= 150
    }
  }
  
  private func weatherAnimation() {
    UIView.animate(withDuration: 2, delay: 0, options: [.repeat,.autoreverse]) {
      self.currentWeatherImage.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
    }
    
    UIView.animate(withDuration: 0.9) {
      self.actualWeatherContainerView.alpha = 1
      self.shadowContainerView.dropShadow()
    }
    
    UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse], animations: {
        self.actualWeatherContainerView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
    }) { _ in
        self.actualWeatherContainerView.transform = CGAffineTransform(scaleX: 1, y: 1)
    }
  }
  
  // Pull to refresh
  @objc private func refreshWeatherData(_ sender: Any) {
    fetchWeatherData()
  }
  
  private func fetchWeatherData() {
    viewModel.getWeatherData()
    updateScrollView.refreshControl!.endRefreshing()
  }
  
  private func bindDatas() {
    viewModel.navigationBarTitle.bind { [weak self] result in
      self?.navigationItem.title = result
    }
    viewModel.currentTemperature.bind { [weak self] result in
      self?.currentTemperatueLbl.text = result
    }
    viewModel.currentFeeling.bind { [weak self] result in
      self?.currentFeelingLbl.text = result
    }
    viewModel.currentMaxTmp.bind { [weak self] result in
      self?.currentMaxTemperatureLbl.text = result
    }
    viewModel.currentMinTmp.bind { [weak self] result in
      self?.currentMinTemperatureLbl.text = result
    }
    viewModel.currentHumidity.bind { [weak self] result in
      self?.currentHumidityLbl.text = result
    }
    viewModel.currentPressure.bind { [weak self] result in
      self?.currentPressureLbl.text = result
    }
    viewModel.currentDescription.bind { [weak self] result in
      self?.currrentDescription.text = result
    }
    viewModel.currentWindSpeed.bind { [weak self] result in
      self?.currentWindSpeedLbl.text = result
    }
    viewModel.currentTime.bind { [weak self] result in
      self?.currentTimeLbl.text = result
    }
    viewModel.currentImageWeather.bind { [weak self] result in
      self?.currentWeatherImage.image = result
    }
    viewModel.backgroundImage.bind { [weak self] result in
      self?.backgroundImageView.image = result
    }
    
    viewModel.reloadCollectionViews = {
      DispatchQueue.main.async {
        self.dailyCollectionView.reloadData()
        self.hourlyCollectionView.reloadData()
      }
    }
    self.setupCollections()
    viewModel.implementWeatherDatas()
    
  }
  
  @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
  }
  
  
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dailyCollectionView {
            return viewModel.numberOfDailyCells
        } else {
            return viewModel.numberOfHourlyCells
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == hourlyCollectionView {
            
            guard let hourlyCell = hourlyCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.cells.hourlyCollectionViewCell, for: indexPath) as? HourlyCollectionViewCell
            else { return UICollectionViewCell()}
            
          return viewModel.hourlyCellConfigure(cell: hourlyCell, indexPath: indexPath)
            
        } else {
            
            guard let dailyCell = dailyCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.cells.dailyCollectionViewCell, for: indexPath) as? DailyCollectionViewCell
            else { return UICollectionViewCell ()}
            
            return viewModel.dailyCellConfigure(cell: dailyCell, indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == dailyCollectionView {
            return CGSize(width: 130, height: 50)
        } else {
            return CGSize(width: 70, height: 100)
        }
    }
}
