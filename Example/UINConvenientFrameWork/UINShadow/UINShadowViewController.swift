// 
//  UINShadowViewController.swift
//  ConvenientSamples
//
//  Created by yu tanaka on 2018/08/02.
//  Copyright (c) 2018年 CyberAgent, Inc. All rights reserved.
//


import UIKit
import UINConvenientFrameWork

class UINShadowViewController: UIViewController {

    @IBOutlet weak var view_a: UIView!
    @IBOutlet weak var view_b: UIView!
    @IBOutlet weak var view_c: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINShadowPresenter.addDropShadow(view: view_a, type: .dynamic, color: .black, opacity: 0.8, radius: 3, shadowOffset: CGSize(width: 3, height: 3))
        
        UINShadowPresenter.addDropShadow(view: view_b, type: .dynamic, color: .black, opacity: 0.5, radius: 6, shadowOffset: CGSize(width: 0, height: 10))

        UINShadowPresenter.addDropShadow(view: view_c, type: .circle, color: .red, opacity: 0.8, radius: 12, shadowOffset: CGSize(width: 0, height: 0))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
