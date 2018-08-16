// 
//  UINSelectionTableViewCell.swift
//  ConvenientSamples
//
//  Created by yu tanaka on 2018/08/07.
//  Copyright (c) 2018年 CyberAgent, Inc. All rights reserved.
//


import UIKit

public class UINSelectionTableViewCell: UITableViewCell, SelectableDispatcherProtocol {

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var `switch`: UISwitch! {
        didSet {
            `switch`.isHidden = true
        }
    }
    @IBOutlet weak var selectedView: UIView! {
        didSet {
            selectedView.isHidden = true
        }
    }
    @IBOutlet weak var unSelectView: UIView! {
        didSet {
            unSelectView.isHidden = true
        }
    }
    @IBOutlet weak var selectViewWidth: NSLayoutConstraint!
    @IBOutlet weak var leftMargin: NSLayoutConstraint!
    @IBOutlet weak var centerMargin: NSLayoutConstraint!
    @IBOutlet weak var rightMargin: NSLayoutConstraint!
    
    public let uuid = UUID().uuidString
    private weak var dispatcher: SelectableDispatcher?
    var checked = false

    override public func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    deinit {
        dispatcher?.remove(target: self)
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func setup(title: NSAttributedString, customSelectionView: (UIView, UIView)? = nil, margin: CGFloat? = nil, selectionViewsRectValue: CGFloat? = nil, selected: Bool, dispatcher: SelectableDispatcher? = nil) {
        
        setup(dispatcher: dispatcher, margin: margin, selectionViewsRectValue: selectionViewsRectValue)

        titleLabel.attributedText = title
        
        `switch`.isHidden = !(customSelectionView == nil)
        
        self.selectedView.subviews.forEach { $0.removeFromSuperview() }
        self.unSelectView.subviews.forEach { $0.removeFromSuperview() }
        
        if let customSelectionView = customSelectionView {
            self.selectedView.addSubview(customSelectionView.0)
            self.unSelectView.addSubview(customSelectionView.1)
        }

        update(selected)
    }
    
    private func setup(dispatcher: SelectableDispatcher?, margin: CGFloat? = nil, selectionViewsRectValue: CGFloat? = nil) {
        
        self.dispatcher = dispatcher
        self.dispatcher?.add(target: self)

        if let margin = margin {
            leftMargin.constant = margin
            centerMargin.constant = margin
            rightMargin.constant = margin
        }
        
        if let selectionViewsRectValue = selectionViewsRectValue {
            selectViewWidth.constant = selectionViewsRectValue
        }
    }
    
    @IBAction func tappedSwitch(_ sender: UISwitch) {
        checked = sender.isOn
    }
    
    public func tapped() {
        checked = !checked
        
        if selectedView.subviews.count > 0 {
            selectedView.isHidden = !checked
            unSelectView.isHidden = checked
        } else {
            `switch`.isOn = checked
        }
    }
    
    public func update(_ selected: Bool) {
        checked = selected
        
        if selectedView.subviews.count > 0 {
            selectedView.isHidden = !checked
            unSelectView.isHidden = checked
        } else {
            `switch`.isOn = checked
        }
    }
}
