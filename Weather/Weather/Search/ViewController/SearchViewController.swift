//
//  SearchViewController.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-02.
//

import UIKit

class SearchViewController: UIViewController {
  
  @IBOutlet private weak var searchTableView: UITableView!
  @IBOutlet private weak var searchBar: UISearchBar!
  @IBOutlet private weak var searchNavigationBar: UINavigationBar!
  
  var viewModel = SearchViewModel()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesSearchBarWhenScrolling = false
        setupVM()
        setupTableViewCell()
    }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupUI()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBar.tintColor = .white
  }
  
  
  @IBAction func backButtonPressed(_ sender: UIButton) {
    self.dismiss(animated: true)
  }
  
  private func setupUI() {
    view.backgroundColor = .clear
    searchNavigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    searchNavigationBar.topItem?.title = "Location".localize
    searchNavigationBar.tintColor = .white
    searchBar.delegate = self
    searchBar.searchTextField.backgroundColor = .clear
    searchBar.searchTextField.textColor = .white
    searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search".localize, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
  }
  
  private func setupVM() {
    viewModel.reloadTableView = {
      DispatchQueue.main.async {
        self.searchTableView.reloadData()
      }
    }
    viewModel.getCity()
  }
  
  private func setupTableViewCell() {
    searchTableView.delegate = self
    searchTableView.dataSource = self
  }
  

}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      viewModel.searchCity(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      viewModel.searchCity(text: searchBar.text!)
      self.searchBar.endEditing(true)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel.searchCity(text: text)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return viewModel.numberOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        if viewModel.filteredCityIsEmpty() {
            
            guard let locationCell = tableView.dequeueReusableCell(withIdentifier: Constants.cells.selfLocationTableViewCell, for: indexPath) as? SelfLocationTableViewCell else { return UITableViewCell() }
            locationCell.setupCell()
            return locationCell
            
        } else {
            
            guard let searchCell = tableView.dequeueReusableCell(withIdentifier: Constants.cells.searchCitiesTableViewCell, for: indexPath) as? SearchCitiesTableViewCell else { return UITableViewCell() }
            let cellVieModel = viewModel.getCellViewModel(at: indexPath)
            searchCell.setupCell(filteredCities: cellVieModel)
            return searchCell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
        self.dismiss(animated: true)
    }
}

