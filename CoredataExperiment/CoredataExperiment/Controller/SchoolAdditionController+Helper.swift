//
//  SchoolAdditionController+Helper.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 29/10/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import Foundation
import UIKit

//MARK: Image Picker Related stuff
extension SchoolAdditionController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @objc func handlePhotoSelection(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let originalImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            companyImageView.image = originalImage
        }else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            companyImageView.image = originalImage
        }
        setupCircularImageStyle()
        dismiss(animated: true, completion: nil)
    }
}
