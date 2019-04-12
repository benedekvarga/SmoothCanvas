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

    // 🤷🏼‍♂️ You definitely should not save path here, it's just an example, and I wanted to keep it simple...
    var savedPath: [PathSegment]!

    override func loadView() {
        super.loadView()
        let myView = View()
        view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        myView.inputModeControl.addTarget(self, action: #selector(inputChanged), for: .valueChanged)
        addButtonActions()
        adddSliderValueDidChangeAction()
    }

    private func addButtonActions() {
        myView.clearButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        myView.blackButton.addTarget(self, action: #selector(colorButtonAction), for: .touchUpInside)
        myView.redButton.addTarget(self, action: #selector(colorButtonAction), for: .touchUpInside)
        myView.blueButton.addTarget(self, action: #selector(colorButtonAction), for: .touchUpInside)
        myView.saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        myView.loadButton.addTarget(self, action: #selector(loadButtonAction), for: .touchUpInside)
    }

    @objc private func colorButtonAction(sender: UIButton!) {
        myView.blackButton.isActive = sender == myView.blackButton
        myView.redButton.isActive = sender == myView.redButton
        myView.blueButton.isActive = sender == myView.blueButton
        guard let colorButton = sender as? ColorPickerButton else { return }

        // 💪 You can modify the line color by setting `lineColor` property of SmoothCanvasView
        myView.canvas.lineColor = colorButton.color
    }

    @objc private func buttonAction(sender: UIButton!) {
        // 💪 You can clear the whole canvas by calling `clearCanvas()` method of SmoothCanvasView
        myView.canvas.clearCanvas()
    }

    @objc private func inputChanged(sender: UISegmentedControl!) {
        // 💪 You can limit writing only with Apple Pencil or any stylus by setting `isWritingByTouchEnabled` property of SmoothCanvasView to false.
        myView.canvas.isWritingByTouchEnabled = sender.selectedSegmentIndex != 0
    }

    private func adddSliderValueDidChangeAction() {
        myView.lineWidthSlider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
    }

    @objc private func sliderValueDidChange(sender: UISlider!) {
        // 💪 You can customize the width of the line by setting the `lineWidth` property of SmoothCanvasView.
        myView.canvas.lineWidth = CGFloat(1.4 * sender.value).rounded(toPlaces: 2)
        myView.lineWidthLabel.text = "Line width: \(CGFloat(sender.value).rounded(toPlaces: 2))"
    }

    @objc private func saveButtonAction() {
        // 💪 You can get the whole path by the `writingPath` property of SmoothCanvasView.
        savedPath = myView.canvas.writingPath
    }

    @objc private func loadButtonAction() {
        guard let path = savedPath else {
            print("Saved path is not available.")
            return
        }
        // 💪 You can load a previously saved path by calling the `load([PathSegment])` method of SmoothCanvasView.
        myView.canvas.load(path: path)
    }
}

fileprivate extension CGFloat {
    func rounded(toPlaces places: Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return (self * divisor).rounded() / divisor
    }
}

