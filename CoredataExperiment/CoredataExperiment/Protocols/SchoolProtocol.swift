//
//  SchoolProtocol.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 09/10/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import Foundation

//Custom Delegation [Abstract]
protocol SchoolAdditionDelegate: class{
    func addSchoolDelegate(school: School)
    func editSchoolDelegate(school: School)
}

protocol StudentAdditionDelegate: class{
    func didAddStudentDelegate(student: Student)
}
