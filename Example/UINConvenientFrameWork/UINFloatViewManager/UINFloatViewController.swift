// 
//  UINFloatViewController.swift
//  UINConvenientFrameWork
//
//  Created by yu tanaka on 2018/08/07.
//  Copyright (c) 2018年 RC-Code, Inc. All rights reserved.
//

import UIKit
import UINConvenientFrameWork

/// create subclass for floating inner view
class FloatingInnerLabel: UILabel, UINFloatingSubviewProtocol {
    let hitEnabled = false
}

class FloatingButton: UIButton, UINFloatingSubviewProtocol {
    let hitEnabled = true
}

/// sample view controller
class UINFloatViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // create inner view
        let floatView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        floatView.backgroundColor = UIColor.black
        floatView.alpha = 0.4
        floatView.layer.cornerRadius = 4
        let label = FloatingInnerLabel(frame: CGRect(x: 10, y: 10, width: 180, height: 80))
        label.text = "Drag me!!"
        label.textAlignment = .center
        label.textColor = .white
        floatView.addSubview(label)
        let button = FloatingButton(frame: CGRect(x: 10, y: 100, width: 180, height: 80))
        button.setTitle("Button", for: .normal)
        button.setTitle("Hit!", for: .highlighted)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        floatView.addSubview(button)
        
        // setup
        UINFloatViewManager.shared.setup(view: floatView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // reset
        UINFloatViewManager.shared.reset()
    }
}
