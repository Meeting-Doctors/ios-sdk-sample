// Copyright © 2024 MeetingDoctors S.L. All rights reserved.

import Foundation
import UIKit

extension UIViewController {
    func getTitleView(image: UIImage?) -> UIView? {
        guard let navigationBar = self.navigationController?.navigationBar,
            let image = image,
            image.size.height != 0 else {
            return nil
        }

        self.title = .empty

        // Create views
        let imageView = UIImageView(image: image)
        let containerView = UIView(frame: navigationBar.frame)
        containerView.addSubview(imageView)
        // Configure title aspect and style
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // Constraint image position inside title view
        containerView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1,
                                                       constant: navigationBar.frame.size.height - 10))
        containerView.addConstraint(NSLayoutConstraint(item: imageView,
                                                       attribute: .centerX,
                                                       relatedBy: .equal,
                                                       toItem: containerView,
                                                       attribute: .centerX,
                                                       multiplier: 1,
                                                       constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: imageView,
                                                       attribute: .centerY,
                                                       relatedBy: .equal,
                                                       toItem: containerView,
                                                       attribute: .centerY,
                                                       multiplier: 1,
                                                       constant: 0))
        return containerView
    }
}
