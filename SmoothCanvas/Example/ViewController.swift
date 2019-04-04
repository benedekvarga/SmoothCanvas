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
        myView.clearButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        myView.inputModeControl.addTarget(self, action: #selector(inputChanged), for: .valueChanged)
    }

    // You can clear the whole canvas.
    @objc func buttonAction(sender: UIButton!) {
        myView.canvas.clearCanvas()
    }

    // You can enable or disable writing with fingers.
    @objc func inputChanged(sender: UISegmentedControl!) {
        myView.canvas.isFingerWritingEnabled = sender.selectedSegmentIndex != 0
    }
}

