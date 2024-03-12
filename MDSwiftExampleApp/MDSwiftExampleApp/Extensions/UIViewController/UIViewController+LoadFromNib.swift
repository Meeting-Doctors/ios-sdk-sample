// Copyright © 2024 MeetingDoctors S.L. All rights reserved.

import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: T.self), bundle: Bundle.main)
        }

        return instantiateFromNib()
    }
}
