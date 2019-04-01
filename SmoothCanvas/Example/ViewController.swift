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

        myView.eraserButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    @objc func buttonAction(sender: UIButton!) {
        myView.canvas.isEraser.toggle()
        myView.eraserButton.setTitle(myView.canvas.isEraser ? "write" : "eraser", for: .normal)
    }
}

