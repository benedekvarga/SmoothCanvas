//
//  CustomButton.swift
//  SmoothCanvas
//
//  Created by Benedek Varga on 2019. 04. 04..
//  Copyright © 2019. Benedek Varga. All rights reserved.
//

import Foundation
import UIKit

final class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        layer.borderWidth = 1
        layer.cornerRadius = 4
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    convenience init(title: String, color: UIColor = .black) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        setTitleColor(color.withAlphaComponent(0.5), for: .highlighted)
        layer.borderColor = color.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
