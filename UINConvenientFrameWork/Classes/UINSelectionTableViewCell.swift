// 
//  UINSelectionTableViewCell.swift
//  UINConvenientFrameWork
//
//  Created by yu tanaka on 2018/08/07.
//  Copyright (c) 2018年 RC-Code, Inc. All rights reserved.
//


import UIKit

public class UINSelectionTableViewCell: UITableViewCell, SelectableDispatcherProtocol {
    
    private let emptyButtonRectSize: CGFloat = 16
    private let onButtonRectSize: CGFloat = 10

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
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

    public func setup(title: NSAttributedString, customSelectionView: (selected: UIView, unselect: UIView)? = nil, margin: CGFloat? = nil, selectionViewsRectValue: CGFloat? = nil, selected: Bool, dispatcher: SelectableDispatcher? = nil) {
        
        setup(dispatcher: dispatcher, margin: margin, selectionViewsRectValue: selectionViewsRectValue)

        titleLabel.attributedText = title
        
        self.selectedView.subviews.forEach { $0.removeFromSuperview() }
        self.unSelectView.subviews.forEach { $0.removeFromSuperview() }
        
        if let customSelectionView = customSelectionView {
            self.selectedView.addSubview(customSelectionView.0)
            self.unSelectView.addSubview(customSelectionView.1)
        } else {
            let empty = UIView(frame: CGRect(x: (selectedView.frame.width - emptyButtonRectSize) / 2, y: (selectedView.frame.height - emptyButtonRectSize) / 2, width: emptyButtonRectSize, height: emptyButtonRectSize))
            empty.backgroundColor = .clear
            empty.layer.borderWidth = 1
            empty.layer.borderColor = UIColor.lightGray.cgColor
            empty.layer.cornerRadius = empty.frame.height / 2
            empty.layer.masksToBounds = true
            self.unSelectView.addSubview(empty)
            
            let scaled = CGRect(x: (selectedView.frame.width - onButtonRectSize) / 2, y: (selectedView.frame.height - onButtonRectSize) / 2, width: onButtonRectSize, height: onButtonRectSize)
            let on = UIView(frame: scaled)
            on.backgroundColor = .clear
            on.backgroundColor = .green
            on.layer.cornerRadius = on.frame.height / 2
            on.layer.masksToBounds = true
            
            let empty_sec = UIView(frame: CGRect(x: (selectedView.frame.width - emptyButtonRectSize) / 2, y: (selectedView.frame.height - emptyButtonRectSize) / 2, width: emptyButtonRectSize, height: emptyButtonRectSize))
            empty_sec.backgroundColor = .clear
            empty_sec.layer.borderWidth = 1
            empty_sec.layer.borderColor = UIColor.lightGray.cgColor
            empty_sec.layer.cornerRadius = empty_sec.frame.height / 2
            empty_sec.layer.masksToBounds = true
            self.selectedView.addSubview(empty_sec)
            self.selectedView.addSubview(on)
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
    
    public func tapped() {
        checked = !checked
        
        selectedView.isHidden = !checked
        unSelectView.isHidden = checked
    }
    
    public func update(_ selected: Bool) {
        checked = selected
        
        selectedView.isHidden = !checked
        unSelectView.isHidden = checked
    }
}
