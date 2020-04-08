//
//  ViewController.swift
//  SecondUnit
//
//  Created by Dynamo Software on 2.04.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutButton.isHidden = true
        messageLabel.text = ""
    }
    @IBAction func registerClicked(_ sender: Any) {
        guard let name = usernameField.text ,let password = passwordLabel.text else { return }
        
        if UserDefaults.standard.string(forKey: name) != nil {
            
            messageLabel.text = "User already exists"
            
        } else {
            UserDefaults.standard.set(password, forKey: name)
            loginButton.isHidden = true
            registerButton.isHidden = true
            logoutButton.isHidden = false
            messageLabel.text = ""
        }
    }
    @IBAction func logoutClocked(_ sender: Any) {
        logoutButton.isHidden = true
        loginButton.isHidden = false
        registerButton.isHidden = false
    }
    @IBAction func loginClicked(_ sender: Any) {
        guard let name = usernameField.text, let password = passwordLabel.text else { return }
        
        guard let existing = UserDefaults.standard.string(forKey: name)
            else { return }
        
        if existing == password {
            loginButton.isHidden = true
            registerButton.isHidden = true
            logoutButton.isHidden = false
            messageLabel.text = ""
            
        } else {
            messageLabel.text = "Wrong password"
        }
    }
}

