//
//  MappingViewController.swift
//  Spider
//
//  Created by Mitch Treece on 5/27/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import Spider

class MappingViewController: UIViewController {
    
    fileprivate var tableView: UITableView!
    fileprivate var users = [User]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Object Mapping"
        view.backgroundColor = UIColor.groupTableViewBackground
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        
        loadUsers()
        
    }
    
    private func loadUsers() {
        
        users.removeAll()
        tableView.reloadData()
        
        Spider.web.get("https://jsonplaceholder.typicode.com/users") { (response) in
            
            guard let array = response.jsonArray(), response.error == nil else {
                
                var message = "There was an error fetching the data"
                if let error = response.error {
                    message = error.localizedDescription
                }
                
                print(message)
                return
                
            }
            
            if let users = Weaver<User>(array).mapArray() {
                
                self.users = users
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            
        }
        
    }
    
}

extension MappingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") {
            let user = users[indexPath.row]
            cell.textLabel?.text = "\(user.name)"
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
