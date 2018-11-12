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
        self.studentsArray = schoolStudents
//        let studentFetchRequest = NSFetchRequest<Student>(entityName: "Student")
//
//        do{
//            let studentsFetched = try CoreDataSingleton.shared.persistantContainer.viewContext.fetch(studentFetchRequest)
//            self.studentsArray = studentsFetched
//
//        }catch let err{
//            print("Failed to save:", err)
//        }
    }
}


extension StudentsController: StudentAdditionDelegate{
    
    func didAddStudentDelegate(student: Student) {
        studentsArray.append(student)
        tableView.reloadData()
    }

}
