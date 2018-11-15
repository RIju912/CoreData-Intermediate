//
//  UILabel+DrawText.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 15/11/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit

class IntendedLabel: UILabel{
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        let customRect = rect.inset(by: insets)
        super.drawText(in: customRect)
    }
}
