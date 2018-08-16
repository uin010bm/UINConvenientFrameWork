// 
//  UINShadow.swift
//  ConvenientSamples
//
//  Created by yu tanaka on 2018/08/01.
//  Copyright (c) 2018年 RC-Code, All rights reserved.
//

import UIKit

// presenter for adding shadow to uiview
public class UINShadowPresenter {
    
    /// Shape type of shadow - enum type
    /// - rect:    rect as view
    /// - circle:  circle shape
    /// - dynamic: no customize
    public enum DropShadowType {
        case rect, circle, dynamic
    }
    
    /// Add Shadow to View
    /// - parameter type:         shadow type
    /// - parameter color:        shadow color
    /// - parameter shadowOffset: offset
    public static func addDropShadow(view: UIView, type: DropShadowType = .dynamic, color: UIColor = UIColor.black, opacity: Float = 0.3, radius: CGFloat = 4.0, shadowOffset: CGSize = CGSize.zero) {
        view.layer.shadowOpacity = opacity
        view.layer.shadowRadius = radius
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowColor = color.cgColor
        
        switch type {
        case .circle:
            let halfWidth = view.frame.size.width * 0.5
            view.layer.shadowPath = UIBezierPath(arcCenter: CGPoint(x: halfWidth, y: halfWidth), radius: halfWidth, startAngle: 0.0, endAngle: CGFloat(Double.pi) * 2, clockwise: true).cgPath
            view.layer.shouldRasterize = true
            view.layer.rasterizationScale = UIScreen.main.scale
            
        case .rect:
            view.layer.shadowPath = UIBezierPath(roundedRect: view.frame, cornerRadius: view.layer.cornerRadius).cgPath
            view.layer.shouldRasterize = true
            view.layer.rasterizationScale = UIScreen.main.scale
            
        case .dynamic:
            view.layer.shouldRasterize = true
            view.layer.rasterizationScale = UIScreen.main.scale
        }
    }
}

/// MARK: - Extensions

// for UIView
/*
extension UIView {

    fileprivate func addDropShadow(type: UINShadowPresenter.DropShadowType = .dynamic, color: UIColor = UIColor.black, opacity: Float = 0.3, radius: CGFloat = 4.0, shadowOffset: CGSize = CGSize.zero) {
        UINShadowPresenter.addDropShadow(view: self, type: type, color: color, opacity: opacity, radius: radius, shadowOffset: shadowOffset)
    }
}
 */
