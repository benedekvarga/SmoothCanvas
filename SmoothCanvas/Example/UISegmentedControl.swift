//
//  UISegmentedControl.swift
//  SmoothCanvas
//
//  Created by Benedek Varga on 2019. 04. 04..
//  Copyright © 2019. Benedek Varga. All rights reserved.
//

import UIKit

extension UISegmentedControl {
    func customize(color: UIColor) {
        backgroundColor = .clear
        layer.cornerRadius = 4
        tintColor = color
    }

}
