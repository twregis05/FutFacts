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
        
        
    
    
    /* MARK: Validators
     
        These validators ensure that
     
     */
    
    // Valid names should be alphabetical, and be between 1-50 characters.
   
    
    
}
