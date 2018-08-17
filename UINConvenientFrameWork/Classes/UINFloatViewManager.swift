// 
//  UINFloatViewManager.swift
//  UINConvenientFrameWork
//
//  Created by yu tanaka on 2018/08/07.
//  Copyright (c) 2018年 RC-Code, Inc. All rights reserved.
//

import UIKit

/// floating view manager
/// setup custom window and create floating view controller
public class UINFloatViewManager: NSObject {
    
    public static let shared = UINFloatViewManager()
    
    fileprivate var window: FloatWindow?
    
    /// setup innerview
    ///
    /// - Parameter view: custom inner view
    public func setup(view: UIView) {
        if window == nil {
            let floatWindow = FloatWindow()
            floatWindow.windowLevel = UIWindowLevelStatusBar
            floatWindow.backgroundColor = UIColor.clear
            let floatViewController = FloatViewController()
            floatViewController.setupView(view: view)
            floatWindow.rootViewController = floatViewController
            floatWindow.isHidden = false
            window = floatWindow
        }
    }
    
    public func reset() {
        window = nil
    }
}

/// float window for validate hit point
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

/// floating wrapper view controller
private class FloatViewController: UIViewController {
    
    fileprivate var wrapperView: UIView?
    fileprivate var wrapperRect: CGRect!
    fileprivate var panRecognizer: UIPanGestureRecognizer?
    
    fileprivate let timeInterval: TimeInterval = 5 //sec
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setup()
    }

    /// setup inner view
    ///
    /// - Parameter view: customize view
    fileprivate func setupView(view: UIView) {
        
        // wrapperView
        wrapperView = view
        
        guard let wrapperView = wrapperView else { return }

        // event setting
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(FloatViewController.handlePan(_:)))
        guard let panRecognizer = panRecognizer else { return }
        wrapperView.addGestureRecognizer(panRecognizer)
    }
    
    /// add subview
    public func setup() {
        guard let wrapperView = wrapperView else { return }
        wrapperView.removeFromSuperview()
        view.addSubview(wrapperView)
    }
    
    /// pan event
    ///
    /// - Parameter recognizer: gesture event
    @objc public func handlePan(_ recognizer: UIPanGestureRecognizer) {
        guard let wrapperView = wrapperView else { return }
        
        switch recognizer.state {
        case .began:
            wrapperRect = wrapperView.frame
        case .changed, .ended:
            let d = recognizer.translation(in: view)
            var wrapperFrame = wrapperRect
            wrapperFrame!.origin.x += d.x
            wrapperFrame!.origin.y += d.y
            wrapperView.frame = wrapperFrame!
        default:
            break
        }
    }
    
    /// validate hit test
    ///
    /// - Parameters:
    ///   - window: wrapper window
    ///   - point: hit point
    ///   - event: ui event
    /// - Returns: innerview
    public func hitTest(_ window: UIWindow, point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let wrapperView = wrapperView else { return nil }
        
        let wrapperFrame = wrapperView.convert(wrapperView.bounds, to: window)
        if wrapperFrame.contains(point) {
            return wrapperView
        }
        return nil
    }
}
