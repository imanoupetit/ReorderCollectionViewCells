//
//  AnimateProtocol.swift
//  PageBasedApp
//
//  Created by Imanou Petit on 16/10/2016.
//  Copyright © 2016 Imanou Petit. All rights reserved.
//

import UIKit

/// This protocol aims to add animation when a cell is selected before some reordering operation
protocol AnimateProtocol {
    func animatePickUp()
    func animatePutDown()
}

extension AnimateProtocol where Self: UIView {
    
    /// When a UIView object is picked up (with a long gesture recognizer), we want to animate its resize to scale 1.1
    func animatePickUp() {
        let animations = { () -> Void in
            self.transform = CGAffineTransform(scaleX: Constants.cellTransformUnit, y: Constants.cellTransformUnit)
        }
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1, delay: 0, options: [], animations: animations)
    }
    
    /// When a cell is picked down (after a long gesture recognizer), we want to animate its resize to initial scale
    func animatePutDown() {
        let animations = { () -> Void in
            self.transform = .identity
        }
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1, delay: 0, options: [], animations: animations)
    }
    
}
