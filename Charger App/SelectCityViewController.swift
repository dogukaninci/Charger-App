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
    private let cityArray = ["Ankara", "Eskişehir"]
    
    var constraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        delegation()
        setupConstraints()
        style()
        setNavigationBarItems()
    }
    /// Adds subviews to the AppointmentsViewController view
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
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate(constraints) // activates constraints array
    }
    private func style(){
        if let backgroundImage = UIImage(named: "background") {
            view.backgroundColor = UIColor(patternImage: backgroundImage)
        }
        searchBar.placeholder = "Şehir Ara"
        // Clear unnecessary background
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.layer.cornerRadius = 18
        // magnifying glass icon color
        searchBar.searchTextField.leftView?.tintColor = Theme.colorMain()
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.borderColor = UIColor.red.cgColor
        searchBar.searchTextField.textColor = Theme.colorMain()
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = Theme.colorAux()
        // clear head inset
        tableView.separatorInset = .zero
        tableView.rowHeight = 44
        
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
        return cityArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CityTableViewCell
        
        cell.title.text = cityArray[indexPath.row]
        return cell
    }
}
extension SelectCityViewController {
    /// Table View Delegation
    private func delegation() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}
