//
//  VCUtils.swift
//  FutFacts
//
//  Created by Trenton Regis on 8/8/25.
//
import UIKit

class VCUtils
{
    public static func makeNavbarBold(for vc: UIViewController)
    {
        vc.navigationController?.navigationBar.prefersLargeTitles = true
        
        vc.navigationController?.navigationBar.barTintColor = UIColor(named: "backgroundColor")
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "backgroundColor")!
        appearance.titleTextAttributes = [.foregroundColor: UIColor(.white)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "AccentColor")!]
        vc.navigationItem.standardAppearance = appearance
        vc.navigationItem.scrollEdgeAppearance = appearance
    }
}


