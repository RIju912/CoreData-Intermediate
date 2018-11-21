//
//  CustomMigrationPolicy.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 21/11/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import CoreData


class CustomMigrationPolicy: NSEntityMigrationPolicy{
    
    @objc func transformNumEmployees(forNum: NSNumber) -> String{
        if forNum.intValue > 150{
            return "Small"
        }else {
            return "Very Big"
        }
    }
}
