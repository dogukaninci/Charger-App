//
//  SelectCityViewController.swift
//  Charger App
//
//  Created by Doğukan Inci on 30.06.2022.
//

import UIKit

class SelectCityViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    
    var selectCityViewModel = SelectCityViewModel()
    
    private var searchTextCharCount = Int()
    
    var constraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        delegation()
        setupConstraints()
        style()
        setNavigationBarItems()
        initViewModel()
    }
    override func viewDidLayoutSubviews() {
        setGradientBackground()
    }
    /// Adds subviews to the SelectCityViewController view
    private func setup() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    /// Setups view components constraints
    private func setupConstraints() {
        [
            searchBar,
            tableView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        constraints.append(contentsOf: [
            
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate(constraints) // activates constraints array
    }
    /// add gradient background layer to view
    private func setGradientBackground() {
        let gl = CAGradientLayer()
        gl.colors = [ Theme.colorCharcoalGrey().cgColor, Theme.darkColor().cgColor]
        gl.locations = [ 0.0, 1.0]
        gl.frame = self.view.bounds
        self.view.layer.insertSublayer(gl, at:0)
    }
    private func style(){
        searchBar.placeholder = "Şehir Ara"
        // Clear unnecessary background
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.layer.cornerRadius = 18
        // magnifying glass icon color
        searchBar.searchTextField.leftView?.tintColor = Theme.colorWhite()
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.borderColor = Theme.colorWhite().cgColor
        searchBar.searchTextField.textColor = Theme.colorWhite()
        searchBar.autocapitalizationType = .none
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = Theme.colorGrayscale()
        // clear head inset
        tableView.separatorInset = .zero
        tableView.rowHeight = 44
        tableView.tableFooterView?.backgroundColor = .red
        
    }
    func initViewModel() {
        // Get cities data
        selectCityViewModel.fetchCities()
        
        // Reload TableView closure
        selectCityViewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
extension SelectCityViewController {
    /// Sets Navigation Bar styles and items
    private func setNavigationBarItems() {
        // Set page title
        navigationItem.title = "Şehir Seçin"
        // Clear back button title (Its about navigation controller, not navigation item)
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
extension SelectCityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectCityViewModel.filteredCities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CityTableViewCell
        
        let attrStri = NSMutableAttributedString.init(string:selectCityViewModel.filteredCities[indexPath.row])
        let myRange = NSRange(location: 0, length: searchTextCharCount)
        attrStri.addAttributes([NSAttributedString.Key.foregroundColor : Theme.colorWhite() as Any], range: myRange)
        cell.title.attributedText = attrStri

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = selectCityViewModel.filteredCities[indexPath.row]
        let selectStationVC = SelectStationViewController(viewModel: city)
        navigationController?.pushViewController(selectStationVC, animated: true)
    }
}
extension SelectCityViewController {
    /// Table View, Search Bar Delegation
    private func delegation() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
}
extension SelectCityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        selectCityViewModel.filterArrayViaSearchBarText(searchBarText: searchText)
        searchTextCharCount = searchText.count
        if(searchText == "") {
            searchBar.searchTextField.layer.borderColor = Theme.colorWhite().cgColor
        } else {
            if (selectCityViewModel.filteredCities.count == 0) {
                searchBar.searchTextField.layer.borderColor = Theme.colorSecurityOn().cgColor
            } else {
                searchBar.searchTextField.layer.borderColor = Theme.colorPrimary().cgColor
            }
        }
    }
}
