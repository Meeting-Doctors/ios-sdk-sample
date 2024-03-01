//  Copyright © 2024 MeetingDoctors S.L. All rights reserved.

import UIKit

class MDNavigationController: UINavigationController {
    // MARK: - Properties
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    // MARK: - Methods
    
    private func setup() {
        self.delegate = self
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .blue
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.tintColor = .white
    }
}

// MARK: - UINavigationControllerDelegate

extension MDNavigationController: UINavigationControllerDelegate {
    func navigationController(_: UINavigationController,
                              willShow viewController: UIViewController,
                              animated _: Bool) {
        let item = UIBarButtonItem(title: "",
                                   style: .plain,
                                   target: nil,
                                   action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}

