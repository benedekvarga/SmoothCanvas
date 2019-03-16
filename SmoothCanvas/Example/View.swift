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
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
