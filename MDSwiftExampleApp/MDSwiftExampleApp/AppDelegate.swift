// Copyright © 2022 MeetingDoctors S.L. All rights reserved.

import MeetingDoctorsSDK
import MeetingDoctorsCore

@UIApplicationMain
class AppDelegate: ApplicationServiceDelegate {
    
    override var services: [ApplicationServicePlugin] {
        return [NotificationApplicationDelegate(),
                FirebaseApplicationDelegate()]
    }
    
    public override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if let clientName: String = MeetingDoctors.getClientName(),
            let clientSecret: String = MeetingDoctors.getClientSecret() {
            let configuration = MeetingDoctors.Configuration(id: clientName, secret: clientSecret, enableVideoCall: true, environment: .development)
            let uuid: UUID? = MeetingDoctors.initialize(application,
                                                        with: configuration,
                                                        options: launchOptions) {
                result in
                    guard let value = result.value else {
                        NSLog("[AppDelegate] Installation failed: '\(String(describing: result.error))'")
                        return
                    }
                    NSLog("[AppDelegate] MeetingDoctors framework initialization succeeded with identifier: '\(value.installationId)'")
            }
            NSLog("[AppDelegate] Synchronous installation identifier: '\(uuid?.uuidString ?? "no uuid")'")
        }
        
        _ = super.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
}
