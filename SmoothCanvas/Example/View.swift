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
        canvas.layer.borderColor = UIColor.gray.cgColor
        canvas.layer.borderWidth = 1
        canvas.layer.cornerRadius = 8
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

    let redButton = ColorPickerButton(title: "red", color: .red)
    let blueButton = ColorPickerButton(title: "blue", color: .blue)
    let blackButton = ColorPickerButton(title: "black", color: .black)

    let lineWidthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Line width: 1"
        label.textAlignment = .left
        return label
    }()

    let lineWidthSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maximumValue = 5
        slider.minimumValue = 1
        slider.value = 1
        slider.tintColor = .black
        return slider
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(clearButton)
        NSLayoutConstraint.activate([
            clearButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            clearButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ])
        addSubview(inputModeControl)
        NSLayoutConstraint.activate([
            inputModeControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            inputModeControl.topAnchor.constraint(equalTo: topAnchor, constant: 50)
        ])
        addSubview(blackButton)
        blackButton.isActive = true
        NSLayoutConstraint.activate([
            blackButton.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            blackButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            blackButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        addSubview(redButton)
        redButton.isActive = false
        NSLayoutConstraint.activate([
            redButton.topAnchor.constraint(equalTo: blackButton.bottomAnchor, constant: 25),
            redButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            redButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        addSubview(blueButton)
        blueButton.isActive = false
        NSLayoutConstraint.activate([
            blueButton.topAnchor.constraint(equalTo: redButton.bottomAnchor, constant: 25),
            blueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            blueButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        addSubview(canvas)
        NSLayoutConstraint.activate([
            canvas.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            canvas.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            canvas.topAnchor.constraint(equalTo: blueButton.bottomAnchor, constant: 25),
            canvas.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -65)
        ])
        addSubview(lineWidthSlider)
        NSLayoutConstraint.activate([
            lineWidthSlider.centerYAnchor.constraint(equalTo: clearButton.centerYAnchor),
            lineWidthSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            lineWidthSlider.trailingAnchor.constraint(equalTo: clearButton.leadingAnchor, constant: -25)
        ])
        addSubview(lineWidthLabel)
        NSLayoutConstraint.activate([
            lineWidthLabel.leadingAnchor.constraint(equalTo: lineWidthSlider.leadingAnchor),
            lineWidthLabel.bottomAnchor.constraint(equalTo: lineWidthSlider.topAnchor, constant: -12)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
