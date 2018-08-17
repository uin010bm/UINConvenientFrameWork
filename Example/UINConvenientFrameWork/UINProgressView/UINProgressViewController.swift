// 
//  UINProgressViewController.swift
//  UINConvenientFrameWork
//
//  Created by yu tanaka on 2018/08/02.
//  Copyright (c) 2018年 RC-Code, Inc. All rights reserved.
//

import UIKit
import UINConvenientFrameWork

class UINProgressViewController: UIViewController {
    
    @IBOutlet weak var view_a: UINProgressView! {
        didSet {
            view_a.layer.cornerRadius = view_a.frame.height / 2
            view_a.layer.masksToBounds = true
            view_a.backgroundColor = UIColor(white: 0.9, alpha: 1)
        }
    }
    @IBOutlet weak var view_b: UINProgressView! {
        didSet {
            view_b.layer.cornerRadius = view_b.frame.height / 2
            view_b.layer.masksToBounds = true
            view_b.layer.borderWidth = 1
            view_b.layer.borderColor = UIColor.gray.cgColor
        }
    }
    @IBOutlet weak var view_c: UINProgressView!

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let setting_a = UINProgressView.AnimSetting()
        view_a
            .fillColor(color: .cyan)
            .animation(setting: setting_a)
            .draw()
            .animation(max: 100, current: 20)

        let setting_b = UINProgressView.AnimSetting(duration: 5, delay: 1, dumping: 10, initialVelocity: 0, mass: 1, stiffness: 100, timingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
        view_b
            .fillColor(colors: [.yellow, .orange, .red])
            .direction(direction: .right)
            .fillRadius(colors: view_b.layer.cornerRadius)
            .animation(setting: setting_b)
            .draw()
            .animation(max: 100, current: 80)
        
        let setting_c = UINProgressView.AnimSetting(duration: 1, delay: 0, dumping: 12, initialVelocity: 0, mass: 1, stiffness: 50, timingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
        view_c
            .fillColor(color: .green, overlayEnabled: true)
            .fillColorsDirection(direction: .bottom)
            .direction(direction: .bottom)
            .animation(setting: setting_c)
            .draw()
            .animation(max: 100, current: 50)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
