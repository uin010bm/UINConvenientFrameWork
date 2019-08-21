//
//  UINViewAnimator.swift
//  Pods-UINConvenientFrameWork_Example
//
//  Created by yu tanaka on 2018/10/23.
//

import UIKit

public class UINViewAnimator {
    
    enum Weight {
        case heavy, light, none
    }
    
    enum Thickness {
        case thin, thick
    }
    
    enum Hardness {
        case hard, soft
    }
    
    enum Smoothness {
        case slide, clogged
    }
    
    enum Direction {
        case up, down, right, left, none
    }
    
    enum Offer {
        case passive, active
    }
    
    
    enum Scale {
        case scaleDown(CGFloat), scaleUp(CGFloat)
    }
    
    private let targetView: UIView
    private var weight: Weight = .none          // speed
    private var thickness: Thickness?           // shadow
    private var hardness: Hardness?             // spring speed
    private var smoothness: Smoothness?         // spring width
    private var offer: Offer?                   // easing
    private var direction: Direction = .none
    private var scale: Scale?
    
    init(_ view: UIView) {
        targetView = view
    }

    func preSet() {

        targetView.transform.translatedBy(x: 0, y: targetView.frame.height * 0.5)
    }
    
    func show() {
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: { [weak self] in
            self?.targetView.transform = .identity
            }, completion: { bool in
                
        })
    }
}
