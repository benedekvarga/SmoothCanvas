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
        myView.canvas.clearCanvas(animated:false)
    }

    // Shake to clear screen
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        myView.canvas.clearCanvas(animated: true)
    }
}

