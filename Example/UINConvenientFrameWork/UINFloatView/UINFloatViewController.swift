// 
//  UINFloatViewController.swift
//  ConvenientSamples
//
//  Created by yu tanaka on 2018/08/07.
//  Copyright (c) 2018年 CyberAgent, Inc. All rights reserved.
//


import UIKit
import UINConvenientFrameWork

class UINFloatViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UINFloatView.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UINFloatView.isHidden = true
    }
}
