// 
//  UINUserNotificationEmulatorViewController.swift
//  UINConvenientFrameWork
//
//  Created by yu tanaka on 2018/08/24.
//  Copyright (c) 2018年 CyberAgent, Inc. All rights reserved.
//


import UIKit
import UINConvenientFrameWork

class UINUserNotificationEmulatorViewController: UIViewController {
    
    @IBOutlet weak var title_textField: UITextView! {
        didSet {
            title_textField.layer.borderWidth = 1
            title_textField.layer.borderColor = UIColor.lightGray.cgColor
            title_textField.layer.cornerRadius = 4
        }
    }
    
    @IBOutlet weak var body_textField: UITextView! {
        didSet {
            body_textField.layer.borderWidth = 1
            body_textField.layer.borderColor = UIColor.lightGray.cgColor
            body_textField.layer.cornerRadius = 4
        }
    }
    
    @IBOutlet weak var badgeCount_textField: UITextField! {
        didSet {
            badgeCount_textField.layer.borderWidth = 1
            badgeCount_textField.layer.borderColor = UIColor.lightGray.cgColor
            badgeCount_textField.layer.cornerRadius = 4
        }
    }
    
    @IBOutlet weak var delaySec_textField: UITextField! {
        didSet {
            delaySec_textField.layer.borderWidth = 1
            delaySec_textField.layer.borderColor = UIColor.lightGray.cgColor
            delaySec_textField.layer.cornerRadius = 4
        }
    }
    
    @IBOutlet weak var sendButton: UINButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sendButton
            .size()
            .fillColor(color: .blue)
            .lineColor(color: .white)
            .lineWidth(value: 4)
            .radius(value: 6)
            .text(value: "Send")
            .font(font: UIFont.boldSystemFont(ofSize: 16))
            .textColor(color: .white)
            .dropShadow(value: (alpha: Float(0.6), offsetSize: CGSize(width: 2, height: 2), radius: 3))
            .tappedAnimType(type: .scale(scale: 0.97, spring: false))
            .highlightColor(color: .white)
            .touchUpHandler({ [weak self] button in
                guard let me = self else { return }
                UINUserNotificationEmulator.sendSampleNotification(title: me.title_textField.text, body: me.body_textField.text, badge: Int(me.badgeCount_textField.text ?? "0") ?? 0, timing: TimeInterval(Int(me.delaySec_textField.text ?? "0") ?? 1))
            })
            .draw()
            .show()
    }
    
}
