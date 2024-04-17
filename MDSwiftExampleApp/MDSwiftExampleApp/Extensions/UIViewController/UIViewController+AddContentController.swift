// Copyright © 2024 MeetingDoctors S.L. All rights reserved.

import Foundation
import UIKit

extension UIViewController {
    func addContentController(_ child: UIViewController,
                              to view: UIView) {
        view.addFullSubview(child.view)
        self.addChild(child)
        child.didMove(toParent: self)
    }

    func removeContentController(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
