//
//  SearchViewController.swift
//  FutFacts
//
//  Created by Trenton Regis on 8/8/25.
//

import UIKit
import Nuke
import NukeExtensions

class SearchViewController: UIViewController
{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var loadingView: UIView?
    
    var results: [Any] = []
    let shared = TeamsClient.shared
    var searchText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
       
        updateSearchResults()
        tableView.reloadData()
        
        let nib = UINib(nibName: "SearchResultTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SearchResultTableViewCell")
        
        tableView.isScrollEnabled = true
        tableView.rowHeight = 100
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateSearchResults()
    {
        switch self.segmentedControl.selectedSegmentIndex
        {
        case 0:
            let leagues = TeamsClient.getLeagues()
            results = searchText.isEmpty ? leagues : leagues.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            break
        case 1:
            let teams = TeamsClient.shared.teams
            results = searchText.isEmpty ? teams : teams.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
            break
        case 2:
            let players = TeamsClient.shared.players
            results = searchText.isEmpty ? players : players.filter {
                $0.result.name.localizedCaseInsensitiveContains(searchText)
            }
            break
        case 3:
            let coaches = TeamsClient.shared.coaches
            results = searchText.isEmpty ? coaches : coaches.filter {
                $0.result.name.localizedCaseInsensitiveContains(searchText)
            }
            break
        default:
            results = []
        }
        tableView.reloadData()
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

    @IBAction func segmentChanged(_ sender: Any)
    {
        updateSearchResults()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as! SearchResultTableViewCell
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            if let results = results as? [League]
            {
                let result = results[indexPath.row]
                cell.name?.text = result.name
                cell.details?.text = result.country
                
                if cell.resultImage == nil {
                    print("❌ resultImage is nil for row \(indexPath.row)")
                }
                else
                {
                    NukeExtensions.loadImage(with: URL(string: result.emblem), into: cell.resultImage)
                }
            }
            break
        case 1:
            if let results = results as? [Team]
            {
                let result = results[indexPath.row]
                cell.name?.text = result.name
                cell.details?.text = "Competing in " + String(result.runningCompetitions.count) + " \(result.runningCompetitions.count == 1 ? "competition" : "competitions")"
                if cell.resultImage == nil {
                    print("❌ resultImage is nil for row \(indexPath.row)")
                }
                else
                {
                    NukeExtensions.loadImage(with: URL(string: result.crest!), into: cell.resultImage)
                }
            }
            break
        case 2:
            if let results = results as? [Player]
            {
                let result = results[indexPath.row]
                cell.name?.text = result.result.name
                cell.details?.text = "Playing for " + result.team.name
                
                if cell.resultImage == nil {
                    print("❌ resultImage is nil for row \(indexPath.row)")
                }
                else
                {
                    NukeExtensions.loadImage(with: URL(string: result.team.crest!), into: cell.resultImage)
                }
            }
            break
        case 3:
            if let results = results as? [Coach]
            {
                let result = results[indexPath.row]
                cell.name?.text = result.result.name
                cell.details?.text = "Coaching " + result.team.name
                
                if cell.resultImage == nil {
                    print("❌ resultImage is nil for row \(indexPath.row)")
                }
                else
                {
                    NukeExtensions.loadImage(with: URL(string: result.team.crest!), into: cell.resultImage)
                }
            }
            
        default:
            break
            
            
        }
        print("Cell class: \(type(of: cell))")
        print("name outlet is nil? \(cell.name == nil)")
        print("details outlet is nil? \(cell.details == nil)")
        print("resultImage outlet is nil? \(cell.resultImage == nil)")
        
        return cell
    }
}


extension SearchViewController: UISearchBarDelegate
{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.text = ""
        self.searchText = ""
        searchBar.endEditing(true)
        
        updateSearchResults()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        self.searchText = searchText
        updateSearchResults()
    }
}
