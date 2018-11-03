//
//  SchoolsViewController+CreateSchool.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 03/11/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit

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
