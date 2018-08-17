// 
//  UINGradationViewController.swift
//  UINConvenientFrameWork
//
//  Created by yu tanaka on 2018/08/02.
//  Copyright (c) 2018年 RC-Code, Inc. All rights reserved.
//

import UIKit
import UINConvenientFrameWork

/// gradation sample view controller
class UINGradationViewController: UIViewController {
    
    @IBOutlet weak var view_a: UIImageView! {
        didSet {
            view_a.layer.borderWidth = 1
            view_a.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var view_b: UIImageView! {
        didSet {
            view_b.layer.borderWidth = 1
            view_b.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var view_c: UIImageView! {
        didSet {
            view_c.layer.borderWidth = 1
            view_c.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var view_d: UIImageView! {
        didSet {
            view_d.layer.borderWidth = 1
            view_d.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var view_e: UIImageView! {
        didSet {
            view_e.layer.borderWidth = 1
            view_e.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var view_f: UIImageView! {
        didSet {
            view_f.layer.borderWidth = 1
            view_f.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // sample a
        let image_a = UINGradationPresenter.generateGradationImage(size: CGSize(width: view_a.frame.width, height: view_a.frame.height), startFrom: .top, colors: [.gray, .black])
        
        // sample b
        let image_b = UINGradationPresenter.generateGradationImage(size: CGSize(width: view_b.frame.width, height: view_b.frame.height), startFrom: .topLeft, colors: [.red, .orange, .brown, .yellow, .green, .cyan, .blue], locations: [1, 0.8, 0.6, 0.5, 0.4, 0.2, 0])
        
        // sample c
        let image_c = UINGradationPresenter.generateGradationImage(size: CGSize(width: view_c.frame.width, height: view_c.frame.height), startFrom: .topRight, colors: [.lightGray, .white, .darkGray], locations: [1, 0.2, 0])
        
        // sample d
        let image_d = UINGradationPresenter.generateGradationImage(size: CGSize(width: view_d.frame.width, height: view_d.frame.height), startPoint: .init(x: view_d.frame.width, y: 0), endPoint: .init(x: view_d.frame.width, y: view_d.frame.height / 2), colors: [.red, .brown], locations: [0.2, 0.8])
        
        // sample e
        let image_e = UINGradationPresenter.generateGradationImage(size: CGSize(width: view_e.frame.width, height: view_e.frame.height), startPoint: .init(x: 0, y: view_e.frame.height / 2), endPoint: .init(x: view_e.frame.width / 2, y: 0), colors: [.cyan, .blue, .black])
        
        // sample f
        let image_f = UINGradationPresenter.generateGradationImage(size: CGSize(width: view_f.frame.width, height: view_f.frame.height), startPoint: .init(x: 0, y: 0), endPoint: .init(x: view_f.frame.width, y: 0), colors: [.lightGray, .darkGray], locations: nil)
        
        view_a.image = image_a
        view_b.image = image_b
        view_c.image = image_c
        view_d.image = image_d
        view_e.image = image_e
        view_f.image = image_f
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
