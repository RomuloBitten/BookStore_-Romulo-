//
//  BookListViewController.swift
//  BookStore_[Romulo]
//
//  Created by Romulo B. Mantovani on 15/12/22.
//

import Foundation
import UIKit

class BookListViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupUI()
    }
    
    func setupUI() {
        self.view.addSubview(self.tableView)
        
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: .zero).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .zero).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: .zero).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: .zero).isActive = true
    }
}
