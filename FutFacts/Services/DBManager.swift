//
//  DBManager.swift
//  FutFacts
//
//  Created by Trenton Regis on 8/8/25.
//


import FirebaseAuth
import FirebaseFirestoreInternalWrapper
import FirebaseFirestore
import Foundation

struct User: Codable
{
    var firstName: String
    var lastName: String
    var username: String
    var email: String
    var profilePic: String?  // Store as base64 in FireStore
    var favTeam: String?
    var followedPlayers: [String]
    var followedTeams: [String]
    var followedLeagues: [String]
    let createdAt: Date
    
    func toDictionary() -> [String: Any]
    {
        return [
            "firstName" : firstName,
            "lastName" : lastName,
            "username" : username,
            "email" : email,
            "profilePic" : profilePic,
            "favTeam" : favTeam,
            "followedPlayers" : followedPlayers,
            "followedTeams" : followedTeams,
            "followedLeagues" : followedLeagues,
            "createdAt" : createdAt
        ]
    }
    
    init?(from doc: DocumentSnapshot)
    {
        guard let data = doc.data() else
        {
            return nil
        }
        
        self.firstName = data["firstName"] as! String
        self.lastName = data["lastName"] as! String
        self.username = data["username"] as! String
        self.email = data["email"] as! String
        self.profilePic = data["profilePic"] as? String
        self.favTeam = data["favTeam"] as? String
        self.followedPlayers = data["followedPlayers"] as! [String]
        self.followedTeams = data["followedTeams"] as! [String]
        self.followedLeagues = data["followedLeagues"] as! [String]
        self.createdAt = (data["createdAt"] as? Timestamp)?.dateValue() ?? Date()
    }
    
    init(firstName: String, lastName: String, username: String, email: String)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.email = email
        self.profilePic = nil
        self.favTeam = nil
        self.followedPlayers = []
        self.followedTeams = []
        self.followedLeagues = []
        self.createdAt = Date()
    }
    
    
}

class DBManager
{
    
    
    public static func createUserDocument(uid: String, firstName: String, lastName: String, username: String, email: String)
    {
        let user = User(
            firstName: firstName,
            lastName: lastName,
            username: username,
            email: email
        )
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).setData(user.toDictionary())
    }
    
    public static func getUserDocumentByUsername(username: String, completion: @escaping (User?) -> Void)
    {
        let db = Firestore.firestore().collection("users")
        db.whereField("username", isEqualTo: username).getDocuments()
        {
            querySnapshot, error in
            
            if let error = error
            {
                print(error)
                completion(nil)
                return
            }
            
            let documents = querySnapshot?.documents ?? []
            
            if documents.isEmpty
            {
                completion(nil)
            }
            else
            {
                let userData = documents[0] as DocumentSnapshot
                let user = User(from: userData)
                completion(user)
            }
        }
        
    }
    
    public static func isUsernameAvailable(username: String, completion: @escaping (Bool) -> Void)
    {
        let db = Firestore.firestore()
        
        db.collection("users").whereField("username", isEqualTo: username)
            .getDocuments
        {
            querySnapshot, error in
            
            if let error = error
            {
                print("Error checking username: \(error)")
                completion(false) // Assume unavailable on error
                return
            }
            
            let isAvailable = querySnapshot?.documents.isEmpty ?? false
            completion(isAvailable)
        }
    }
}
