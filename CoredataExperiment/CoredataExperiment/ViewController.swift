//
//  ViewController.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 12/07/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavigationController()
        setupNavigationRightbarItem()
        setupTableView()
    }

    
}

//MARK: UI related stuffs
extension ViewController{
    
    func setUpNavigationController(){
        navigationItem.title = "Schools"
        navigationController?.navigationBar.isTranslucent = false
        let transparentBlueColor = UIColor(red: 108/255, green: 164/255, blue: 200/255, alpha: 0.8)
        navigationController?.navigationBar.barTintColor = transparentBlueColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    func setupNavigationRightbarItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(performRightBarAction))
    }
    
    func setupTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.separatorColor = .white
        //tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 9/255, green: 45/255, blue: 64/255, alpha: 0.8)
        tableView.tableFooterView = UIView()
    }
    
    @objc func performRightBarAction(){
        print("Right bar action.")
    }
}

//MARK: TableView Delegate & Datasource
extension ViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.backgroundColor = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)
        cell.textLabel?.text = "School Name"
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.textLabel?.textColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 209/255, green: 181/255, blue: 181/255, alpha: 1.0)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
