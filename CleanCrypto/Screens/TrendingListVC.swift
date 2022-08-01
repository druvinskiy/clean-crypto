//
//  TrendingListVC.swift
//  CleanCrypto
//
//  Created by David Ruvinskiy on 7/29/22.
//

import UIKit

class TrendingListVC: CCDataLoadingVC {
    
    let tableView = UITableView()
    var coins: [Coin] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
        getTrendingCoins()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        tableView.register(TrendingCell.self, forCellReuseIdentifier: TrendingCell.reuseID)
    }
    
    func getTrendingCoins() {
        showLoadingView()
        
        NetworkManager.shared.getTrendingCoinsWithDetails { [weak self]
            (result: Result<[Coin], CCError>) in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            DispatchQueue.main.async {
                self.title = "Trending"
            }
            
            switch result {
            case .success(let coins):
                self.updateUI(with: coins)
            case .failure(let error):
                self.presentCCAlertOnMainThread(title: "Something Went Wrong", message: error .rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func updateUI(with coins: [Coin]) {
        self.coins = coins
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension TrendingListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendingCell.reuseID) as! TrendingCell
        let item = coins[indexPath.row].item
        cell.set(item: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = coins[indexPath.row].item
        let descriptionVC = DescriptionVC(item: item)
        navigationController?.pushViewController(descriptionVC, animated: true)
    }
}
