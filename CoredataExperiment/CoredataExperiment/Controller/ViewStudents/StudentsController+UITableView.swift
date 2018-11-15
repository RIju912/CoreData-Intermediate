//
//  StudentsController+UITableView.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 09/11/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit


//MARK: UITableView Stuffs
extension StudentsController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNamedStudents[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: studentCellID, for: indexPath)
        let studentsDetails = allNamedStudents[indexPath.section][indexPath.row]
        if let birthDate = studentsDetails.studentInformation?.birthday{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM dd, yyyy"
            cell.textLabel?.text = "\(studentsDetails.name ?? "")   \(dateFormatter.string(from: birthDate))"
        }
        cell.backgroundColor = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allNamedStudents.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IntendedLabel()
        if section == 0{
            label.text = "Short Names"
        }else if section == 1{
            label.text = "Long Names"
        }else{
            label.text = "Really Long Names"
        }
        label.backgroundColor = UIColor(red: 224/255, green: 255/255, blue: 255/255, alpha: 1)
        label.textColor = UIColor.darkGray
        
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
