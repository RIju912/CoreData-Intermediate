//
//  School.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 09/10/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import Foundation
import UIKit

struct SchoolJson: Decodable {
    let name: String
    let founded: String
    var employees: [EmployeeJson]?
}

struct EmployeeJson: Decodable{
    let name: String
    let birthday: String
    let type: String
}
