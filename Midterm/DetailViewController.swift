
//
//  CountryViewController.swift
//  Midterm
//
//  Created by Тогжан Салимова on 10/16/20.
//  Copyright © 2020 Тогжан Салимова. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryTableView.dequeueReusableCell(withIdentifier: "Cell") as! Custom2TableViewCell
        cell.name.text = fetchedCountry[indexPath.row].country
        cell.region.text =  fetchedCountry[indexPath.row].region
        return cell
    }
    
    
    @IBOutlet weak var countryTableView: UITableView!
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 200;
       }
    
    var fetchedCountry = [Countries]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryTableView.dataSource = self
        parseData()
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
                        let region = eachCountry["region"] as! String
                        
                        self.fetchedCountry.append(Countries(country: country, region: region))
                    }
                    self.countryTableView.reloadData()
                }
                catch {
                    print("Error")
                }
            }
        }
        task.resume()
    }

    
}

class Countries {
    var country : String
    var region: String
    init(country : String , region : String){
        self.country = country
        self.region = region
        
    }
}
