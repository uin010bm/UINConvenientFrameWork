// 
//  UINProgressViewController.swift
//  UINConvenientFrameWork
//
//  Created by yu tanaka on 2018/08/02.
//  Copyright (c) 2018年 RC-Code, Inc. All rights reserved.
//

import UIKit
import UINConvenientFrameWork

/// progress sample view controller
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
    
    @IBOutlet weak var view_c_0: UINProgressView!
    @IBOutlet weak var view_c_1: UINProgressView!
    @IBOutlet weak var view_c_2: UINProgressView!
    @IBOutlet weak var view_c_3: UINProgressView!
    @IBOutlet weak var view_c_4: UINProgressView!
    @IBOutlet weak var view_c_5: UINProgressView!
    @IBOutlet weak var view_c_6: UINProgressView!
    @IBOutlet weak var view_c_7: UINProgressView!
    @IBOutlet weak var view_c_8: UINProgressView!
    @IBOutlet weak var view_c_9: UINProgressView!
    @IBOutlet weak var view_c_10: UINProgressView!
    @IBOutlet weak var view_c_11: UINProgressView!
    @IBOutlet weak var view_c_12: UINProgressView!
    @IBOutlet weak var view_c_13: UINProgressView!
    @IBOutlet weak var view_c_14: UINProgressView!
    @IBOutlet weak var view_c_15: UINProgressView!
    @IBOutlet weak var view_c_16: UINProgressView!
    @IBOutlet weak var view_c_17: UINProgressView!
    @IBOutlet weak var view_c_18: UINProgressView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let setting_a = UINProgressView.AnimSetting()
        view_a
            .fillColor(color: .cyan)
            .animation(setting: setting_a)
            .draw()
            .animation(max: 100, current: 80)

        let setting_b = UINProgressView.AnimSetting(duration: 5, delay: 1, dumping: 10, initialVelocity: 0, mass: 1, stiffness: 100, timingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
        view_b
            .fillColor(colors: [.yellow, .orange, .red])
            .direction(direction: .right)
            .fillRadius(colors: view_b.layer.cornerRadius)
            .animation(setting: setting_b)
            .draw()
            .animation(max: 100, current: 80)
        
        let setting_c = UINProgressView.AnimSetting(duration: 1, delay: 0, dumping: 10, initialVelocity: 0, mass: 0.5, stiffness: 70, timingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
        
        let views: [UINProgressView] = [view_c_0,view_c_1,view_c_2,view_c_3,view_c_4,view_c_5,view_c_6,view_c_7,view_c_8,view_c_9,view_c_10,view_c_11,view_c_12,view_c_13,view_c_14,view_c_15,view_c_16,view_c_17,view_c_18]
            
        views.enumerated().forEach { (index, view) in
            let percentage: CGFloat = CGFloat(index) / CGFloat(views.count)
            view
                .fillColor(color: .green, overlayEnabled: true)
                .fillColorsDirection(direction: .bottom)
                .direction(direction: .bottom)
                .animation(setting: setting_c)
                .draw()
                .animation(max: 100, current: Float(100 * percentage))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
