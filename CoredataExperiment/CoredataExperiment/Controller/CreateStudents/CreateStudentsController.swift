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
    
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Birthday"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let enterbirthdayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "MM/DD/YYYY"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let segmentedControlField: UISegmentedControl = {
        let items = ["Monitor", "Star", "All-Rounder"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        sc.tintColor = .blue
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    weak var delegate: StudentAdditionDelegate?
    var schoolDetails: School?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: UI Staffs
extension CreateStudentsController {
    
    func setupUI(){
        setupNavUI()
        _ = setupBackgroundView(height: 170)
        setupNameLabel()
        setupTextField()
        setupBirthdayLabel()
        setupBirthdayTextField()
        setupSegmentedControl()
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
    
    private func setupBirthdayLabel(){
        view.addSubview(birthdayLabel)
        birthdayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        birthdayLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        birthdayLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        birthdayLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupBirthdayTextField(){
        view.addSubview(enterbirthdayTextField)
        enterbirthdayTextField.topAnchor.constraint(equalTo: birthdayLabel.topAnchor).isActive = true
        enterbirthdayTextField.leftAnchor.constraint(equalTo: birthdayLabel.rightAnchor).isActive = true
        enterbirthdayTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        enterbirthdayTextField.bottomAnchor.constraint(equalTo: birthdayLabel.bottomAnchor).isActive = true
    }
    
    private func setupSegmentedControl(){
        view.addSubview(segmentedControlField)
        segmentedControlField.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 8).isActive = true
        segmentedControlField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        segmentedControlField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        segmentedControlField.heightAnchor.constraint(equalToConstant: 34).isActive = true
    }
    
    
    func showError(tittle: String, description: String){
        let alertController = UIAlertController(title: tittle, message: description, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}

//MARK: Core data Stuffs
extension CreateStudentsController{
    
    @objc func handleSavedStudent(){
        guard let studentName = enterNameTextField.text else { return }
        guard let schoolDetails = schoolDetails else { return }
        guard let birthdayText = enterbirthdayTextField.text else { return }
        
        if birthdayText.isEmpty{
            showError(tittle: "Empty Birthday", description: "You've entered an empty birthday")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        guard let birthDayDate = dateFormatter.date(from: birthdayText) else{
            showError(tittle: "Invalid date", description: "You've entered an invalid birthday date.")
            return
        }
        
        
        let studentTuple = CoreDataSingleton.shared.createStudent(studentName: studentName, schoolDetails: schoolDetails, birthDate: birthDayDate, studentType: segmentedControlField.titleForSegment(at: segmentedControlField.selectedSegmentIndex) ?? "Monitor")
        
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
