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
    
    let datePicker: UIDatePicker = {
        let dPicker = UIDatePicker()
        dPicker.translatesAutoresizingMaskIntoConstraints = false
        dPicker.datePickerMode = .date
        return dPicker
    }()
    
    lazy var companyImageView: UIImageView = {
        let imageV = UIImageView(image: #imageLiteral(resourceName: "photo_empty"))
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.isUserInteractionEnabled = true
        imageV.contentMode = .scaleAspectFill
        imageV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhotoSelection)))
        return imageV
    }()
    
    //: not tightly coupled
    weak var addSchoolDelegate: SchoolAdditionDelegate?
    var schoolName: School?{
        didSet{
            enterNameTextField.text = schoolName?.name
            guard let founded = schoolName?.founded else { return }
            datePicker.date = founded
            if let companyImageData = schoolName?.imageData{
                companyImageView.image = UIImage(data: companyImageData)
                setupCircularImageStyle()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationUI()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = schoolName == nil ? "Add School" : "Edit School"
    }

}

//MARK: UI Related stuffs
extension SchoolAdditionController{
    
    private func setupNavigationUI(){
        view.backgroundColor = .blue
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    private func setupUI(){
        setupBackgroundView()
        setupCompanyImageView()
        setupNameLabel()
        setupTextField()
        setupDatePicker()
    }
    
    private func setupBackgroundView(){
        view.addSubview(lightBackgroundView)
        lightBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBackgroundView.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
    private func setupCompanyImageView(){
        view.addSubview(companyImageView)
        companyImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        companyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        companyImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupNameLabel(){
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: companyImageView.bottomAnchor).isActive = true
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
    
    private func setupDatePicker(){
        view.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        datePicker.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: lightBackgroundView.bottomAnchor).isActive = true
    }
    
    
    @objc func handleBack(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupCircularImageStyle(){
        companyImageView.layer.cornerRadius = companyImageView.frame.width / 2
        companyImageView.clipsToBounds = true
    }
    
}


//MARK: Core Data Related stuffs
extension SchoolAdditionController{
    
    @objc func handleSave(){
        schoolName == nil ? createCompany() : saveEditedCompany()
    }
    
    private func saveEditedCompany(){
        guard let editedSchool = schoolName else { return }
        editedSchool.name = enterNameTextField.text
        editedSchool.founded = datePicker.date
        if let companyImage = companyImageView.image{
            let imageData = UIImageJPEGRepresentation(companyImage, 0.8)
            editedSchool.imageData = imageData
        }
        do{
            try CoreDataSingleton.shared.persistantContainer.viewContext.save()
            dismiss(animated: true){
                self.addSchoolDelegate?.editSchoolDelegate(school: editedSchool)
            }
        }catch let saveErr{
            print("Failed with \(saveErr)")
        }
    }
    
    private func createCompany(){
        //Get the entity to insert the new object
        let school = NSEntityDescription.insertNewObject(forEntityName: "School", into: CoreDataSingleton.shared.persistantContainer.viewContext)
        guard let name = self.enterNameTextField.text else { return }
        //set the value for the entity
        school.setValue(name, forKey: "name")
        school.setValue(datePicker.date, forKey: "founded")
        if let companyImage = companyImageView.image{
            let imageData = UIImageJPEGRepresentation(companyImage, 0.8)
            school.setValue(imageData, forKey: "imageData")
        }
        
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
