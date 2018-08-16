// 
//  UINButton.swift
//  ConvenientSamples
//
//  Created by yu tanaka on 2018/07/31.
//  Copyright (c) 2018年 RC-Code, Inc. All rights reserved.
//

import UIKit

// presenter for adding shadow to uiview
public class UINButton: UIButton {
    
    
    // MARK: - enum
    
    // button animation when tapped
    public enum TappedAnimType {
        case scale(scale: CGFloat, spring: Bool)
        case custom(downAnimation: ((_ content: UIView, _ bgImageView: UIImageView, _ brinkView: UIView, _ iconLabel: UIView, _ textLabel: UILabel) -> Void)?, upAnimation: ((_ content: UIView, _ bgImageView: UIImageView, _ brinkView: UIView, _ iconLabel: UIView, _ textLabel: UILabel) -> Void)?)
        case none
    }
    
    // hierarchy position of highlight color
    //  back: back of text and icon
    //  front: front of text and icon
    public enum HighlightHierarchy {
        case back, front
    }
    
    
    // MARK: - Initialize
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        alpha = 0
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        alpha = 0
    }
    
    
    // MARK: - Properties
    
    /// Views
    /// main container view
    private let content = UIView()
    /// main container background view
    private let contentBackgroundImageView = UIImageView()
    /// highlight view
    private let brinkView = UIView()
    /// icon view
    private let iconView = UIView()
    /// title label view
    private let textLabel = UILabel()
    
    
    /// Params
    
    // button width
    private var _width: CGFloat = 152
    
    // button height
    private var _height: CGFloat = 48
    
    // button fill color
    private var _fillColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    
    // button background image
    private var _backgroundImage: UIImage?
    
    // button background image contentMode
    private var _backgroundImageContentMode: UIViewContentMode = .scaleToFill
    
    // button line color
    private var _lineColor: UIColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.6)
    
    // button line width
    private var _lineWidth: CGFloat?
    
    // button radius
    private var _radius: CGFloat?
    
    // icon size
    private var _iconSize: CGSize?
    
    // icon charactor
    private var _iconText: String?
    
    // icon font
    private var _iconFont: UIFont = UIFont.boldSystemFont(ofSize: 12)
    
    // icon color
    private var _iconColor: UIColor = UIColor.white
    
    // icon image
    private var _iconImage: UIImage?
    
    // icon image content mode
    private var _iconImageContentMode: UIViewContentMode = .scaleToFill
    
    // margin between text and icon
    private var _iconMargin: CGFloat = 8
    
    // title text
    private var _text: String?
    
    // title text with html
    //    - caution! This params influence _text settings
    private var _htmlText: String?
    
    // title text color
    private var _textColor = UIColor.white
    
    // title text alignment
    private var _textAlign = NSTextAlignment.center
    
    // title text font
    private var _font = UIFont.boldSystemFont(ofSize: 12)
    
    // allow multiple lines
    private var _textMultiLine = true
    
    // button shadow alpha
    private var _dropShadow: (alpha: Float, offsetSize: CGSize, radius: CGFloat)?
    
    // text shadow alpha
    private var _textShadow: (alpha: Float, offsetSize: CGSize, radius: CGFloat)?
    
    // icon shadow alpha
    private var _iconShadow: (alpha: Float, offsetSize: CGSize, radius: CGFloat)?
    
    // selected animation type
    //   - scale(highlightColor: UIColor, scale: Float, spring: Bool)
    //       highlightColor: overlay highlight color
    //       scale: enlargement and reduction percentage (1 = 100%)
    //       spring: enable spring effect on animation
    private var _tappedAnimType: TappedAnimType = .scale(scale: 0.97, spring: false)
    
    // hightlight color when tapped
    private var _highlightColor: UIColor?
    
    // hightlight color when tapped
    private var _highlightHierarchy: HighlightHierarchy = .front
    
    // button touchup handler
    private var _touchUpHandler: ((UINButton) -> Void)?

    // default position
    private var iconOriginPosition: CGPoint?
    private var textOriginPosition: CGPoint?
    
    
    // MARK: - Functions
    
    public func size(width: CGFloat? = nil, height: CGFloat? = nil) -> UINButton {
        _width = width ?? _width
        _height = height ?? _height
        frame.size.width = _width
        frame.size.height = _height
        if let image = generateClearImage(CGSize(width: _width, height: _height)) {
            setBackgroundImage(image, for: .normal)
        }
        return self
    }
    
    public func fillColor(color: UIColor) -> UINButton {
        _fillColor = color
        return self
    }
    
    public func backgroundImage(image: UIImage) -> UINButton {
        _backgroundImage = image
        return self
    }
    
    public func backgroundImageContentMode(mode: UIViewContentMode) -> UINButton {
        _backgroundImageContentMode = mode
        return self
    }
    
    public func lineColor(color: UIColor) -> UINButton {
        _lineColor = color
        return self
    }
    
    public func lineWidth(value: CGFloat) -> UINButton {
        _lineWidth = value
        return self
    }
    
    public func radius(value: CGFloat?) -> UINButton {
        _radius = value
        return self
    }
    
    public func iconSize(value: CGSize) -> UINButton {
        _iconSize = value
        return self
    }
    
    public func iconText(value: String) -> UINButton {
        _iconText = value
        return self
    }
    
    public func iconFont(font: UIFont) -> UINButton {
        _iconFont = font
        return self
    }
    
    public func iconColor(color: UIColor) -> UINButton {
        _iconColor = color
        return self
    }
    
    public func iconImage(image: UIImage) -> UINButton {
        _iconImage = image
        return self
    }
    
    public func iconImageContentMode(mode: UIViewContentMode) -> UINButton {
        _iconImageContentMode = mode
        return self
    }
    
    public func iconMargin(value: CGFloat) -> UINButton {
        _iconMargin = value
        return self
    }
    
    public func text(value: String) -> UINButton {
        _text = value
        return self
    }
    
    public func htmlText(value: String) -> UINButton {
        _htmlText = value
        return self
    }
    
    public func textColor(color: UIColor) -> UINButton {
        _textColor = color
        return self
    }
    
    public func textAlign(value: NSTextAlignment) -> UINButton {
        _textAlign = value
        return self
    }
    
    public func font(font: UIFont) -> UINButton {
        _font = font
        return self
    }

    public func dropShadow(value: (alpha: Float, offsetSize: CGSize, radius: CGFloat)?) -> UINButton {
        _dropShadow = value
        return self
    }
    
    public func textShadow(value: (alpha: Float, offsetSize: CGSize, radius: CGFloat)?) -> UINButton {
        _textShadow = value
        return self
    }
    
    public func iconShadow(value: (alpha: Float, offsetSize: CGSize, radius: CGFloat)?) -> UINButton {
        _iconShadow = value
        return self
    }
    
    public func textMultiLine(bool: Bool) -> UINButton {
        _textMultiLine = bool
        return self
    }
    
    public func tappedAnimType(type: TappedAnimType) -> UINButton {
        _tappedAnimType = type
        return self
    }
    
    public func highlightColor(color: UIColor) -> UINButton {
        _highlightColor = color
        return self
    }
    
    public func highlightHierarchy(type: HighlightHierarchy) -> UINButton {
        _highlightHierarchy = type
        return self
    }
    
    public func touchUpHandler(_ handler: ((UINButton) -> Void)?) -> UINButton {
        _touchUpHandler = handler
        return self
    }
    
    @discardableResult public func isEnabled(_ bool: Bool, animated: Bool = false) -> UINButton {
        isUserInteractionEnabled = bool
        if animated {
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.content.alpha = bool ? 1 : 0.4
            })
        } else {
            content.alpha = bool ? 1 : 0.4
        }
        return self
    }
    
    /// draw button view
    /// isVerticality -> icon and text row alignment
    public func draw(verticality: Bool = false, iconHorizontal: Bool = true) -> UINButton {
        
        // setup rect
        content.frame = CGRect(x: (frame.width - _width) / 2, y: (frame.height - _height) / 2, width: _width, height: _height)
        brinkView.frame = content.frame
        
        
        // remove
        content.layer.removeFromSuperlayer()
        content.removeChildren()
        
        // remove all layers
        if let layers = layer.sublayers {
            for layer in layers {
                layer.removeFromSuperlayer()
            }
        }
        
        
        // setup background image
        contentBackgroundImageView.frame = content.frame
        contentBackgroundImageView.contentMode = _backgroundImageContentMode
        if let image = _backgroundImage {
            contentBackgroundImageView.image = image
        }
        contentBackgroundImageView.layer.cornerRadius = _radius ?? 0
        contentBackgroundImageView.clipsToBounds = true

        
        // setup text label
        textLabel.layer.frame.origin = CGPoint.zero
        textLabel.backgroundColor = UIColor.clear
        textLabel.textColor = _textColor
        textLabel.numberOfLines = _textMultiLine ? 0 : 1
        textLabel.textAlignment = _textAlign
        textLabel.font = _font
        textLabel.textColor = _textColor
        if let htmlData = _htmlText?.data(using: String.Encoding.unicode, allowLossyConversion: true) {
            textLabel.attributedText = try? NSAttributedString(
                data: htmlData,
                options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html],
                documentAttributes: nil)
        } else {
            textLabel.text = _text
        }
        if let (alpha, offset, radius) = _textShadow {
            textLabel.addDropShadow(type: .dynamic, color: .black, opacity: alpha, radius: radius, shadowOffset: offset)
        }
        textLabel.sizeToFit()
        
        
        // setup icon label
        // genarate icon size
        if let _ = _iconText {
            if _iconSize == nil {
                if verticality {
                    _iconSize = CGSize(width: textLabel.frame.width, height: _iconFont.pointSize)
                } else {
                    _iconSize = CGSize(width: _iconFont.pointSize + 2, height: content.frame.height)
                }
            }
            
            // setup size
            let rect: CGRect
            if verticality {
                rect = CGRect(x: (content.frame.size.width - _iconSize!.width) / 2, y: 0, width: _iconSize!.width, height: _iconSize!.height)
            } else {
                rect = CGRect(x: 0, y: 0, width: _iconSize!.width, height: _iconSize!.height)
            }
            iconView.frame = rect
            
            let iconLabel = UILabel(frame: CGRect(x: 0, y: 0, width: rect.width, height: rect.height))
            iconLabel.backgroundColor = UIColor.clear
            iconLabel.font = _iconFont
            iconLabel.textColor = _iconColor
            iconLabel.text = _iconText
            if let (alpha, offset, radius) = _iconShadow {
                iconLabel.addDropShadow(type: .dynamic, color: .black, opacity: alpha, radius: radius, shadowOffset: offset)
            }
            if iconHorizontal {
                iconLabel.textAlignment = .center
            }
            
            iconView.addSubview(iconLabel)
            
        // setup icon image
        } else if let image = _iconImage {
            
            if _iconSize == nil {
                _iconSize = CGSize(width: content.frame.height, height: content.frame.height - textLabel.frame.height)
            }
            
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: _iconSize?.width ?? 0, height: _iconSize?.height ?? 0)
            imageView.contentMode = _iconImageContentMode
            
            // setup size
            let rect: CGRect
            if verticality {
                rect = CGRect(x: (content.frame.size.width - _iconSize!.width) / 2, y: 0, width: _iconSize!.width, height: _iconSize!.height)
            } else {
                rect = CGRect(x: 0, y: 0, width: _iconSize!.width, height: _iconSize!.height)
            }
            iconView.frame = rect
            
            if let (alpha, offset, radius) = _iconShadow {
                iconView.addDropShadow(type: .dynamic, color: .black, opacity: alpha, radius: radius, shadowOffset: offset)
            }
            
            iconView.addSubview(imageView)
        }

        
        // view作成
        content.layer.borderWidth = _lineWidth ?? 0
        content.layer.borderColor = _lineColor.cgColor
        content.layer.cornerRadius = _radius ?? 0
        content.backgroundColor = _fillColor
        content.addSubview(contentBackgroundImageView)
        content.addSubview(textLabel)
        content.addSubview(iconView)
        switch _highlightHierarchy {
        case .back:
            content.insertSubview(brinkView, aboveSubview: contentBackgroundImageView)
        case .front:
            content.addSubview(brinkView)
        }

        if let (alpha, offsetSize, radius) = _dropShadow {
            content.addDropShadow(type: .dynamic, color: UIColor.black, opacity: alpha, radius: radius, shadowOffset: offsetSize)
        }
        
        
        // set default position
        if textOriginPosition == nil {
            textOriginPosition = textLabel.layer.position
        }
        if iconOriginPosition == nil {
            iconOriginPosition = iconView.layer.position
        }
        
        
        // setup text position
        textLabel.layer.position = textOriginPosition!
        
        /// Text Label Origin X
        if _iconSize?.width == 0 {
            textLabel.layer.position.x += (content.frame.width - textLabel.frame.width) / 2
        } else {
            if verticality {
                textLabel.layer.position.x += (content.frame.width - textLabel.frame.width) / 2
            } else {
                textLabel.layer.position.x += (content.frame.width - textLabel.frame.width) / 2 + (iconView.frame.width + _iconMargin) / 2
            }
        }
        
        /// Text Label Origin Y
        if verticality {
            textLabel.layer.position.y += (content.frame.height - textLabel.frame.height) / 2 + (iconView.frame.height) / 2
        } else {
            textLabel.layer.position.y += (content.frame.height - textLabel.frame.height) / 2
        }

        
        // setup icon position
        iconView.layer.position = iconOriginPosition!
        if !verticality {
            iconView.layer.position.x += textLabel.layer.position.x - textLabel.frame.width / 2 - iconView.frame.width - _iconMargin
            iconView.layer.position.y += (content.frame.height - iconView.frame.height) / 2
        } else {
            iconView.layer.position.y += (textLabel.layer.position.y - iconView.frame.height) / 2
        }

        
        insertSubview(content, at: 100)
        
        return self
    }
    
    /// show button with alpha animation
    public func show(animated: Bool = true) {
        if animated {
            alpha = 0
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: { [weak self] in
                guard let me = self else { return }
                me.alpha = 1
                }, completion: nil)
        } else {
            alpha = 1
        }
    }
    
    /// hide button with alpha animation
    public func hide(animated: Bool = true) {
        if animated {
            alpha = 1
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: { [weak self] in
                guard let me = self else { return }
                me.alpha = 0
                }, completion: nil)
        } else {
            alpha = 0
        }
    }
    
    /// animation flow when touch down
    private func onTouchDown() {
        
        // animate highlight color
        if let highlightColor = _highlightColor {
            brinkView.layer.backgroundColor = highlightColor.cgColor
            brinkView.layer.opacity = 0
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: { [weak self] in
                guard let me = self else { return }
                me.brinkView.layer.opacity = 0.2
                }, completion: nil)
        }
        
        
        // animate with enum type
        switch _tappedAnimType {
            
        // scale animation
        case .scale(let scale, let springEnabled):
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: springEnabled ? 0.5 : 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: { [weak self] in
                guard let me = self else { return }
                if let _ = me._dropShadow {
                    me.content.layer.shadowOpacity = scale < 1 ? 0 : max(0, 1-(1-me.content.layer.shadowOpacity)*Float(scale))
                    me.content.layer.shadowOffset = scale < 1 ? CGSize(width: 0, height: 0) : CGSize(width: me.content.layer.shadowOffset.width*scale, height: me.content.layer.shadowOffset.height*scale)
                }
                me.layer.transform = CATransform3DMakeScale(scale, scale, 1)
                }, completion: nil)

        // delegate animation
        case .custom(let downAnimation, _):
            if let anim = downAnimation {
                anim(content, contentBackgroundImageView, brinkView, iconView, textLabel)
            }
        case .none:
            break
            
        }
    }
    
    /// animation flow when touch up
    private func onTouchUp() {
        
        // animate highlight color
        if let _ = _highlightColor {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: { [weak self] in
                guard let me = self else { return }
                me.brinkView.layer.opacity = 0
                }, completion: nil)
        }
        
        
        // animate with enum type
        switch _tappedAnimType {
            
        // scale animation
        case .scale(_, let springEnabled):
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: springEnabled ? 0.5 : 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: { [weak self] in
                guard let me = self else { return }
                if let (alpha, offsetSize, radius) = me._dropShadow {
                    me.content.layer.shadowOpacity = alpha
                    me.content.layer.shadowRadius = radius
                    me.content.layer.shadowOffset = offsetSize
                }
                me.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }, completion: nil)

        // delegate animation
        case .custom(let downAnimation, _):
            if let anim = downAnimation {
                anim(content, contentBackgroundImageView, brinkView, iconView, textLabel)
            }
        case .none:
            break

        }
    }
    
    /// touch up inside handler
    private func onTouchUpInside() {
        _touchUpHandler?(self)
    }
    
    /// catch ui touch began event
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        onTouchDown()
    }
    
    /// catch ui touch end event
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        onTouchUp()
        
        // validate location
        for touch: AnyObject in touches {
            let point = touch.location(in: self)
            if bounds.contains(point) {
                onTouchUpInside()
            }
        }
    }
    
    /// generate clear image for background
    private func generateClearImage(_ size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setFillColor(UIColor.clear.cgColor)
        let rect = CGRect(origin: .zero, size: size)
        context.fill(rect)
        
        let toumeiImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let image = toumeiImage else {
            return nil
        }
        
        return image
    }
}


/// Needs Extensions
fileprivate extension UIView {
    
    /// Remove all subViews
    fileprivate func removeChildren() {
        for child in subviews {
            child.removeFromSuperview()
        }
    }

    fileprivate func addDropShadow(type: UINShadowPresenter.DropShadowType = .dynamic, color: UIColor = UIColor.black, opacity: Float = 0.3, radius: CGFloat = 4.0, shadowOffset: CGSize = CGSize.zero) {
        UINShadowPresenter.addDropShadow(view: self, type: type, color: color, opacity: opacity, radius: radius, shadowOffset: shadowOffset)
    }
}

