//
//  MainViewController.swift
//  Storio
//
//  Created by Kerem Demir on 19.12.2023.
//

import UIKit

class MainViewController: UIViewController {
    // MARK : Elements
    
    // MARK : UI Elements
    
    @IBOutlet weak var dataTableView: UITableView!
    
    @IBOutlet weak var enterNickNameTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        configureUI()
        setupTableView()
        reloadTableView()
    }
    
    private func configureUI(){
        
    }
    
    // MARK : Actions
    @IBAction func searchTapped(_ sender: Any) {
        print("Search tapped.")
    }
    
    @IBAction func findTapped(_ sender: Any) {
        print("Find tapped.")
    }
    
    @IBAction func clearTapped(_ sender: Any) {
        print("Clear tapped.")
    }
}
