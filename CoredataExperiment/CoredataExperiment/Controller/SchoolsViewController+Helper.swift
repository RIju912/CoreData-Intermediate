//
//  SchoolsViewController+Helper.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 10/10/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import Foundation
import UIKit

//MARK: Helper Methods
extension SchoolsViewController{
    
    func editingRowHandler(action: UITableViewRowAction, indexPath: IndexPath){
        let createSchoolController = SchoolAdditionController()
        createSchoolController.addSchoolDelegate = self
        createSchoolController.schoolName = schools[indexPath.row]
        let navCOntroller = CustomNavigationController(rootViewController: createSchoolController)
        present(navCOntroller, animated: true, completion: nil)
    }
    
    func deletingRowHandler(action: UITableViewRowAction, indexPath: IndexPath){
        let deletedSchool = self.schools[indexPath.row]
        self.schools.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        CoreDataSingleton.shared.persistantContainer.viewContext.delete(deletedSchool)
        do{
            try CoreDataSingleton.shared.persistantContainer.viewContext.save()
        }catch let saveErr{
            print("Failed with \(saveErr)")
        }
    }
    
}
