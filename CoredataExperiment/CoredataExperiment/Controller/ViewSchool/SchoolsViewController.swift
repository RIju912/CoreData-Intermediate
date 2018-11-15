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
        fetchSchools()
    }

    
}

//MARK: UI related stuffs
extension SchoolsViewController{
    
    func setupNavigationLeftbarItem(){
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(performResetAction)),
            UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(doUpdates))
        ]
    }
    
    func setupNavigationRightbarItem(){
        setupRightBarButton(selector: #selector(performRightBarAction))
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
    
    @objc func doUpdates(){
        // Context isn't thread safe, to perform something or update core data in background we use performBackgroundTask.
        CoreDataSingleton.shared.persistantContainer.performBackgroundTask ({ (backGroundContext) in
            
            let request: NSFetchRequest<School> = School.fetchRequest()
            
            do{
                let schoolData = try backGroundContext.fetch(request)
                schoolData.forEach({ (school) in
                    school.name = "C : \(school.name ?? "")"
                })
                
                do{
                    try backGroundContext.save()
                    DispatchQueue.main.async {
                        CoreDataSingleton.shared.persistantContainer.viewContext.reset()
                        self.schools = CoreDataSingleton.shared.fetchSchools()
                        self.tableView.reloadData()
                    }
                    
                }catch let err{
                    print("Failed with an ", err)
                }
                
            }catch let err{
                print("Failed with an ", err)
            }
            
        })
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
    private func fetchSchools(){
        self.schools = CoreDataSingleton.shared.fetchSchools()
    }
}


