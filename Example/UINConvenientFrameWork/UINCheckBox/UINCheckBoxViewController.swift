// 
//  UINCheckBoxViewController.swift
//  UINConvenientFrameWork
//
//  Created by yu tanaka on 2018/08/21.
//  Copyright (c) 2018年 CyberAgent, Inc. All rights reserved.
//


import UIKit
import UINConvenientFrameWork

class UINCheckBoxViewController: UIViewController {
    
    @IBOutlet weak var check_box_1: UINCheckBox!
    @IBOutlet weak var check_box_2: UINCheckBox!
    @IBOutlet weak var check_box_3: UINCheckBox!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        check_box_1.prepareSetup()
        check_box_1.setup(selectedImage: UIImage(named: "light-on")!, unselectedImage: UIImage(named: "light-off")!, bgColor: .clear)
        check_box_1.setHandler {
            print("tapped")
        }

        check_box_2.prepareSetup()
        check_box_2.setup(selectedImage: UIImage(named: "check_on")!, unselectedImage: UIImage(named: "check_off")!, bgColor: .clear)
        check_box_2.setHandler {
            print("tapped")
        }
        
        check_box_3.layer.cornerRadius = 4
        check_box_3.layer.masksToBounds = true
        check_box_3.prepareSetup()
        check_box_3.setup(selectedImage: UIImage(named: "check_blue")!, unselectedImage: nil, bgColor: .darkGray)
        check_box_3.setHandler {
            print("tapped")
        }
    }
}
