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
    var studentsArray = [Student]()
    let studentCellID = "studentCellID"
    var shortNameStudents = [Student]()
    var longNameStudents = [Student]()
    var reallyLongNameStudents = [Student]()
    var allNamedStudents = [[Student]]()
    
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
        // Fetching Students School wise.
        
        guard let schoolStudents = schoolDetails?.students?.allObjects as? [Student] else { return }
        
        shortNameStudents = schoolStudents.filter({ (student) -> Bool in
            if let count = student.name?.count{
                return count < 6
            }
            return false
        })
        
        longNameStudents = schoolStudents.filter({ (student) -> Bool in
            if let count = student.name?.count{
                return count > 6 && count < 9
            }
            return false
        })
        
        reallyLongNameStudents = schoolStudents.filter({ (student) -> Bool in
            if let count = student.name?.count{
                return count > 9
            }
            return false
        })
        
        allNamedStudents = [
            shortNameStudents,
            longNameStudents,
            reallyLongNameStudents
        ]
    }
}


extension StudentsController: StudentAdditionDelegate{
    
    func didAddStudentDelegate(student: Student) {
        studentsArray.append(student)
        tableView.reloadData()
    }

}
