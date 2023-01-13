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
        self.view.backgroundColor = .systemGroupedBackground
        
        self.tableView = UITableView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        self.tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "UserCell"
        )
        
        loadUsers()
        
    }
    
    private func loadUsers() {
        
        Spider.web
            .get("https://jsonplaceholder.typicode.com/users")
            .decodeResponse([User].self) { response in
            
                switch response.result {
                case .success(let users):
                    
                    self.users = users
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                case .failure(let error): print(error.localizedDescription)
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
