//
//  CountryViewController.swift
//  Midterm
//
//  Created by Тогжан Салимова on 10/16/20.
//  Copyright © 2020 Тогжан Салимова. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func searchBar(){
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        searchBar.delegate = self
        searchBar.showsScopeBar = true
        searchBar.tintColor = UIColor.lightGray
        searchBar.scopeButtonTitles = ["Country", "Capital"]
        self.countryTableView.tableHeaderView = searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            parseData()
        }
        else {
            if searchBar.selectedScopeButtonIndex == 0 {
                fetchedCountry = fetchedCountry.filter({ (country) -> Bool in
                                   return country.country.lowercased().contains(searchText.lowercased())
                               })
            }
            else {
                fetchedCountry = fetchedCountry.filter({ (country) -> Bool in
                    return country.capital.contains(searchText)
                })
            }
        }
        self.countryTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryTableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        cell.countryName.text = fetchedCountry[indexPath.row].country
        cell.countryCode.text = fetchedCountry[indexPath.row].alpha2Code
        cell.capital.text =  fetchedCountry[indexPath.row].capital
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;
    }
    
    @IBOutlet weak var countryTableView: UITableView!
    
    var fetchedCountry = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryTableView.dataSource = self
        parseData()
        searchBar()
        // Do any additional setup after loading the view.
    }
    
    func parseData(){
        let url = "https://restcountries.eu/rest/v1/all"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        let conf = URLSessionConfiguration.default
        let session = URLSession(configuration: conf, delegate: nil, delegateQueue: OperationQueue.main)

        let task = session.dataTask(with: request) { (data, response, error) in
            if (error != nil) {
                print("error")
            }
            else {
                do {
                    let fetchedData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSArray
                    for eachFetchedCountry in fetchedData {
                        let eachCountry = eachFetchedCountry as! [String : Any]
                        let country = eachCountry["name"] as! String
                        let capital = eachCountry["capital"] as! String
                        let alpha2Code = eachCountry["alpha2Code"] as! String
                        
                        self.fetchedCountry.append(Country(country: country, capital: capital, alpha2Code: alpha2Code))
                    }
                    self.countryTableView.reloadData()                }
                catch {
                    print("Error")
                }
            }
        }
        task.resume()
    }

    
}

class Country {
    var country : String
    var capital: String
    var alpha2Code: String
    init(country : String , capital : String, alpha2Code: String){
        self.country = country
        self.capital = capital
        self.alpha2Code = alpha2Code
        
    }
}
