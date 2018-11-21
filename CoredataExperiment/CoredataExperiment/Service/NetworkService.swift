//
//  NetworkService.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 21/11/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import Foundation

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
                dataDecoded.forEach({ (dataCompany) in
                    print(dataCompany.name)
                    
                    dataCompany.employees?.forEach({ (employees) in
                        print(employees.name)
                    })
                })
                
            } catch let err{
                print("Failed with ", err)
            }
            
        }.resume()
    }
}
