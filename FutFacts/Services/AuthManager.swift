//
//  AuthManager.swift
//  FutFacts
//
//  Created by Trenton Regis on 8/9/25.
//

import FirebaseAuth
import Foundation



class AuthManager
{
    public static func signUp(firstName: String, lastName: String, username: String, email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    {
        let duplicateUsernameError = NSError(
            domain: "regis.FutFacts.duplicateUsernameError",
            code: 1001,
            userInfo: [NSLocalizedDescriptionKey: "Username already taken. Please choose a different username."]
        )
        
        DBManager.isUsernameAvailable(username: username)
        {
            isAvailable in
            if !isAvailable
            {
                completion(.failure(duplicateUsernameError))
                return
            }
            
            Auth.auth().createUser(withEmail: email, password: password)
            {
                result, error in
                if let error = error
                {
                    completion(.failure(error))
                    return
                }
                
                guard let user = result?.user else
                {
                    return
                }
                
                let uid = user.uid
                DBManager.createUserDocument(uid: uid, firstName: firstName, lastName: lastName, username: username, email: email)
                completion(.success(()))
            }
        }
        
    }
    
    // key can be either a username or an email
    /*
     1. if the key is not a valid email:
        1a. fetch the doc by querying by username
            (if said doc doesn't exist, complete with failure
        1b. set the key as the email from the doc
     2. directly log in using firebase
     3. take the email from the doc and use it to log in
     */
    public static func login(key: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    {
        // 1.
        var loginKey: String = key
        
        if !Validators.isValidEmail(key)
        {
            // 1a.
            DBManager.getUserDocumentByUsername(username: key)
            {
                result in
                
                let userNotFoundError = NSError(
                    domain: "regis.FutFacts.userNotFoundError",
                    code: 1101,
                    userInfo: [NSLocalizedDescriptionKey: "Invalid Username. Please try again."]
                )
                
                if let result = result
                {
                    loginKey = result.email
                    print("EMAIL:" + loginKey)
                    Auth.auth().signIn(withEmail: loginKey, password: password)
                    {
                        result, error in
                        
                        let invalidCredentialsError = NSError(
                            domain: "regis.FutFacts.invalidCredentialsError",
                            code: 1002,
                            userInfo: [NSLocalizedDescriptionKey: "Invalid Credentials. Please try again."]
                        )
                        
                        if let error = error as NSError?
                        {
                            if error.code == 17004
                            {
                                completion(.failure(invalidCredentialsError))
                            }
                            completion(.failure(error))
                            return
                        }
                        
                        completion(.success(()))
                        
                        
                    }
                    return
                }
                else
                {
                    completion(.failure(userNotFoundError))
                    return
                }
            }
            
        }
        else
        {
            Auth.auth().signIn(withEmail: loginKey, password: password)
            {
                result, error in
                
                let invalidCredentialsError = NSError(
                    domain: "regis.FutFacts.invalidCredentialsError",
                    code: 1002,
                    userInfo: [NSLocalizedDescriptionKey: "Invalid Credentials. Please try again."]
                )
                
                if let error = error as NSError?
                {
                    if error.code == 17004 || error.code == 17008
                    {
                        completion(.failure(invalidCredentialsError))
                    }
                    else
                    {
                        completion(.failure(error))
                    }
                    
                    return
                }
                
                completion(.success(()))
                
                
            }
            
            
            
        }
    }
    
    public static func logout()
    {
        try! Auth.auth().signOut()
        print("Logged out user")
    }
        
    
    // Valid names should be alphabetical, and be between 1-50 characters.
   
    
    
}

/*
 
MARK: Validators
These validators ensure that entries in sign-up fields are valid.
*/


class Validators
{
   // a valid (first or last) name is alphabetical, has no spaces, and is between 1-50 characters
   static func isValidName(_ name: String) -> Bool
   {
       let regex = try! Regex("^[A-Za-z\\-]{1,50}$")
       return name.wholeMatch(of: regex) != nil
   }

   // a valid username is alphanumeric, has no spaces, and is between 1-30 characters
   static func isValidUsername(_ username: String) -> Bool
   {
       let regex = try! Regex("^[A-Za-z0-9]{1,30}$")
       return username.wholeMatch(of: regex) != nil
   }

   // a valid email should contain an identifier (alphanumeric)@domain.(repeated?).(com, org, net, edu, gov, mil, int)
   // domains are be alphannumeric
   static func isValidEmail(_ email: String) -> Bool
   {
       let regex = try! Regex("^[A-Za-z0-9]([A-Za-z0-9_\\-\\.]*[A-Za-z0-9])*@([A-Za-z0-9]([A-Za-z0-9\\-]*[A-Za-z0-9])*\\.)+(com|org|net|edu|gov|mil|int|io|co|us)$")
       return email.wholeMatch(of: regex) != nil
   }

   // a valid password should contain at least 8 characters and must include at least 1 number.
   static func isValidPassword(_ password: String) -> Bool
   {
       return password.contains { $0.isNumber } && password.count >= 8
   }

}

