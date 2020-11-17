import UIKit

class DevelopersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var users = [Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJSON {
        self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.textLabel?.text = users[indexPath.row].firstName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserViewController {
            destination.user = users[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
    let urlString = "https://reqres.in/api/users"
    
    guard let url = URL(string: urlString) else {
        print("URL is not valid")
        return
    }
    
    let session = URLSession.shared
    let request = URLRequest(url: url)
    
    let task = session.dataTask(with: request) {
        (data, response, error) in
        guard error == nil else {
            print("error: \(error!)")
            return
        }
        
        guard let responseData = data else {
            print("did not receive data")
            return
        }
        
        do {
            guard let data = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String : Any] else {
                print("error trying convert json to data")
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let dataArr = data["data"] as? [[String : Any]] ?? [[String : Any]]()
            let myArray = try JSONSerialization.data(withJSONObject: dataArr)
            self.users = try decoder.decode([Data].self, from: myArray)
        }
        catch {
            print("error")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    task.resume()
    }
}
