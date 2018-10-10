//
//  SchoolCreationController.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 09/10/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit
import CoreData

class SchoolAdditionController: UIViewController {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lightBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 224/255, green: 255/255, blue: 255/255, alpha: 1)
        return view
    }()
    
    let enterNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    //: not tightly coupled
    weak var addSchoolDelegate: SchoolAdditionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationUI()
        setupUI()
    }

}

//MARK: UI Related stuffs
extension SchoolAdditionController{
    
    private func setupNavigationUI(){
        view.backgroundColor = .blue
        navigationItem.title = "Add School"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    private func setupUI(){
        setupBackgroundView()
        setupNameLabel()
        setupTextField()
    }
    
    private func setupNameLabel(){
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupBackgroundView(){
        view.addSubview(lightBackgroundView)
        lightBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBackgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupTextField(){
        view.addSubview(enterNameTextField)
        enterNameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        enterNameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        enterNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        enterNameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
    }
    
    @objc func handleBack(){
        dismiss(animated: true, completion: nil)
    }
    
}


//MARK: Core Data Related stuffs
extension SchoolAdditionController{
    
    @objc func handleSave(){
        
        //Get the entity to insert the new object
        let school = NSEntityDescription.insertNewObject(forEntityName: "School", into: CoreDataSingleton.shared.persistantContainer.viewContext)
        guard let name = self.enterNameTextField.text else { return }
        //set the value for the entity
        school.setValue(name, forKey: "name")
        
        do{
            //save the value
            try CoreDataSingleton.shared.persistantContainer.viewContext.save()
            dismiss(animated: true){
                self.addSchoolDelegate?.addSchoolDelegate(school: school as! School)
            }
        }catch let saveErr{
            print("Failed with \(saveErr)")
        }
        
    }
}
