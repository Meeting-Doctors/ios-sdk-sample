// Copyright © 2024 MeetingDoctors S.L. All rights reserved.

import UIKit

extension String {
    internal var toImage: UIImage? {
        return UIImage(named: self,
                       in: Bundle.main,
                       with: nil)
    }
}
