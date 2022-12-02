// Copyright © 2022 MeetingDoctors S.L. All rights reserved.

import UIKit

class DividerTopContentView: UIView {

    var buttonAction: (() -> Void)?
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var videoCallView: UIView! {
        didSet {
            videoCallView.backgroundColor = .white
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            self.descriptionLabel.text = "Puedes poner el texto que quieras"
            self.descriptionLabel.textColor = .black
        }
    }
    
    @IBOutlet weak var videocallBtn: UIButton! {
        didSet {
            self.videocallBtn.setTitle("Videocall", for: .normal)
            self.videocallBtn.titleLabel?.textColor = .black
            self.videocallBtn.backgroundColor = UIColor(red: 66 / 255, green: 206 / 255, blue: 206 / 255, alpha: 1)
        }
    }
    
    @IBAction func videocallBtnPressed(_ sender: Any) {
        buttonAction?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder unarchiver: NSCoder) {
        super.init(coder: unarchiver)
    }

    private func setupView() {
        if let view = UINib(nibName: "DividerTopContentView", bundle: Bundle.main).instantiate(withOwner: self, options: nil)[0] as? DividerTopContentView {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: view.contentView.frame.height).isActive = true
            self.addSubview(view, insets: .zero)
        }
    }
}
