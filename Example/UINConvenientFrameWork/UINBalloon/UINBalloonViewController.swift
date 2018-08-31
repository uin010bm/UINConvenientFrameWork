// 
//  UINBalloonViewController.swift
//  UINConvenientFrameWork
//
//  Created by yu tanaka on 2018/08/24.
//  Copyright (c) 2018年 CyberAgent, Inc. All rights reserved.
//


import UIKit
import UINConvenientFrameWork

public class UINBalloonViewController: UIViewController {
    
    @IBOutlet weak var balloonContainer: UIView!
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let balloon = UINBalloon().size(size: CGSize(width: 150, height: 22)).arrowDirection(value: UINBalloon.ArrowDirection.bottom).autoResize(value: UINBalloon.AutoResize.reduce).text(value: "Float!").positions(point: CGPoint(x: balloonContainer.frame.width, y: 0))
        balloonContainer.addSubview(balloon)
        balloon.draw().show()
    }
    
}
