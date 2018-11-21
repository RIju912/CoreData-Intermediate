//
//  SchoolsCell.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 03/11/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit
import Foundation

class SchoolsCell: UITableViewCell{
    
    let schoolImageView: UIImageView = {
        let imageV = UIImageView(image: #imageLiteral(resourceName: "photo_empty"))
        imageV.contentMode = .scaleAspectFill
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.layer.cornerRadius = 20
        imageV.clipsToBounds = true
        imageV.layer.borderColor = UIColor.blue.cgColor
        imageV.layer.borderWidth = 1
        return imageV
    }()
    
    let schoolFoundedLabel: UILabel = {
        let label = UILabel()
        label.text = "School Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    var schoolDetails: School?{
        didSet{
            if let imageData = schoolDetails?.imageData{
                schoolImageView.image = UIImage(data: imageData)
            }
            if let name = schoolDetails?.name, let foundedDate = schoolDetails?.founded{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM dd, yyyy"
                let formattedDate = dateFormatter.string(from: foundedDate)
                let concatenatedString = "\(name) - Founded: \(formattedDate)"
                schoolFoundedLabel.text = concatenatedString
            }else{
                schoolFoundedLabel.text = schoolDetails?.name
                //"\(schoolDetails?.name ?? "")  \(schoolDetails?.numberOfStudents ?? "") "
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)
        setupImageView()
        setupNameLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: UI setup methods
extension SchoolsCell{
    
    func setupImageView(){
        addSubview(schoolImageView)
        schoolImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        schoolImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        schoolImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        schoolImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func setupNameLabel(){
        addSubview(schoolFoundedLabel)
        schoolFoundedLabel.leftAnchor.constraint(equalTo: schoolImageView.rightAnchor, constant: 10).isActive = true
        schoolFoundedLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        schoolFoundedLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        schoolFoundedLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
