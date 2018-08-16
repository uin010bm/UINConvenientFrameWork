// 
//  UINProgressView.swift
//  ConvenientSamples
//
//  Created by yu tanaka on 2018/08/02.
//  Copyright (c) 2018年 CyberAgent, Inc. All rights reserved.
//

import UIKit
import CoreGraphics

// progress gauge view
public class UINProgressView: UIView, CAAnimationDelegate {
    
    // MARK: - enum
    
    //  progress gauge direction
    public enum Direction {
        case left, right, top, bottom
    }
    
    // MARK: - struct
    
    // animate setting
    //   duration: animation timeinterval
    //   delay: delay timeinterval
    //   dumping: damping coefficient of spring animation
    //   initialVelocity: initial velocity of spring animation
    //   mass: mass of spring
    //   stiffness: stiffness of spring
    //   timingFunction: animation easing
    public struct AnimSetting {
        let duration: TimeInterval
        let delay: TimeInterval
        let dumping: CGFloat            // os def = 10
        let initialVelocity: CGFloat    // os def = 0
        let mass: CGFloat               // os def = 1
        let stiffness: CGFloat          // os def = 100
        let timingFunction: CAMediaTimingFunction
        
        public init(duration: TimeInterval = 1, delay: TimeInterval = 0, dumping: CGFloat = 10, initialVelocity: CGFloat = 0, mass: CGFloat = 1, stiffness: CGFloat = 60, timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)) {
            self.duration = duration
            self.delay = delay
            self.dumping = dumping
            self.initialVelocity = initialVelocity
            self.mass = mass
            self.stiffness = stiffness
            self.timingFunction = timingFunction
        }
    }
    
    
    // MARK: - Properties
    
    /// Views
    /// gradation view
    private var gradationView: UIView?
    /// mask
    private var layerMask: CALayer?
    
    
    /// Params
    
    // gradation color
    private var _fillColors: [UIColor] = [.white]
    
    // color changing direction
    private var _fillColorsDirection: UINGradationPresenter.GradationStart = .left
    
    // guage direction
    private var _direction: Direction = .left

    // mask view radius
    private var _fillRadius: CGFloat?

    // add dark shadow gradation
    private var _overlayEnabled: Bool = false
    
    // button radius
    private var _radius: CGFloat?
    
    // animation setting
    //   nil = no animation
    private var _animationSetting: AnimSetting?
    
    private var animationQueue: [(Float, Float)] = []

    // MARK: - Functions

    public func fillColor(color: UIColor, overlayEnabled: Bool = false) -> UINProgressView {
        _fillColors = [color]
        _overlayEnabled = overlayEnabled
        return self
    }
    
    public func fillColor(colors: [UIColor]) -> UINProgressView {
        _fillColors = colors
        return self
    }
    
    public func direction(direction: Direction) -> UINProgressView {
        _direction = direction
        return self
    }
    
    public func fillRadius(colors: CGFloat) -> UINProgressView {
        _fillRadius = colors
        return self
    }
    
    public func fillColorsDirection(direction: UINGradationPresenter.GradationStart ) -> UINProgressView {
        _fillColorsDirection = direction
        return self
    }
    
    public func radius(value: CGFloat?) -> UINProgressView {
        _radius = value
        return self
    }
    
    public func animation(setting: AnimSetting?) -> UINProgressView {
        _animationSetting = setting
        return self
    }
    
    
    /// draw gradation view and mask layer
    public func draw() -> UINProgressView {
        
        alpha = 0

        // remove old layer and view
        layerMask?.removeFromSuperlayer()
        gradationView?.removeFromSuperview()
        
        // create gradient view
        gradationView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        guard let gradationView = gradationView else { return self }
        
        // create cgimage
        let imageView = UIImageView(image: UINGradationPresenter.generateGradationImage(size: gradationView.frame.size, startFrom: _fillColorsDirection, colors: _fillColors))
        imageView.frame = CGRect(x: 0, y: 0, width: gradationView.frame.width, height: gradationView.frame.height)
        gradationView.addSubview(imageView)
        
        // create overlay image
        if _overlayEnabled {
            let overlayImageView = UIImageView(image: UINGradationPresenter.generateGradationImage(size: gradationView.frame.size, startFrom: _fillColorsDirection, colors: [.clear, .black]))
            overlayImageView.alpha = 0.6
            gradationView.addSubview(overlayImageView)
        }

        // create mask
        layerMask = CALayer(layer: layer)
        guard let layerMask = layerMask else { return self }

        // setup mask
        // setup initial position
        let position: CGPoint
        switch _direction {
        case .left:
            position = CGPoint(x: -gradationView.frame.width, y: 0)
        case .right:
            position = CGPoint(x: gradationView.frame.width, y: 0)
        case .top:
            position = CGPoint(x: 0, y: -gradationView.frame.height)
        case .bottom:
            position = CGPoint(x: 0, y: gradationView.frame.height)
        }
        layerMask.frame.origin = position
        layerMask.frame.size = CGSize(width: gradationView.frame.width, height: gradationView.frame.height)
        
        if _animationSetting == nil {
            layerMask.frame.origin = CGPoint(x: 0, y: 0)
        }
        let maskImage = UIImage.getImageFromView(view: gradationView)
        layerMask.contents = maskImage.cgImage
        layerMask.cornerRadius = _fillRadius ?? 0
        layerMask.masksToBounds = true
        gradationView.layer.mask = layerMask

        addSubview(gradationView)
        
        return self
    }
    
    /// animation flow
    @discardableResult public func animation(max: Float, current: Float) -> UINProgressView {
        guard let targetView = gradationView, let layerMask = layerMask else { return self }
        
        let percentage: Float = current / max
        
        if let animSetting = _animationSetting {
            
            let beforePosition = CGPoint(x: layerMask.position.x, y: layerMask.position.y)
            let afterPosition: CGPoint
            
            switch _direction {
            case .left:
                afterPosition = CGPoint(x: -targetView.frame.width / 2 + targetView.frame.width * CGFloat(percentage), y: layerMask.position.y)
            case .right:
                afterPosition = CGPoint(x: targetView.frame.width * 1.5 - targetView.frame.width * CGFloat(percentage), y: layerMask.position.y)
            case .top:
                afterPosition = CGPoint(x: layerMask.position.x, y: -targetView.frame.height / 2 + targetView.frame.height * CGFloat(percentage))
            case .bottom:
                afterPosition = CGPoint(x: layerMask.position.x, y: targetView.frame.height * 1.5 - layerMask.frame.height * CGFloat(percentage))
            }
            
            if #available(iOS 9.0, *) {
                let spring = CASpringAnimation(keyPath: "position")
                spring.fromValue = beforePosition
                spring.toValue = afterPosition
                spring.beginTime = CACurrentMediaTime() + animSetting.delay
                spring.damping = animSetting.dumping
                spring.initialVelocity = animSetting.initialVelocity
                spring.mass = animSetting.mass
                spring.stiffness = animSetting.stiffness
                spring.duration = animSetting.duration
                spring.timingFunction = animSetting.timingFunction
                spring.isRemovedOnCompletion = false
                spring.fillMode = kCAFillModeForwards
                spring.delegate = self
                
                alpha = 1
                
                layerMask.add(spring, forKey: nil)
            } else {
                return self
            }
        } else {
            alpha = 1
        }
        
        return self
    }
}

extension UIImage {
    
    /// ViewをベースにUIImageを取得する
    /// - parameter view:   ベースとなるviewを指定
    /// - parameter opaque: alphaを含めるか指定
    /// - returns: UIIamge instance
    public class func getImageFromView(view: UIView, opaque: Bool? = nil) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, opaque ?? view.isOpaque, 0)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.translateBy(x: -view.bounds.origin.x, y: -view.bounds.origin.y)
            view.layer.render(in: context)
        }
        
        let renderedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return renderedImage!
    }

}
