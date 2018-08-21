// 
//  UINCheckBox.swift
//  Pods
//
//  Created by yu tanaka on 2018/08/20.
//  Copyright (c) 2018年 CyberAgent, Inc. All rights reserved.
//

import Foundation
import QuartzCore

public class UINCheckBox: UIView {
    
    private var contentView: UIView!
    @IBOutlet weak var iconSelected: UIImageView!
    @IBOutlet weak var iconUnselected: UIImageView!
    private var selected: Bool = false
    private var handler: (() -> Void)?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            contentView = view
            view.frame = bounds
            addSubview(view)
        }
    }
    
    public func prepareSetup() {
        self.updateSelectedView()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(UINCheckBox.onTapHandler(_:)))
        addGestureRecognizer(gesture)
    }
    
    public func setup(selectedImage: UIImage, unselectedImage: UIImage?, bgColor: UIColor = .clear) {
        self.iconSelected.image = selectedImage
        self.iconUnselected.image = unselectedImage
        self.contentView.backgroundColor = bgColor
    }
    
    public func setHandler(_ handler: @escaping () -> Void) {
        self.handler = handler
    }
    
    public func isSelected() -> Bool {
        return self.selected
    }
    
    /// set selected status
    ///
    /// - Parameters:
    ///   - value: selected
    ///   - animate: enabled animation
    public func setSelected(value: Bool, animate: Bool) {
        self.selected = value
        self.updateSelectedView()
        self.showSelectedAnimation()
    }
    
    private func setSelectedImage(image: UIImage) {
        self.iconSelected.image = image
    }
    
    private func setUnselectedImage(image: UIImage) {
        self.iconUnselected.image = image
    }

    /// fire handler when tapped select view
    ///
    /// - Parameter recognizer: tap recognizer
    @objc dynamic public func onTapHandler(_ recognizer: UITapGestureRecognizer) {
        self.selected = !self.selected
        self.updateSelectedView()
        self.showSelectedAnimation()
        self.handler?()
    }
    
    /// show selected animation
    private func showSelectedAnimation() {
        guard self.selected else { return }
        
        self.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            guard let me = self else { return }
            me.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: { [weak self] in
                guard let me = self else { return }
                me.layer.transform = CATransform3DIdentity
            }, completion: { [weak self] _ in
                guard let me = self else { return }
                me.isUserInteractionEnabled = true
            })
        })
    }
    
    /// switch view hidding
    private func updateSelectedView() {
        self.iconSelected.isHidden = !self.selected
        self.iconUnselected.isHidden = self.selected
    }
    
    /// autolayout setting
    private func setupAutoLayout() {
        guard let parent = self.superview else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        parent.addConstraints([NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: parent, attribute: .top, multiplier: 1, constant: 0), NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: parent, attribute: .leading, multiplier: 1, constant: 0), NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: parent, attribute: .height, multiplier: 1, constant: 0), NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: parent, attribute: .width, multiplier: 1, constant: 0)])
        parent.layoutIfNeeded()
    }
}
