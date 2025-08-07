//
//  HomeViewController.swift
//  FutFacts
//
//  Created by Trenton Regis on 8/6/25.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Home"
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "backgroundColor")
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "backgroundColor")!
        appearance.titleTextAttributes = [.foregroundColor: UIColor(.white)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "AccentColor")!]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        
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
