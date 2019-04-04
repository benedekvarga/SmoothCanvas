//
//  View.swift
//  SmoothCanvas
//
//  Created by Benedek Varga on 2019. 03. 16..
//  Copyright © 2019. Benedek Varga. All rights reserved.
//

import UIKit

class View: UIView {
    let canvas: SmoothCanvasView = {
        let canvas = SmoothCanvasView()
        canvas.isUserInteractionEnabled = true
        canvas.translatesAutoresizingMaskIntoConstraints = false
        return canvas
    }()

    let clearButton = CustomButton(title: "Clear Canvas", color: .red)
    let inputModeControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Pencil Only", "All"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        control.customize(color: .black)
        return control
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(canvas)
        NSLayoutConstraint.activate([
            canvas.leadingAnchor.constraint(equalTo: leadingAnchor),
            canvas.trailingAnchor.constraint(equalTo: trailingAnchor),
            canvas.topAnchor.constraint(equalTo: topAnchor),
            canvas.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        addSubview(clearButton)
        NSLayoutConstraint.activate([
            clearButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            clearButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ])
        addSubview(inputModeControl)
        NSLayoutConstraint.activate([
            inputModeControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            inputModeControl.topAnchor.constraint(equalTo: topAnchor, constant: 50)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
