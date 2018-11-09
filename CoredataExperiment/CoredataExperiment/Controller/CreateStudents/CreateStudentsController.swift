//
//  CreateStudentsController.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 09/11/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit

class CreateStudentsController: UIViewController{
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let enterNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    weak var delegate: StudentAdditionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension CreateStudentsController {
    
    func setupUI(){
        setupNavUI()
        _ = setupBackgroundView(height: 60)
        setupNameLabel()
        setupTextField()
        
    }
    
    private func setupNavUI(){
        navigationItem.title = "Create Student"
        setupBackBarButton()
        handleSaveButton(selector: #selector(handleSavedStudent))
    }
    
    private func setupNameLabel(){
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupTextField(){
        view.addSubview(enterNameTextField)
        enterNameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        enterNameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        enterNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        enterNameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
    }
    
    @objc func handleSavedStudent(){
        guard let studentName = enterNameTextField.text else { return }
        let studentTuple = CoreDataSingleton.shared.createStudent(studentName: studentName)
        
        if let err = studentTuple.1{
            print(err)
        }else{
            guard let studentDetails = studentTuple.0 else { return }
            dismiss(animated: true) {
                self.delegate?.didAddStudentDelegate(student: studentDetails)
            }
        }
    }
    
}
