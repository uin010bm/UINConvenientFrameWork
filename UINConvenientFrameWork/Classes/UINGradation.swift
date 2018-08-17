// 
//  UINGradation.swift
//  UINConvenientFrameWork
//
//  Created by yu tanaka on 2018/08/01.
//  Copyright (c) 2018年 RC-Code, Inc. All rights reserved.
//

import UIKit
import CoreGraphics

public class UINGradationPresenter {
    
    /// starting point
    public enum GradationStart {
        case top, bottom, right, left, topLeft, topRight, bottomLeft, bottomRight
    }
    
    /// generate gradation color image
    /// - parameter size:           image size
    /// - parameter startPoint:     start point of gradation drawing
    /// - parameter endPoint:       end point of gradation drawing
    /// - parameter colors:         specify color array to be gradated
    /// - parameter givenLocations: specify the position of color change
    /// - returns: UIImage instance
    public static func generateGradationImage(size: CGSize, startPoint: CGPoint, endPoint: CGPoint, colors: [UIColor], locations givenLocations: [CGFloat]? = nil) -> UIImage {
        UIGraphicsBeginImageContext(size)
        
        if let context = UIGraphicsGetCurrentContext() {
            
            let colorspace = CGColorSpaceCreateDeviceRGB()
            
            /// components
            var components: [CGFloat] = []
            
            var r: CGFloat = 0.0
            var g: CGFloat = 0.0
            var b: CGFloat = 0.0
            var a: CGFloat = 0.0
            colors.forEach { color in
                color.getRed(&r, green: &g, blue: &b, alpha: &a)
                components.append(r)
                components.append(g)
                components.append(b)
                components.append(a)
            }
            
            /// locations
            var locations: [CGFloat] = []
            if givenLocations != nil {
                locations = givenLocations!
            } else {
                let delta: CGFloat = 1.0 / CGFloat(colors.count - 1)
                var location: CGFloat = 0.0
                colors.forEach { color in
                    locations.append(location)
                    location += delta
                }
            }
            
            if let gradient = CGGradient(colorSpace: colorspace, colorComponents: components, locations: locations, count: Int(colors.count)) {
                context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
            }
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    /// generate with enum type
    public static func generateGradationImage(size: CGSize, startFrom: GradationStart, colors: [UIColor], locations: [CGFloat]? = nil) -> UIImage {
        var startPoint: CGPoint
        var endPoint: CGPoint
        let maxlength = max(size.width, size.height)
        let minlength = min(size.width, size.height)
        let adjust: CGFloat = (maxlength - minlength) * 0.25
        
        switch startFrom {
        case .top:
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: 0, y: size.height)
        case .bottom:
            startPoint = CGPoint(x: 0, y: size.height)
            endPoint = CGPoint(x: 0, y: 0)
        case .right:
            startPoint = CGPoint(x: size.width, y: 0)
            endPoint = CGPoint(x: 0, y: 0)
        case .left:
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: size.width, y: 0)
        case .topLeft:
            if (size.width < size.height) {
                startPoint = CGPoint(x: -adjust, y: adjust)
                endPoint = CGPoint(x: size.width + adjust, y: size.height - adjust)
            } else {
                startPoint = CGPoint(x: adjust, y: -adjust)
                endPoint = CGPoint(x: size.width - adjust, y: size.height + adjust)
            }
        case .topRight:
            startPoint = CGPoint(x: size.width, y: 0)
            endPoint = CGPoint(x: 0, y: size.height)
        case .bottomLeft:
            startPoint = CGPoint(x: 0, y: size.height)
            endPoint = CGPoint(x: size.width, y: 0)
        case .bottomRight:
            startPoint = CGPoint(x: size.width, y: size.height)
            endPoint = CGPoint(x: 0, y: 0)
        }
        return UINGradationPresenter.generateGradationImage(size: size, startPoint: startPoint, endPoint: endPoint, colors: colors, locations: locations)
    }
}
