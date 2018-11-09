//
//  UIViewController+extensions.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 09/10/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController{
    
    override open var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}

extension UIViewController{
    
    func setupRightBarButton(selector: Selector){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: selector)
    }
    
    func setupBackBarButton(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
    }
    
    @objc func handleBack(){
        dismiss(animated: true, completion: nil)
    }
}
