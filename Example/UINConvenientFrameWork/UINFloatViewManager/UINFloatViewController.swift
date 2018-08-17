// 
//  UINFloatViewController.swift
//  UINConvenientFrameWork
//
//  Created by yu tanaka on 2018/08/07.
//  Copyright (c) 2018年 RC-Code, Inc. All rights reserved.
//

import UIKit
import UINConvenientFrameWork

class UINFloatViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let floatView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        floatView.backgroundColor = UIColor.black
        floatView.alpha = 0.4
        floatView.layer.cornerRadius = 4
        UINFloatViewManager.shared.setup(view: floatView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UINFloatViewManager.shared.reset()
    }
}
