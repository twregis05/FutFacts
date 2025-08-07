//
//  LoginViewController.swift
//  FutFacts
//
//  Created by Trenton Regis on 8/6/25.
//

import UIKit
import BCrypt

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        usernameField.delegate = self
        pwField.delegate = self
        configureKeyboardDismiss()
        
    }
    
    func configureKeyboardDismiss()
    {
        // enable tap to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // enable swipe down to dismiss keyboard
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func login(_ sender: UIButton)
    {
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
    

}

