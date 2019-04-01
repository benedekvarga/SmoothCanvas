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

    let eraserButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("eraser", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.isUserInteractionEnabled = true
        return button
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
        addSubview(eraserButton)
        NSLayoutConstraint.activate([
            eraserButton.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            eraserButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
