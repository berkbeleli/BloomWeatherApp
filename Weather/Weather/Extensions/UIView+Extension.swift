//
//  UIView+Extension.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-02.
//

import UIKit

extension UIView {
    func dropShadow(color: CGColor = UIColor.white.cgColor, opacity: Float = 1, radius: CGFloat = 45, offset: CGSize = CGSize(width: 0, height: 0)) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func addGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.opacity =  0.8
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0.3)
        gradient.frame = self.bounds
        gradient.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gradient, at: 0)
    }
}
