//
//  StudentsController.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 09/11/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit

class StudentsController: UITableViewController{
    
    var schoolDetails: School?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = schoolDetails?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRightBarButton(selector: #selector(performPlusBarAction))
    }
    
    @objc private func performPlusBarAction(){
        let createStudentsVC = CreateStudentsController()
        let navController = UINavigationController(rootViewController: createStudentsVC)
        present(navController, animated: true, completion: nil)
    }
}
