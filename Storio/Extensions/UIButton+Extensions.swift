//
//  UIButton+Extensions.swift
//  Storio
//
//  Created by Kerem Demir on 20.12.2023.
//

import Foundation
import UIKit

import UIKit

extension UIButton {
    // MARK : Make Circular
    func makeCircular(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
}
