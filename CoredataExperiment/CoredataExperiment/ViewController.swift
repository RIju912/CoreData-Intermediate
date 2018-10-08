//
//  ViewController.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 12/07/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavigationController()
        setupNavigationRightbarItem()
    }

    
}

//MARK: UI related stuffs
extension ViewController{
    
    func setUpNavigationController(){
        navigationItem.title = "Schools"
        navigationController?.navigationBar.isTranslucent = false
        let transparentBlueColor = UIColor(red: 108/255, green: 164/255, blue: 200/255, alpha: 0.5)
        navigationController?.navigationBar.barTintColor = transparentBlueColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    func setupNavigationRightbarItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(performRightBarAction))
    }
    
    @objc func performRightBarAction(){
        print("Right bar action.")
    }
}
