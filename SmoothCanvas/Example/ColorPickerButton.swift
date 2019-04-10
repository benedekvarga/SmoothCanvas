//
//  ColorPickerButton.swift
//  SmoothCanvas
//
//  Created by Benedek Varga on 2019. 04. 04..
//  Copyright © 2019. Benedek Varga. All rights reserved.
//

import UIKit

final class ColorPickerButton: UIButton {
    var isActive = false {
        didSet {
            setColor()
        }
    }
    var color: UIColor = .clear

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        layer.cornerRadius = 4
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    convenience init(title: String, color: UIColor = .black) {
        self.init()
        self.color = color
        setTitle(title, for: .normal)
        setColor()
    }

    private func setColor() {
        layer.borderColor = color.cgColor
        layer.borderWidth = 1
        if isActive {
            setTitleColor(.white, for: .normal)
            layer.borderColor = color.cgColor
            backgroundColor = color
        } else {
            setTitleColor(color, for: .normal)
            layer.borderColor = color.cgColor
            backgroundColor = .clear
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
