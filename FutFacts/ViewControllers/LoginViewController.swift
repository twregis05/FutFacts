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
    
    var loadingView: UIView?
    
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
    
    // dismisses keyboard from screen
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
        let keyText = usernameField.text ?? ""
        let pwText = pwField.text ?? ""
        
        if keyText.isEmpty || pwText.isEmpty
        {
            showErrorMessage(with: "Please fill in all fields.")
            return
        }
        
        showLoadingScreen()
        AuthManager.login(key: keyText, password: pwText)
        {
            result in
            
            switch result
            {
                case .success:
                    self.hideLoadingScreen()
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                case .failure(let error):
                    self.hideLoadingScreen()
                    print(error)
                    self.showErrorMessage(with: error.localizedDescription)
            }
        }
        
        
    }
    
    func showLoadingScreen()
    {
        let loadingView = UIView(frame: view.bounds)
        loadingView.backgroundColor = UIColor(named: "backgroundColor")
        loadingView.alpha = 0.7
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = loadingView.center
        activityIndicator.startAnimating()
        loadingView.addSubview(activityIndicator)
        view.addSubview(loadingView)
        
        self.loadingView = loadingView
    }
    
    func hideLoadingScreen()
    {
        self.loadingView?.removeFromSuperview()
        self.loadingView = nil
    }
    
    func showErrorMessage(with message: String)
    {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default) { _ in
            alert.dismiss(animated: true)
        })
        present(alert, animated: true)
    }


}

