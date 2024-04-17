// Copyright © 2024 MeetingDoctors S.L. All rights reserved.

import Foundation
import UIKit

protocol ChatResourcesProviderProtocol {
    var navigationBarImage: UIImage? { get }
}

struct ChatResourcesProvider: ChatResourcesProviderProtocol {
    let navigationBarImage: UIImage? = "TextLogo".toImage
}
