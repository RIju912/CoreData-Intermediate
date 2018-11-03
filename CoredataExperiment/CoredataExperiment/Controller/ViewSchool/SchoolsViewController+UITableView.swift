//
//  SchoolsViewController+UITableView.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 03/11/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import Foundation
import UIKit

//MARK: TableView Delegate & Datasource
extension SchoolsViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! SchoolsCell
        let school = schools[indexPath.row]
        cell.schoolDetails = school
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
