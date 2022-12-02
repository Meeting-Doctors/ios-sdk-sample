// Copyright © 2022 MeetingDoctors S.L. All rights reserved.

import UIKit

class DividerContentView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = "Puedes poner el texto que desees"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder unarchiver: NSCoder) {
        super.init(coder: unarchiver)
        // self.setupView()
    }

    private func setupView() {
        if let view = UINib(nibName: "DividerContentView", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as? DividerContentView {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: view.contentView.frame.height).isActive = true
            self.addSubview(view, insets: .zero)
        }
    }
}
