// Copyright © 2023 MeetingDoctors S.L. All rights reserved.

import UIKit

class ChatBackgroundView: UIView {
    // MARK: IBoutlets

    @IBOutlet var contentView: UIView!

    @IBOutlet var backgroundImageView: UIImageView! {
        didSet {
            self.backgroundImageView.image = UIImage(named: "chatBackground")
            self.backgroundImageView.backgroundColor = UIColor(from: 0xEEEEEE)
            self.backgroundImageView.contentMode = .scaleAspectFill
        }
    }

    // MARK: - Properties

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder unarchiver: NSCoder) {
        super.init(coder: unarchiver)
        self.setupView()
    }

    private func setupView() {
        let nib: UINib = UINib(nibName: String(describing: ChatBackgroundView.self), bundle: Bundle.main)
        nib.instantiate(withOwner: self, options: nil)
        self.addSubview(self.contentView, insets: .zero)
    }
}
