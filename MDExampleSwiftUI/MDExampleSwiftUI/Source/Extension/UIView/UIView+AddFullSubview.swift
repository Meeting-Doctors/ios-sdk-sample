// Copyright © 2024 MeetingDoctors S.L. All rights reserved.

import UIKit

extension UIView {
    func addFullSubview(_ subview: UIView?) {
        guard let subview = subview else { return }

        self.addSubview(subview)

        subview.translatesAutoresizingMaskIntoConstraints = false
        let bindings: [String: Any] = ["view": subview]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: bindings))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: bindings))
    }

    func addFullSubview(_ subview: UIView,
                        insets: UIEdgeInsets) {
        self.addSubview(subview)

        subview.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            subview
                .topAnchor
                .constraint(equalTo: self
                    .topAnchor,
                            constant: insets.top),
            subview
                .bottomAnchor
                .constraint(equalTo: self
                    .bottomAnchor,
                            constant: -insets.bottom),
            subview
                .leadingAnchor
                .constraint(equalTo: self
                    .leadingAnchor,
                            constant: insets.left),
            subview
                .trailingAnchor
                .constraint(equalTo: self
                    .trailingAnchor,
                            constant: -insets.right)
        ])
    }
}

