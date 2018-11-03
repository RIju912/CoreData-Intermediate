//
//  ViewController.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 12/07/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit
import CoreData

class SchoolsViewController: UITableViewController {

    var schools = [School]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Schools"
        view.backgroundColor = .white
        setupNavigationRightbarItem()
        setupNavigationLeftbarItem()
        setupTableView()
        fetchCompanies()
    }

    
}

//MARK: UI related stuffs
extension SchoolsViewController{
    
    func setupNavigationLeftbarItem(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(performResetAction))
    }
    
    func setupNavigationRightbarItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(performRightBarAction))
    }
    
    func setupTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.separatorColor = .white
        tableView.backgroundColor = UIColor(red: 9/255, green: 45/255, blue: 64/255, alpha: 0.8)
        tableView.tableFooterView = UIView()
    }
    
    @objc func performResetAction(){
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: School.fetchRequest())
        do{
            try CoreDataSingleton.shared.persistantContainer.viewContext.execute(batchDeleteRequest)
            var indexPathToRemove = [IndexPath]()
            for (index, _) in schools.enumerated(){
                let indexPath = IndexPath(row: index, section: 0)
                indexPathToRemove.append(indexPath)
            }
            schools.removeAll()
            tableView.deleteRows(at: indexPathToRemove, with: .left)
        } catch let err{
            print("fetch with \(err)")
        }
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
        if let name = school.name, let foundedDate = school.founded{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM dd, yyyy"
            let formattedDate = dateFormatter.string(from: foundedDate)
            let concatenatedString = "\(name) - Founded: \(formattedDate)"
            cell.textLabel?.text = concatenatedString
        }else{
           cell.textLabel?.text = school.name
        }
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.textLabel?.textColor = .white
        if let imageData = school.imageData{
            cell.imageView?.image = UIImage(data: imageData)
        }else{
            cell.imageView?.image = #imageLiteral(resourceName: "photo_empty")
        }
        
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
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No Schools added"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return schools.count == 0 ? 150 : 0
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deletingRowHandler)
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editingRowHandler)
        
        return [deleteAction, editAction]
    }
}

//MARK: Add School Delegate
extension SchoolsViewController: SchoolAdditionDelegate{
    func addSchoolDelegate(school: School){
        schools.append(school)
        let newIndexPath = IndexPath(row: schools.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    func editSchoolDelegate(school: School){
        guard let row = schools.index(of: school) else { return }
        tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .fade)
    }
}

//MARK: Core Data Related stuffs
extension SchoolsViewController{
    private func fetchCompanies(){
        //Fetch the List
        let fetchRequest = NSFetchRequest<School>(entityName: "School")
        do{
            let schoolName = try CoreDataSingleton.shared.persistantContainer.viewContext.fetch(fetchRequest)
            self.schools = schoolName
            tableView.reloadData()
        } catch let err{
            print("fetch with \(err)")
        }
        
    }
}


