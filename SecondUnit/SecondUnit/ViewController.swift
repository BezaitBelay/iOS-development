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
        if let name = UserDefaults.standard.string(forKey: "logged"){

            messageLabel.text = "Logged in as \(name)"
            setToLogin()
        }
        else
        {
            messageLabel.text = ""
        }
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    @IBAction func registerClicked(_ sender: Any) {
        guard let name = usernameField.text ,let password = passwordLabel.text else { return }
        
        if UserDefaults.standard.string(forKey: name) != nil {
            
            messageLabel.text = "User already exists"
            
        } else {
            UserDefaults.standard.set(password, forKey: name)
            messageLabel.text = "Logged in as \(name)"
            setToLogin()
            clearFields()
            
            UserDefaults.standard.set(name, forKey: "logged")
        }
    }
    @IBAction func logoutClocked(_ sender: Any) {
        logoutButton.isHidden = true
        loginButton.isHidden = false
        registerButton.isHidden = false
        UserDefaults.standard.set(nil, forKey: "logged")
        messageLabel.text = ""
    }
    @IBAction func loginClicked(_ sender: Any) {
        guard let name = usernameField.text, let password = passwordLabel.text else { return }
        guard let existing = UserDefaults.standard.string(forKey: name) else { messageLabel.text = "Username does not exist"; return }
        
        if existing == password {
            setToLogin()
            clearFields()
            messageLabel.text = "Logged in as \(name)"
            UserDefaults.standard.set(name, forKey: "logged")
            
        } else {
            messageLabel.text = "Wrong password"
        }
    }
    
    func setToLogin(){
        loginButton.isHidden = true
        registerButton.isHidden = true
        logoutButton.isHidden = false
    }
    
    func clearFields(){
        usernameField.text = ""
        passwordLabel.text = ""
    }
}

