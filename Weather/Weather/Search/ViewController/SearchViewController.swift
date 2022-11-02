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
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.navigationItem.hidesSearchBarWhenScrolling = false
    }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupUI()
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBar.tintColor = .white
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

}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    
    }
}
