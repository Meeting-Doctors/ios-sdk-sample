// Copyright © 2022 MeetingDoctors S.L. All rights reserved.

import UIKit

extension UIColor {
    convenience init(from hexa: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat((hexa >> 16) & 0xFF) / 255.0,
                  green: CGFloat((hexa >> 8) & 0xFF) / 255.0,
                  blue: CGFloat(hexa & 0xFF) / 255.0,
                  alpha: alpha)
    }
}
