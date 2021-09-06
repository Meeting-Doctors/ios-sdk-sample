//
//  UIColor+Extension.swift
//  Mediquo Swift Example App
//
//  Created by Xavi Roig Aznar on 2/9/21.
//  Copyright © 2021 Edgar Paz Moreno. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(from hexa: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat((hexa >> 16) & 0xFF) / 255.0,
                  green: CGFloat((hexa >> 8) & 0xFF) / 255.0,
                  blue: CGFloat(hexa & 0xFF) / 255.0,
                  alpha: alpha)
    }
}
