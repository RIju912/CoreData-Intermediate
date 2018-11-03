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
        tableView.register(SchoolsCell.self, forCellReuseIdentifier: "cellID")
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



//MARK: Core Data Related stuffs
extension SchoolsViewController{
    private func fetchCompanies(){
        self.schools = CoreDataSingleton.shared.fetchCompanies()
    }
}


