//
//  NetworkService.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 21/11/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import Foundation
import CoreData

struct NetworkService {
    
    static let shared = NetworkService()
    
    let urlString = "https://api.letsbuildthatapp.com/intermediate_training/companies"
    
    func fetchJsonCompanies(){
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let err = err{
                print("Failed with ", err)
                return
            }
            
            guard let data = data else { return }
            let jsonDecoder = JSONDecoder()
            do{
                let dataDecoded = try jsonDecoder.decode([SchoolJson].self, from: data)
                
                let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                privateContext.parent = CoreDataSingleton.shared.persistantContainer.viewContext
                
                dataDecoded.forEach({ (dataCompany) in
                    let schoolCompany = School(context: privateContext)
                    schoolCompany.name = dataCompany.name
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy"
                    let date = dateFormatter.date(from: dataCompany.founded)
                    schoolCompany.founded = date
                    schoolCompany.imageData = Data()
                    
                    dataCompany.employees?.forEach({ (dataEmployees) in
                        let studentEmployee = Student(context: privateContext)
                        
                        studentEmployee.name = dataEmployees.name
                        studentEmployee.type = dataEmployees.type
                        let employeeStudentInformation = StudentInformation(context: privateContext)
                        let birthDayDate = dateFormatter.date(from: dataEmployees.birthday)
                        employeeStudentInformation.birthday = birthDayDate
                        studentEmployee.studentInformation = employeeStudentInformation
                        studentEmployee.school = schoolCompany
                    })
                    
                    do{
                        try privateContext.save()
                        try privateContext.parent?.save()
                    } catch let err{
                        print("Failed with ", err)
                    }
                })
                
            } catch let err{
                print("Failed with ", err)
            }
            
        }.resume()
    }
}
