//
//  Validators.swift
//  FutFacts
//
//  Created by Trenton Regis on 8/11/25.
//

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
