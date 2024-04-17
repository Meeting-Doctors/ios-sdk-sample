// Copyright © 2024 MeetingDoctors S.L. All rights reserved.

import Foundation
import UIKit

protocol ChatAssemblerProtocol: AnyObject {
}

class ChatAssembler: ChatAssemblerProtocol {

    // MARK: - Properties

    // MARK: - Init

    init() {}

    // MARK: - Methods

    func viewController() -> UIViewController? {
        let viewController = ChatViewController.loadFromNib()
        viewController.resourcesProvider = self.resourcesProvider()
        return viewController
    }

    private func resourcesProvider() -> ChatResourcesProviderProtocol {
        let item = ChatResourcesProvider()
        return item
    }
}
