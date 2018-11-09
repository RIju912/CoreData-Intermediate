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
    
    func setupBackgroundView(height: CGFloat) -> UIView{
        let lightBackgroundView = UIView()
        lightBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        lightBackgroundView.backgroundColor = UIColor(red: 224/255, green: 255/255, blue: 255/255, alpha: 1)
        
        view.addSubview(lightBackgroundView)
        lightBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBackgroundView.heightAnchor.constraint(equalToConstant: height).isActive = true
        return lightBackgroundView
    }
    
}
