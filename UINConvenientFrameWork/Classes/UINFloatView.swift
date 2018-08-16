// 
//  UINFloatView.swift
//  ConvenientSamples
//
//  Created by yu tanaka on 2018/08/07.
//  Copyright (c) 2018年 CyberAgent, Inc. All rights reserved.
//

import UIKit

public class UINFloatView: NSObject {
    
    fileprivate static var window: FloatWindow?
    public static var isHidden: Bool = true {
        didSet {
            if isHidden {
                window = nil
            } else {
                if window == nil {
                    let floatWindow = FloatWindow()
                    floatWindow.windowLevel = UIWindowLevelStatusBar
                    floatWindow.backgroundColor = UIColor.clear
                    floatWindow.rootViewController = FloatViewController()
                    floatWindow.isHidden = false
                    window = floatWindow
                }
            }
        }
    }
}

private class FloatWindow: UIWindow {
    
    var floatViewController: FloatViewController? {
        return rootViewController as? FloatViewController
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let vc = floatViewController {
            return vc.hitTest(self, point: point, with: event)
        }
        return nil
    }
}

private class FloatViewController: UIViewController {
    
    fileprivate var wrapperView: UIView!
    fileprivate var wrapperRect: CGRect = CGRect(x: 8, y: 135, width: 215, height: 185)
    fileprivate var panRecognizer: UIPanGestureRecognizer!
    
    fileprivate let timeInterval: TimeInterval = 5 //sec
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWrapperView()
    }
    
    fileprivate func setupWrapperView() {
        
        // wrapperView
        wrapperView = UIView(frame: wrapperRect)
        wrapperView.layer.cornerRadius = 5.0
        wrapperView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        view.addSubview(wrapperView)
        
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(FloatViewController.handlePan(_:)))
        wrapperView.addGestureRecognizer(panRecognizer)
    }
    
    @objc public func handlePan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            wrapperRect = wrapperView.frame
        case .changed, .ended:
            let d = recognizer.translation(in: view)
            var wrapperFrame = wrapperRect
            wrapperFrame.origin.x += d.x
            wrapperFrame.origin.y += d.y
            wrapperView.frame = wrapperFrame
        default:
            break
        }
    }
    
    // MARK: delegate
    public func hitTest(_ window: UIWindow, point: CGPoint, with event: UIEvent?) -> UIView? {
        let wrapperFrame = wrapperView.convert(wrapperView.bounds, to: window)
        if wrapperFrame.contains(point) {
            return wrapperView
        }
        return nil
    }
}
