//
//  MainViewController+UITextField.swift
//  Storio
//
//  Created by Kerem Demir on 20.12.2023.
//

import UIKit

extension MainViewController: UITextFieldDelegate {
    
    func setupTextField(){
        enterNickNameTextField.delegate = self
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let usernameText = enterNickNameTextField.text {
            currentNickname = usernameText
        }
    }
    
}
