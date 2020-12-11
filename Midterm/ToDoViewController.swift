//
//  ToDoViewController.swift
//  Midterm
//
//  Created by Тогжан Салимова on 12/9/20.
//  Copyright © 2020 Тогжан Салимова. All rights reserved.
//

import UIKit
import RealmSwift


class ToDoListItem: Object {
    @objc dynamic var item: String = ""
    @objc dynamic var date: Date = Date()
}

class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].item
        let sw = UISwitch(frame: CGRect(x:1, y:1, width: 20, height: 20))
        sw.isOn = false
        sw.addTarget(self, action: #selector(toggle(_:)), for: .valueChanged)
        cell.accessoryView = sw
        return cell
    }
    
    @objc func toggle(_ sender: UISwitch) {
        print("Done!")
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = data[indexPath.row]
        
        guard let vc = storyboard?.instantiateViewController(identifier: "view") as? ThingsViewController else {
            return
        }
        vc.item = item
        vc.deletionHandler = { [weak self] in
            self?.refresh()
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = item.item
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func didTapAddButton (){
        guard let vc = storyboard?.instantiateViewController(identifier:"enter") as? DatePickerViewController else {
        return
        }
        vc.completionHandler = {[ weak self] in
            self?.refresh()
        }
        vc.title = "New Item"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    func refresh(){
        data = realm.objects(ToDoListItem.self).map({ $0 })
        table.reloadData()
    }
    @IBOutlet var table: UITableView!
    
    private var data = [ToDoListItem]()
    private let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(ToDoListItem.self).map({ $0 })
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell" )
        table.allowsMultipleSelectionDuringEditing = true
        table.delegate = self
        table.dataSource = self
    }
}

