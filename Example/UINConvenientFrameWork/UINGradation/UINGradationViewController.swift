// 
//  UINGradationViewController.swift
//  UINConvenientFrameWork
//
//  Created by yu tanaka on 2018/08/02.
//  Copyright (c) 2018年 RC-Code, Inc. All rights reserved.
//


import UIKit
import UINConvenientFrameWork

class UINGradationViewController: UIViewController {
    
    @IBOutlet weak var view_a: UIImageView!
    @IBOutlet weak var view_b: UIImageView!
    @IBOutlet weak var view_c: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let image_a = UINGradationPresenter.generateGradationImage(size: CGSize(width: view_a.frame.width, height: view_a.frame.height), startFrom: .top, colors: [.gray, .black])
        let image_b = UINGradationPresenter.generateGradationImage(size: CGSize(width: view_b.frame.width, height: view_a.frame.height), startFrom: .topLeft, colors: [.red, .orange, .brown, .yellow, .green, .cyan, .blue], locations: [1, 0.8, 0.6, 0.5, 0.4, 0.2, 0])
        let image_c = UINGradationPresenter.generateGradationImage(size: CGSize(width: view_c.frame.width, height: view_a.frame.height), startFrom: .top, colors: [.lightGray, .white, .darkGray], locations: [1, 0.2, 0])
        
        view_a.image = image_a
        view_b.image = image_b
        view_c.image = image_c
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
