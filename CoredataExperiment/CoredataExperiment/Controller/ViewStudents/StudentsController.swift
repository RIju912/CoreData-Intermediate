//
//  StudentsController.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 09/11/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit
import CoreData

class StudentsController: UITableViewController{
    
    var schoolDetails: School?
    let studentCellID = "studentCellID"
    
    var allCategoryStudents = [[Student]]()
    var allStudentTypes = [
        StudentType.Star,
        StudentType.AllRounder,
        StudentType.Monitor
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = schoolDetails?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRightBarButton(selector: #selector(performPlusBarAction))
        fetchStudents()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: studentCellID)
    }
    
    @objc private func performPlusBarAction(){
        let createStudentsVC = CreateStudentsController()
        createStudentsVC.delegate = self
        createStudentsVC.schoolDetails = self.schoolDetails
        let navController = UINavigationController(rootViewController: createStudentsVC)
        present(navController, animated: true, completion: nil)
    }
}

//MARK: Core data Stuffs
extension StudentsController{
    
    private func fetchStudents(){
        // Fetching Students Category wise.
        
        guard let schoolStudents = schoolDetails?.students?.allObjects as? [Student] else { return }
        
        allCategoryStudents = []
        allStudentTypes.forEach { (studentType) in
            allCategoryStudents.append(
                schoolStudents.filter { $0.type == studentType.rawValue }
            )
        }
    }
}


extension StudentsController: StudentAdditionDelegate{
    
    func didAddStudentDelegate(student: Student) {
        guard let section = allStudentTypes.index(of: StudentType(rawValue: student.type!)!) else { return }
        let row = allCategoryStudents[section].count
        let insertionIndexPath = IndexPath(row: row, section: section)
        allCategoryStudents[section].append(student)
        tableView.insertRows(at: [insertionIndexPath], with: .middle)
    }

}
