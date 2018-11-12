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
        return studentsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: studentCellID, for: indexPath)
        let studentsDetails = studentsArray[indexPath.row]
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
}
