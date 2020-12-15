//
//  LabelFactory.swift
//  hotTakes
//
//  Created by Rishab Yeddula on 12/14/20.
//

/**
 Label View Factory - creates labels to add to UIView
 * Code snippets from James Rochabrun - tutorial on how to create view factories.
 */

import Foundation
import UIKit

enum LabelFactory {
    case labelView(text: String, textColor: UIColor, font: UIFont, textAlignment: NSTextAlignment?, sizeToFit: Bool, adjustToFit: Bool)
    
    var newLabel: UILabel{
        switch self {
        case .labelView(let text, let textColor, let font, let textAlignment, let sizeToFit, let adjustToFit):
            return createStandardLabel(text: text, textColor: textColor, font: font, textAlignment: textAlignment, sizeToFit: sizeToFit, adjustToFit: adjustToFit)
        }
    }
    
    private func createStandardLabel(text: String, textColor: UIColor, font: UIFont, textAlignment: NSTextAlignment?, sizeToFit: Bool, adjustToFit: Bool) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = adjustToFit
        label.text = text
        label.font = font
        label.textAlignment = textAlignment!
        label.textColor = textColor
        if sizeToFit {
            label.sizeToFit()
        }
        return label
    }
}

