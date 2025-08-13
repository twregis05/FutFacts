//
//  SignUpViewController.swift
//  FutFacts
//
//  Created by Trenton Regis on 8/6/25.
//

import UIKit
import FirebaseCore

class SignUpViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var confirmPwTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        userTextField.delegate = self
        emailTextField.delegate = self
        pwTextField.delegate = self
        confirmPwTextField.delegate = self
        configureKeyboardDismiss()
        
        if let app = FirebaseApp.app()
        {
            print(app.name)
        }
        else
        {
            print("uh oh")
        }
    }
    
    func configureKeyboardDismiss()
    {
        // enable tap to dismiss keyboard
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        // enable swipe to dismiss keyboard
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    // enables pressing return to dismiss keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    
    // MARK: Sign Up functionality
    
    @IBAction func signUpButtonClicked(_ sender: UIButton)
    {
        if !Validators.isValidName(firstNameTextField.text ?? "")
        {
            showErrorMessage(with: "First name must be alphabetical, cannot contain spaces, and must be between 1-50 characters.")
        }
        
        else if !Validators.isValidName(lastNameTextField.text ?? "")
        {
            showErrorMessage(with: "Last name must be alphabetical, cannot contain spaces, and must be between 1-50 characters.")
        }
        
        else if !Validators.isValidUsername(userTextField.text ?? "")
        {
            showErrorMessage(with: "Username must be alphanumeric, cannot contain spaces, and must be between 1-30 characters.")
        }
        
        else if !Validators.isValidEmail(emailTextField.text ?? "")
        {
            showErrorMessage(with: "Invalid Email. Please try again.")
        }
        
        else if !Validators.isValidPassword(pwTextField.text ?? "")
        {
            showErrorMessage(with: "Password must contain 8 characters, one of which must be a number.")
        }
        
        else if !((pwTextField.text ?? "") == (confirmPwTextField.text ?? ""))
        {
            showErrorMessage(with: "Passwords must match.")
        }
        
        else
        {
            AuthManager.signUp(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, username: userTextField.text!, email: emailTextField.text!, password: pwTextField.text!)
            {
                result in
                switch result
                {
                    case .success:
                        self.successfulPopup()
                    case .failure(let error):
                        print(error)
                        self.showErrorMessage(with: error.localizedDescription)
                    
                }
            }
        }
        
        
        
    }
    
    func showErrorMessage(with message: String)
    {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default) { _ in
            alert.dismiss(animated: true)
        })
        present(alert, animated: true)
    }
    
    func successfulPopup()
    {
        let alert = UIAlertController(title: "Success!", message: "Sign up successful!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Back to login", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
