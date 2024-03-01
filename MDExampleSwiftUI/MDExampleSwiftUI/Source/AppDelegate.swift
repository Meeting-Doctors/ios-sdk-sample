//  Copyright © 2024 MeetingDoctors S.L. All rights reserved.

import Foundation
import UIKit
import MeetingDoctorsSDK

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let clientSecret: String = <#your API Key#>
        let configuration = MeetingDoctors.Configuration(secret: clientSecret,
                                                         environment: .staging)
        if let uuid: UUID = MeetingDoctors.initialize(with: configuration, options: launchOptions) {
            NSLog("[AppDelegate] Synchronous installation identifier: '\(uuid.uuidString)'")
            let token: String = <#your demo user token#>
            MeetingDoctors.authenticate(token: token) { (result: MeetingDoctorsResult<Void>) in
                switch result {
                case .success:
                    NSLog("[AppDelegate] authenticate Success")
                    self.configureStyle()
                case .failure(let error):
                    NSLog("[AppDelegate] authenticate Failure: '\(error)'")
                @unknown default:
                    NSLog("[AppDelegate] authenticate default")
                }
            }
        }
        return true
    }
    
    private func configureStyle() {
        if var style = MeetingDoctors.style {
            style.colors.common.primary = .blue
            style.colors.common.dataTextColor = .black
            MeetingDoctors.style = style
        }
    }
}
