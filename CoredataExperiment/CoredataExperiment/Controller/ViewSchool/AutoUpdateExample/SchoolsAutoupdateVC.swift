//
//  SchoolsAutoupdateVC.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 20/11/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit
import CoreData

class SchoolsAutoupdateVC: UITableViewController, NSFetchedResultsControllerDelegate{
    
    lazy var fetchResultController: NSFetchedResultsController<School> = {
        
        let context = CoreDataSingleton.shared.persistantContainer.viewContext
        let fetchRequest: NSFetchRequest<School> = School.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: "name", cacheName: nil)
        
        frc.delegate = self
        do{
            try frc.performFetch()
        } catch let err{
            print("the err ", err)
        }
        
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Company Auto Updates"
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAdd)),
            UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(handleDelete))
        ]
        
        tableView.backgroundColor = UIColor(red: 9/255, green: 45/255, blue: 64/255, alpha: 1)
        tableView.register(SchoolsCell.self, forCellReuseIdentifier: cellId)
        
        callRefreshControl()
    }
    
    func callRefreshControl(){
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(makeServiceCall), for: .valueChanged)
        refreshControl.tintColor = .white
        self.refreshControl = refreshControl
    }
    
    @objc func makeServiceCall(){
        NetworkService.shared.fetchJsonCompanies()
        self.refreshControl?.endRefreshing()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    @objc private func handleAdd() {
        
        let context = CoreDataSingleton.shared.persistantContainer.viewContext
        
        let company = School(context: context)
        company.name = "ZZZ"
        
        do{
            try context.save()
        } catch let err{
            print("the err ", err)
        }
    }
    
    @objc private func handleDelete() {
        
        let request: NSFetchRequest<School> = School.fetchRequest()
        
//        request.predicate = NSPredicate(format: "name CONTAINS %@", "Z")
        
        let context = CoreDataSingleton.shared.persistantContainer.viewContext
        let companiesWithB = try? context.fetch(request) // don't use this try? in production
        
        companiesWithB?.forEach { (company) in
            context.delete(company)
        }
        
        try? context.save()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IntendedLabel()
        label.text = fetchResultController.sectionIndexTitles[section]
        label.backgroundColor = UIColor(red: 224/255, green: 255/255, blue: 255/255, alpha: 1)
        return label
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, sectionIndexTitleForSectionName sectionName: String) -> String? {
        return sectionName
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultController.sections![section].numberOfObjects
    }
    
    let cellId = "cellId"
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SchoolsCell
        
        let schoolDetails = fetchResultController.object(at: indexPath)
        
        cell.schoolDetails = schoolDetails
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentsController = StudentsController()
        studentsController.schoolDetails = fetchResultController.object(at: indexPath)
        navigationController?.pushViewController(studentsController, animated: true)
    }
}
