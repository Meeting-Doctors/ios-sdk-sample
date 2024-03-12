// Copyright © 2024 MeetingDoctors S.L. All rights reserved.

import UIKit
import MeetingDoctorsSDK

class ChatViewController: UIViewController {
    // MARK: - Properties - Injected

    var resourcesProvider: ChatResourcesProviderProtocol?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let professionalList = MeetingDoctors.professionalListViewController()
        if let viewController: UIViewController = professionalList.value {
            self.addContentController(viewController,
                                      to: self.view)
        } else {
            NSLog("[ChatViewController] - Failed to instantiate historial with error \(String(describing:  professionalList.error))")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.updateView()
    }

    func updateView() {
        self.setupNavigationBar()
    }
}

extension ChatViewController {
    private func setupNavigationBar() {
        let image = self.resourcesProvider?.navigationBarImage
        self.navigationItem.titleView = self.getTitleView(image: image)
    }
}

extension ChatViewController {
}
