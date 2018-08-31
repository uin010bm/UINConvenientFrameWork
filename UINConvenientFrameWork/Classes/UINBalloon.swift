// 
//  UINBalloon.swift
//  Pods
//
//  Created by yu tanaka on 2018/08/24.
//  Copyright (c) 2018年 CyberAgent, Inc. All rights reserved.
//


import UIKit

/// show balloon view
public class UINBalloon: UIView {
    
    /// balloon view alignment
    ///
    /// - right: right
    /// - center: center
    /// - left: left
    public enum ArrowHorizontalPosition {
        case right, center, left
    }
    
    /// arrow direction
    ///
    /// - top: top
    /// - bottom: bottom
    public enum ArrowDirection {
        case top, bottom
    }
    
    /// auto resizing type
    ///
    /// - none: no resizing
    /// - fit: no margin
    /// - enlarge: enough margin
    /// - reduce: reduce margin
    public enum AutoResize {
        case none, fit, enlarge, reduce
    }
    
    /// main content
    private let content = UIView()
    
    private let label = UILabel()
    private var _width: CGFloat = 40
    private var _height: CGFloat = 22
    private var _fillColor: UIColor? = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    private var _lineColor: UIColor? = UIColor(red: 255, green: 255, blue: 255, alpha: 0.6)
    private var _lineWidth: CGFloat = 1
    private var _radius: CGFloat = 12
    private var _autoResize: AutoResize = .none
    private var _text = ""
    private var _htmlText = ""
    private var _innerView: UIView = UIView()
    private var _textColor: UIColor = .white
    private var _textAlign: NSTextAlignment = .center
    private var _font: UIFont = .systemFont(ofSize: 16)
    private var _arrowDirection: ArrowDirection = .bottom
    private var _arrowHorizontalPosition: ArrowHorizontalPosition = .center
    private var _arrowWidth: CGFloat = 8
    private var _arrowHeight: CGFloat = 6
    private var _arrorAdjust: CGFloat = 0
    private var _dropShadow = false
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(content)
        isUserInteractionEnabled = false
    }
    
    public func size(size: CGSize) -> UINBalloon {
        _width = size.width
        _height = size.height
        frame.size = size
        return self
    }
    
    public func fillColor(color: UIColor?) -> UINBalloon {
        _fillColor = color
        return self
    }
    
    public func lineColor(color: UIColor?) -> UINBalloon {
        _lineColor = color
        return self
    }
    
    public func radius(value: CGFloat) -> UINBalloon {
        _radius = value
        return self
    }
    
    public func text(value: String) -> UINBalloon {
        _text = value
        return self
    }
    
    public func htmlText(value: String) -> UINBalloon {
        _htmlText = value
        return self
    }
    
    public func innerView(view: UIView) -> UINBalloon {
        _innerView = view
        return self
    }
    
    public func textColor(value: UIColor) -> UINBalloon {
        _textColor = value
        return self
    }
    
    public func textAlign(value: NSTextAlignment) -> UINBalloon {
        _textAlign = value
        return self
    }
    
    public func font(value: UIFont) -> UINBalloon {
        _font = value
        return self
    }
    
    public func lineWidth(value: CGFloat) -> UINBalloon {
        _lineWidth = value
        return self
    }
    
    public func arrowDirection(value: ArrowDirection) -> UINBalloon {
        _arrowDirection = value
        return self
    }
    
    public func arrowHorizontalPosition(value: ArrowHorizontalPosition) -> UINBalloon {
        _arrowHorizontalPosition = value
        return self
    }
    
    public func arrowWidth(value: CGFloat) -> UINBalloon {
        _arrowWidth = value
        return self
    }
    
    public func arrowHeight(value: CGFloat) -> UINBalloon {
        _arrowHeight = value
        return self
    }
    
    /// 矢印のx座標を微調整する
    public func arrowAdjust(value: CGFloat) -> UINBalloon {
        _arrorAdjust = value
        return self
    }
    
    public func autoResize(value: AutoResize) -> UINBalloon {
        _autoResize = value
        return self
    }
    
    public func positions(point: CGPoint) -> UINBalloon {
        frame.origin.x = point.x
        frame.origin.y = point.y
        return self
    }
    
    public func append(parent: UIView) -> UINBalloon {
        parent.addSubview(self)
        return self
    }
    
    public func dropShadow(value: Bool) -> UINBalloon {
        _dropShadow = value
        return self
    }
    
    
    public func show() {
        if _arrowDirection == .top {
            content.frame.origin.y = 5
        } else {
            content.frame.origin.y = -5
        }
        
        content.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.content.frame.origin.y = 0
            self?.content.alpha = 1
        }, completion: nil)
    }
    
    public func hide(remove: Bool = false, delay: TimeInterval = 0) {
        var _y: CGFloat
        if _arrowDirection == .top {
            _y = 5
        } else {
            _y = -5
        }
        content.alpha = 1
        UIView.animate(withDuration: 0.3, delay: delay, options: .curveEaseOut, animations: { [weak self] in
            self?.content.frame.origin.y = _y
            self?.content.alpha = 0
        }, completion: { [weak self] (bool: Bool) in
            if remove {
                self?.removeFromSuperview()
            }
        })
    }
    
    public func draw() -> UINBalloon {
        //remove
        content.removeChildren()
        
        //テキスト設定
        label.textColor = _textColor
        label.frame.size.width = _width - _radius * 2
        label.frame.size.height = _height
        label.numberOfLines = 0
        label.textAlignment = _textAlign
        label.font = _font
        label.textColor = _textColor
        if _htmlText.isEmpty {
            label.text = _text
        } else {
            label.text = _htmlText
        }
        content.addSubview(label)
        
        //auto size setting
        resizeLabel()
        let w = label.frame.size.width + _radius * 2
        let h = _height > label.frame.size.height ? _height : label.frame.height
        
        var img: UIImage
        switch _arrowDirection {
        case .bottom:
            img = drawImageBottom(w: w, h: h)
            break
        case .top:
            img = drawImageTop(w: w, h: h)
            break
        }
        
        let imageView = UIImageView(image: img)
        let p = getImgPosition(w: w, h: h)
        imageView.frame.origin.x = p.x
        imageView.frame.origin.y = p.y
        content.addSubview(imageView)
        
        let lp = getLabelPosition(w: w, h: h)
        label.center.x = lp.x
        label.frame.origin.y = lp.y
        content.addSubview(label)
        
        //innerview設定
        _innerView.frame.origin.x = p.x
        _innerView.frame.origin.y = p.y
        content.addSubview(_innerView)
        
        if _dropShadow {
            content.addDropShadow(type: .dynamic, color: .black, opacity: 0.2, radius: 2, shadowOffset: CGSize(width: 2, height: 2))
        }
        
        return self
    }
    
    private func resizeLabel() {
        switch _autoResize {
        case .none:
            break
        case .fit:
            label.sizeToFit()
            break
        case .reduce:
            label.lineBreakMode = .byTruncatingTail
            //設定されたサイズより小さい場合にfitさせる
            //textが入るサイズを取得
            let rect = label.sizeThatFits(CGSize(width: label.frame.width, height: CGFloat.greatestFiniteMagnitude))
            if rect.width < label.frame.width {
                label.frame.size.width = rect.width
            }
            if rect.height < label.frame.height {
                label.frame.size.height = rect.height
            }
            break
        case .enlarge:
            //設定されたサイズより大きい場合にfitさせる
            let rect = label.sizeThatFits(CGSize(width: label.frame.width, height: CGFloat.greatestFiniteMagnitude))
            if rect.width > label.frame.width {
                label.frame.size.width = rect.width
            }
            if rect.height > label.frame.height {
                label.frame.size.height = rect.height
            }
            break
        }
    }
    
    private func getImgPosition(w: CGFloat, h: CGFloat) -> CGPoint {
        var point = CGPoint.zero
        
        switch _arrowHorizontalPosition {
        case .center:
            point.x = -w / 2 - _arrorAdjust
        case .right:
            point.x = -w / 5 * 4 - _arrorAdjust
        case .left:
            point.x = -w / 5 - _arrorAdjust
        }
        
        if _arrowDirection == .bottom {
            point.y = -h - _arrowHeight
        }
        
        return point
    }
    
    private func getLabelPosition(w: CGFloat, h: CGFloat) -> CGPoint {
        var point = CGPoint.zero
        
        switch _arrowHorizontalPosition {
        case .center:
            point.x = -w / 2 - _arrorAdjust
        case .right:
            point.x = -w / 5 * 4 - _arrorAdjust
        case .left:
            point.x = -w / 5 - _arrorAdjust
        }
        
        if _arrowDirection == .bottom {
            point.y = (-h - _arrowHeight) + ((h - label.frame.height) / 2)
        } else if _arrowDirection == .top {
            point.y = _arrowHeight + ((h - label.frame.height) / 2)
        }
        
        point.x += w / 2
        return point
    }
    
    private func drawImageBottom(w: CGFloat, h: CGFloat) -> UIImage {
        let e: CGFloat = _radius
        let arrowWidth: CGFloat = _arrowWidth
        let arrowHeight: CGFloat = _arrowHeight
        
        let size = CGSize(width: w + 1, height: h + arrowHeight + 1)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        let path = UIBezierPath()
        if let fillColor = _fillColor {
            fillColor.setFill()
        }
        
        if let lineColor = _lineColor {
            lineColor.setStroke()
            path.lineWidth = _lineWidth
        }
        
        
        path.move(to: CGPoint(x: e, y: 1))
        
        path.addLine(to: CGPoint(x: w - e, y: 1))
        path.addCurve(to: CGPoint(x: w, y: e), controlPoint1: CGPoint(x: w, y: 1), controlPoint2: CGPoint(x: w, y: e))
        path.addLine(to: CGPoint(x: w, y: h - e))
        path.addCurve(to: CGPoint(x: w - e, y: h), controlPoint1: CGPoint(x: w, y: h), controlPoint2: CGPoint(x: w - e, y: h))
        
        switch _arrowHorizontalPosition {
        case .right:
            path.addLine(to: CGPoint(x: w / 5 * 4 + _arrorAdjust, y: h))
            path.addLine(to: CGPoint(x: w / 5 * 4 + _arrorAdjust, y: h + _arrowHeight))
            path.addLine(to: CGPoint(x: w / 5 * 4 - (arrowWidth / 2) + _arrorAdjust, y: h))
            break
        case .left:
            path.addLine(to: CGPoint(x: w / 5 + (arrowWidth / 2) + _arrorAdjust, y: h))
            path.addLine(to: CGPoint(x: w / 5 + _arrorAdjust, y: h + _arrowHeight))
            path.addLine(to: CGPoint(x: w / 5 + _arrorAdjust, y: h))
            break
        case .center:
            path.addLine(to: CGPoint(x: w / 2 + (arrowWidth / 2) + _arrorAdjust, y: h))
            path.addLine(to: CGPoint(x: w / 2 + _arrorAdjust, y: h + _arrowHeight))
            path.addLine(to: CGPoint(x: w / 2 - (arrowWidth / 2) + _arrorAdjust, y: h))
            break
        }
        
        path.addLine(to: CGPoint(x: e, y: h))
        path.addCurve(to: CGPoint(x: 1, y: h - e), controlPoint1: CGPoint(x: 1, y: h), controlPoint2: CGPoint(x: 1, y: h - e))
        path.addLine(to: CGPoint(x: 1, y: e))
        
        path.addCurve(to: CGPoint(x: e, y: 1), controlPoint1: CGPoint(x: 1, y: 1), controlPoint2: CGPoint(x: e, y: 1))
        
        if let _ = _fillColor {
            path.fill()
        }
        
        if let _ = _lineColor {
            path.stroke()
        }
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    private func drawImageTop(w: CGFloat, h: CGFloat) -> UIImage {
        let e: CGFloat = _radius
        let arrowWidth: CGFloat = _arrowWidth
        let arrowHeight: CGFloat = _arrowHeight
        
        let size = CGSize(width: w + 1, height: h + arrowHeight + 1)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        let path = UIBezierPath()
        if let fillColor = _fillColor {
            fillColor.setFill()
        }
        
        if let lineColor = _lineColor {
            lineColor.setStroke()
            path.lineWidth = _lineWidth
        }

        path.move(to: CGPoint(x: e, y: 1 + arrowHeight))
        
        switch _arrowHorizontalPosition {
        case .right:
            path.addLine(to: CGPoint(x: w / 5 * 4 - (arrowWidth / 2) + _arrorAdjust, y: 1 + _arrowHeight))
            path.addLine(to: CGPoint(x: w / 5 * 4 + _arrorAdjust, y: 1))
            path.addLine(to: CGPoint(x: w / 5 * 4 + _arrorAdjust, y: 1 + _arrowHeight))
            break
        case .left:
            path.addLine(to: CGPoint(x: w / 5 + _arrorAdjust, y: 1 + _arrowHeight))
            path.addLine(to: CGPoint(x: w / 5 + _arrorAdjust, y: 1))
            path.addLine(to: CGPoint(x: w / 5 + (arrowWidth / 2) + _arrorAdjust, y: 1 + _arrowHeight))
            break
        case .center:
            path.addLine(to: CGPoint(x: w / 2 - (arrowWidth / 2) + _arrorAdjust, y: 1 + _arrowHeight))
            path.addLine(to: CGPoint(x: w / 2 + _arrorAdjust, y: 1))
            path.addLine(to: CGPoint(x: w / 2 + (arrowWidth / 2) + _arrorAdjust, y: 1 + _arrowHeight))
            break
        }
        
        path.addLine(to: CGPoint(x: w - e, y: 1 + arrowHeight))
        path.addCurve(to: CGPoint(x: w, y: e + 1 + arrowHeight), controlPoint1: CGPoint(x: w, y: 1 + arrowHeight), controlPoint2: CGPoint(x: w, y: e + 1 + arrowHeight))
        path.addLine(to: CGPoint(x: w, y: h - e + arrowHeight))
        path.addCurve(to: CGPoint(x: w - e, y: h + arrowHeight), controlPoint1: CGPoint(x: w, y: h + arrowHeight), controlPoint2: CGPoint(x: w - e, y: h + arrowHeight))
        
        path.addLine(to: CGPoint(x: e, y: h + arrowHeight))
        path.addCurve(to: CGPoint(x: 1, y: h + arrowHeight - e), controlPoint1: CGPoint(x: 1, y: h + arrowHeight), controlPoint2: CGPoint(x: 1, y: h + arrowHeight - e))
        path.addLine(to: CGPoint(x: 1, y: e + arrowHeight))
        
        path.addCurve(to: CGPoint(x: e, y: 1 + arrowHeight), controlPoint1: CGPoint(x: 1, y: arrowHeight), controlPoint2: CGPoint(x: e, y: 1 + arrowHeight))
        
        if let _ = _fillColor {
            path.fill()
        }
        
        if let _ = _lineColor {
            path.stroke()
        }

        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }

}

fileprivate extension UIView {
    
    fileprivate func removeChildren() {
        for child in subviews {
            child.removeFromSuperview()
        }
    }
    
    fileprivate func addDropShadow(type: UINShadowPresenter.DropShadowType = .dynamic, color: UIColor = UIColor.black, opacity: Float = 0.3, radius: CGFloat = 4.0, shadowOffset: CGSize = CGSize.zero) {
        UINShadowPresenter.addDropShadow(view: self, type: type, color: color, opacity: opacity, radius: radius, shadowOffset: shadowOffset)
    }
}
