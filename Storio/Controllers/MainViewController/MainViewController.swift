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
        view.backgroundColor = .systemBackground
        configure()
        
    }

    private func configure(){
        configureUI()
        setupTableView()
        reloadTableView()
    }
    
    private func configureUI(){
        searchButton.makeCircular(cornerRadius: 12, borderWidth: 1, borderColor: .label)
        findButton.makeCircular(cornerRadius: 12, borderWidth: 1, borderColor: .label)
        clearButton.makeCircular(cornerRadius: 12, borderWidth: 1, borderColor: .label)
        
        enterNickNameTextField.layer.borderWidth = 1
        enterNickNameTextField.layer.borderColor = UIColor.label.cgColor
        enterNickNameTextField.layer.cornerRadius = 12
        enterNickNameTextField.textColor = .label
        enterNickNameTextField.autocorrectionType = .no
        
        dataTableView.layer.borderWidth = 1
        dataTableView.layer.borderColor = UIColor.label.cgColor
        dataTableView.layer.cornerRadius = 12
    }
    
    // MARK : Functions
    func getUserId(username: String){
        let apiKey = "2ZqNEkfjn7Mk1M9iQrExfg"

        let url = URL(string: "https://v1.rocketapi.io/instagram/user/get_info_by_id")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")

        let parameters: [String: Any] = [
            "username": username
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = jsonData


        let semaphore = DispatchSemaphore(value: 0)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            defer {
                semaphore.signal()
            }

            if let error = error {
                print("Hata: \(error)")
                return
            }

            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let response = json["response"] as? [String: Any],
                       let body = response["body"] as? [String: Any],
                       let user = body["user"] as? [String: Any],
                       let userId = user["id"] as? String {
                        print("User ID : \(userId)")
                        
                    }
                } catch {
                    print("JSON ayrıştırma hatası: \(error)")
                }
            }
        }

        task.resume()

        semaphore.wait()
    }


    
    func getInstagramFollowers(userID: Int, count: Int) {
        let baseURL = "https://v1.rocketapi.io/instagram/user/get_followers"
        let apiKey = "2ZqNEkfjn7Mk1M9iQrExfg"
        
        guard let url = URL(string: baseURL) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let parameters: [String: Any] = [
            "id": userID,
            "count": count
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
        } catch {
            print("Error encoding parameters: \(error)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response")
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Response JSON: \(json)")
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }
        }
        
        task.resume()
    }
    
    // MARK : Delegate Functions
    
    // MARK : Actions
    @IBAction func searchTapped(_ sender: Any) {
        print("Search tapped.")
//        getUserId(username: "demiirrkerem")
        getInstagramFollowers(userID: 59414464862, count: 20)
        print(enterNickNameTextField.text!)
    }
    
    @IBAction func findTapped(_ sender: Any) {
        print("Find tapped.")
    }
    
    @IBAction func clearTapped(_ sender: Any) {
        print("Clear tapped.")
    }
}
