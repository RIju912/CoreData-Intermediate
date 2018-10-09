//
//  SchoolCreationController.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 09/10/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit

class SchoolAdditionController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

extension SchoolAdditionController{
    
    func setupUI(){
        view.backgroundColor = .blue
        navigationItem.title = "Add School"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
    }
    
    @objc func handleBack(){
        dismiss(animated: true, completion: nil)
    }
}
