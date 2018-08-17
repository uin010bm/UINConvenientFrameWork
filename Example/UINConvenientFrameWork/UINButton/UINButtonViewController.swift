// 
//  UINButtonViewController.swift
//  UINConvenientFrameWork
//
//  Created by yu tanaka on 2018/07/31.
//  Copyright (c) 2018年 RC-Code, Inc. All rights reserved.
//


import UIKit
import UINConvenientFrameWork

class UINButtonViewController: UIViewController {

    @IBOutlet weak var uinButton_a: UINButton!
    @IBOutlet weak var uinButton_b: UINButton!
    @IBOutlet weak var uinButton_c: UINButton!
    @IBOutlet weak var uinButton_d: UINButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        uinButton_a
            .size()
            .fillColor(color: .blue)
            .lineColor(color: .white)
            .lineWidth(value: 4)
            .radius(value: 6)
            .iconFont(font: UIFont(name: "Genericons-Neue", size: 16)!)
            .iconText(value: "")
            .iconColor(color: UIColor.white)
            .text(value: "Sample_a")
            .font(font: UIFont.boldSystemFont(ofSize: 16))
            .textColor(color: .white)
            .dropShadow(value: (alpha: Float(0.6), offsetSize: CGSize(width: 2, height: 2), radius: 3))
            .tappedAnimType(type: .scale(scale: 0.97, spring: false))
            .highlightColor(color: .white)
            .touchUpHandler({ button in
                print("Button touch up.")
            })
            .draw()
            .show()
        
        uinButton_b
            .size(width: 60, height: 60)
            .fillColor(color: .white)
            .lineColor(color: .black)
            .lineWidth(value: 2)
            .radius(value: 30)
            .iconFont(font: UIFont(name: "Genericons-Neue", size: 24)!)
            .iconText(value: "")
            .iconColor(color: UIColor.black)
            .iconImage(image: UIImage(named: "profile_alpha")!)
            .text(value: "HOGE")
            .font(font: UIFont.systemFont(ofSize: 10))
            .textColor(color: .black)
            .tappedAnimType(type: .scale(scale: 1.05, spring: false))
            .highlightColor(color: .white)
            .touchUpHandler({ button in
                print("Button touch up.")
            })
            .draw(verticality: true)
            .show()
        
        uinButton_c
            .size(width: 300, height: 60)
            .lineColor(color: .white)
            .lineWidth(value: 1)
            .backgroundImage(image: UINGradationPresenter.generateGradationImage(size: CGSize(width: 300, height: 60), startFrom: .bottom, colors: [.gray, .lightGray, .darkGray], locations: [1, 0.8, 0]))
            .iconFont(font: UIFont(name: "Genericons-Neue", size: 24)!)
            .iconText(value: "")
            .iconColor(color: .white)
            .text(value: "HOGEHOGE\nFUGAFUGAFUGAFUGA")
            .textAlign(value: .left)
            .textMultiLine(bool: true)
            .font(font: UIFont.systemFont(ofSize: 10))
            .textColor(color: .white)
            .dropShadow(value: (alpha: Float(0.2), offsetSize: CGSize(width: 0, height: 2), radius: 3))
            .textShadow(value: (alpha: Float(0.7), offsetSize: CGSize(width: 1, height: 1), radius: 2))
            .iconShadow(value: (alpha: Float(0.3), offsetSize: CGSize(width: 1, height: 1), radius: 2))
            .tappedAnimType(type: .none)
            .highlightColor(color: .black)
            .highlightHierarchy(type: .back)
            .touchUpHandler({ button in
                print("Button touch up.")
            })
            .draw()
            .show()
        
        uinButton_d
            .size(width: 200, height: 60)
            .lineColor(color: .black)
            .lineWidth(value: 2)
            .backgroundImage(image: UINGradationPresenter.generateGradationImage(size: CGSize(width: 200, height: 60), startFrom: .bottom, colors: [.white, .white, .lightGray], locations: [1, 0.8, 0]))
            .radius(value: 30)
            .iconSize(value: CGSize(width: 40, height: 40))
            .iconImage(image: UIImage(named: "profile_alpha")!)
            .iconMargin(value: -8)
            .text(value: "HOGE")
            .textColor(color: .black)
            .font(font: UIFont.boldSystemFont(ofSize: 20))
            .tappedAnimType(type: .scale(scale: 1.05, spring: false))
            .highlightColor(color: .white)
            .touchUpHandler({ button in
                print("Button touch up.")
            })
            .draw()
            .show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
