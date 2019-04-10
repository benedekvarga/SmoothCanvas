//
//  ViewController.swift
//  SmoothCanvas
//
//  Created by Benedek Varga on 2019. 03. 16..
//  Copyright © 2019. Benedek Varga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var myView: View! { return view as? View }

    override func loadView() {
        super.loadView()
        let myView = View()
        view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        myView.inputModeControl.addTarget(self, action: #selector(inputChanged), for: .valueChanged)
        addButtonActions()
    }

    private func addButtonActions() {
        myView.clearButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        myView.blackButton.addTarget(self, action: #selector(colorButtonAction), for: .touchUpInside)
        myView.redButton.addTarget(self, action: #selector(colorButtonAction), for: .touchUpInside)
        myView.blueButton.addTarget(self, action: #selector(colorButtonAction), for: .touchUpInside)
    }

    @objc private func colorButtonAction(sender: UIButton!) {
        myView.blackButton.isActive = sender == myView.blackButton
        myView.redButton.isActive = sender == myView.redButton
        myView.blueButton.isActive = sender == myView.blueButton
        guard let colorButton = sender as? ColorPickerButton else { return }
        // You can modify the line color by setting `lineColor` property of SmoothCanvasView
        myView.canvas.lineColor = colorButton.color
    }

    // You can clear the whole canvas by calling `clearCanvas()` method of SmoothCanvasView
    @objc func buttonAction(sender: UIButton!) {
        myView.canvas.clearCanvas()
    }

    // You can limit writing only with Apple Pencil or any stylus by setting `isWritingByTouchEnabled` property of SmoothCanvasView to false.
    @objc func inputChanged(sender: UISegmentedControl!) {
        myView.canvas.isWritingByTouchEnabled = sender.selectedSegmentIndex != 0
    }
}

