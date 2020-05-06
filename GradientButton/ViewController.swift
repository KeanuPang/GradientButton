//
//  ViewController.swift
//  GradientButton
//
//  Created by 龐誠恩 on 2020/5/6.
//  Copyright © 2020 Keanu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var button: DrawOnButton = {
        let button = DrawOnButton()
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 120)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(hex: "D6D7CC").cgColor
        self.view.addSubview(button)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.button.center = view.center
    }
}

class DrawOnButton: UIButton {
    override func layoutSubviews() {
        _ = layer.sublayers?.filter {
            $0.name == "gradientLayer" || $0.name == "linesLayer"
        }.map { $0.removeFromSuperlayer() }

        self.drawGradientColors()
        self.drawLines()
    }

    private func drawGradientColors() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "gradientLayer"
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(hex: "CF5953").cgColor,
            UIColor(hex: "F3CA51").cgColor,
            UIColor(hex: "F1CB4F").cgColor,
            UIColor(hex: "CEC852").cgColor,
            UIColor(hex: "6BA55A").cgColor,
        ]
        gradientLayer.locations = [0.0, 0.25, 0.5, 0.75, 1.0]
        self.layer.addSublayer(gradientLayer)
    }

    private func drawLines() {
        let linesLayer = CAShapeLayer()
        linesLayer.name = "linesLayer"
        linesLayer.frame = self.bounds

        linesLayer.lineWidth = 1.0
        linesLayer.strokeColor = UIColor(hex: "DBDCDB").cgColor

        let part = self.frame.height / 4
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 0, y: part * 1))
        linePath.addLine(to: CGPoint(x: self.frame.width, y: part * 1))
        linePath.move(to: CGPoint(x: 0, y: part * 2))
        linePath.addLine(to: CGPoint(x: self.frame.width, y: part * 2))
        linePath.move(to: CGPoint(x: 0, y: part * 3))
        linePath.addLine(to: CGPoint(x: self.frame.width, y: part * 3))
        linesLayer.path = linePath.cgPath
        self.layer.addSublayer(linesLayer)
    }
}
