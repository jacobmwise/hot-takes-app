//
//  Swipeable.swift
//  hotTakes
//
//  Created by Rishab Yeddula on 12/14/20.
//

/**
    The swipeable protocol replicates the Tinder functionality of swiping on cards - code is from James Rochabrun
 */

import Foundation
import UIKit

//MARK: step 1 protocol
protocol Swipeable { }
//MARK: step 2 Protocol extension constrained to UIPanGestureRecognizer
extension Swipeable where Self: UIPanGestureRecognizer {
    //MARK function available for any UIPanGestureRecongnizer instance
    func swipeView(_ view: UIView) {
        
        switch state {
        case .changed:
            let translation = self.translation(in: view.superview)
            view.transform = transform(view: view, for: translation)
        case .ended:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: [], animations: {
                view.transform = .identity
            }, completion: nil)
            
        default:
            break
        }
    }
    
    //MARK: Helper method that handles transformation
    private func transform(view: UIView, for translation: CGPoint) -> CGAffineTransform {
        
        let moveBy = CGAffineTransform(translationX: translation.x, y: translation.y)
        let rotation = -sin(translation.x / (view.frame.width * 4.0))
        return moveBy.rotated(by: rotation)
    }
}
//MARK: step 4 UIPanGestureRecognizer conforming to Swipeable
extension UIPanGestureRecognizer: Swipeable {}
