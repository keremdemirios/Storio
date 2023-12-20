//
//  MainViewController.swift
//  Storio
//
//  Created by Kerem Demir on 19.12.2023.
//

import UIKit

class MainViewController: UIViewController {
    // MARK : Data Variables
    var followersData: [String] = []
    var currentNickname:String = "First"
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
        setupTextField()
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
    
    // MARK : Get User ID
    func getUserId(username: String, completion: @escaping (String?) -> Void) {
        let apiKey = "2ZqNEkfjn7Mk1M9iQrExfg"
        let url = URL(string: "https://v1.rocketapi.io/instagram/user/get_info")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let parameters: [String: Any] = [
            "username": username
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error encoding parameters: \(error)")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Hata: \(error)")
                completion(nil)
                return
            }
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let response = json["response"] as? [String: Any],
                       let body = response["body"] as? [String: Any],
                       let data = body["data"] as? [String: Any],
                       let user = data["user"] as? [String: Any],
                       let userId = user["id"] as? String {
                        print("USER ID : \(userId)")
                        completion(userId)
                    } else {
                        completion(nil)
                    }
                } catch {
                    print("JSON ayrıştırma hatası: \(error)")
                    completion(nil)
                }
            }
        }
        task.resume()
    }
    
    // MARK : Get Followers
    func getInstagramFollowers(username: String, count: Int, completion: @escaping () -> Void) {
        let baseURL = "https://v1.rocketapi.io/instagram/user/get_followers"
        let apiKey = "2ZqNEkfjn7Mk1M9iQrExfg"
        let username = enterNickNameTextField.text ?? "instagram"
        
        getUserId(username: username) { userId in
            if let userId = userId {
                guard let url = URL(string: baseURL) else {
                    print("Invalid URL")
                    return
                }
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")
                
                let parameters: [String: Any] = [
                    "id": userId,
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
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                               let response = json["response"] as? [String: Any],
                               let body = response["body"] as? [String: Any],
                               let users = body["users"] as? [[String: Any]] {
                                
                                // Kullanıcı adlarını al
                                self.followersData = users.compactMap { user in
                                    return user["username"] as? String
                                }
                                
                                // Artık followers dizisini kullanabilirsiniz.
                                print("Followers Data: \(self.followersData)")
                                print("Followers Data : \(self.followersData.count)")
                                
                                // TableView'ı güncelle
                                DispatchQueue.main.async {
                                    self.dataTableView.reloadData()
                                }
                                
                                // completion closure'ını çağır
                                completion()
                            }
                        } catch {
                            print("Error parsing JSON: \(error)")
                        }
                    }
                }
                task.resume()
            } else {
                print("Could not get username.")
            }
            
        }
    }
    
    // MARK : Delegate Functions
    
    // MARK : Actions
    @IBAction func searchTapped(_ sender: Any) {
        print("Search tapped.")
        //        getInstagramFollowers(userID: 59414464862, count: 20)
//        getInstagramFollowers(userID: 59414464862, count: 50) {
//            print("Followers data retrieved and tableview reloaded.")
//        }
        getInstagramFollowers(username: enterNickNameTextField.text!, count: 20) {
            print("Followers data retrieved and tableview reloaded.")
        }
        print(enterNickNameTextField.text!)
    }
    
    @IBAction func findTapped(_ sender: Any) {
        print("Find tapped.")
    }
    
    @IBAction func clearTapped(_ sender: Any) {
        print("Clear tapped.")
    }
}
