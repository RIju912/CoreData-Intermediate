//
//  ViewController.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 12/07/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit

class SchoolsViewController: UITableViewController {

    var schools = [
        School(name: "RKMVP", founded: Date()),
        School(name: "BZS", founded: Date())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Schools"
        view.backgroundColor = .white
        setupNavigationRightbarItem()
        setupTableView()
    }

    
}

//MARK: UI related stuffs
extension SchoolsViewController{
    
    func setupNavigationRightbarItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(performRightBarAction))
    }
    
    func setupTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.separatorColor = .white
        tableView.backgroundColor = UIColor(red: 9/255, green: 45/255, blue: 64/255, alpha: 0.8)
        tableView.tableFooterView = UIView()
    }
    
    @objc func performRightBarAction(){
        let createSchoolController = SchoolAdditionController()
        let navCOntroller = CustomNavigationController(rootViewController: createSchoolController)
        createSchoolController.addSchoolDelegate = self
        present(navCOntroller, animated: true, completion: nil)
    }
}

//MARK: TableView Delegate & Datasource
extension SchoolsViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.backgroundColor = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)
        let school = schools[indexPath.row]
        cell.textLabel?.text = school.name
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.textLabel?.textColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.count
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



//MARK: Add School Delegate
extension SchoolsViewController: SchoolAdditionDelegate{
    func addSchoolDelegate(school: School){
        schools.append(school)
        let newIndexPath = IndexPath(row: schools.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
}
