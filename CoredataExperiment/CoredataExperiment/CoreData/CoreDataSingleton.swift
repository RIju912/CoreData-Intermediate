//
//  CoreDataSingleton.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 09/10/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import CoreData


struct CoreDataSingleton{
    static let shared = CoreDataSingleton()
    
    let persistantContainer: NSPersistentContainer = {
        // Get the container
        let persistantContainer = NSPersistentContainer(name: "CoredataExperiment")
        //instruct the container to load the Persistent Stores
        persistantContainer.loadPersistentStores { (storeDescription, err) in
            if let err = err{
                fatalError("failed with \(err)")
            }
        }
        return persistantContainer
    }()
}
