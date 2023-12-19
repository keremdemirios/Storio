//
//  MainViewController+TableView.swift
//  Storio
//
//  Created by Kerem Demir on 19.12.2023.
//

import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView(){
        dataTableView.delegate = self
        dataTableView.dataSource = self
        
        dataTableView.layer.borderWidth = 1
        dataTableView.layer.borderColor = UIColor.label.cgColor
        dataTableView.backgroundColor = .clear
        registerCells()
    }
    
    func registerCells(){
        dataTableView.register(MainTableViewCell.register(), forCellReuseIdentifier: MainTableViewCell.identifier)
    }
    
    func reloadTableView(){
        DispatchQueue.main.async {
            self.dataTableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {
            print("MainTableViewCell does not support !")
            return UITableViewCell()
        }
        cell.nicknameLabel.text = "demiirrkerem"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
