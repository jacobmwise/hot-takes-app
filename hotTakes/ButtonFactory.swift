//
//  ButtonFactory.swift
//  hotTakes
//
//  Created by Rishab Yeddula on 12/14/20.
//

/**
 

 Button Factory - reusable code to create buttons
    * Code snippets from James Rochabrun - tutorial on how to create view factories.
 */

import Foundation
import UIKit

enum ButtonFactory {
    case button(image: UIImage, cornerRadius: CGFloat, target: Any, selector: (Selector), sizeToFit: Bool)
    var createButton: UIButton {
        switch self {
        case .button(let image,let cornerRadius,let target,let selector, let sizeToFit):
            return createButtonWithImage(image: image, cornerRadius: cornerRadius, target: target, selector: selector, sizeToFit: sizeToFit)
         }
    }
    
    private func createButtonWithImage(image: UIImage, cornerRadius: CGFloat, target: Any, selector: (Selector), sizeToFit: Bool) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.addTarget(target, action: selector, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = cornerRadius
        button.clipsToBounds = true
        if sizeToFit {
            button.sizeToFit()
        }
        return button
    }
}
