//
//  Copyright © 2017 Edgar Paz Moreno. All rights reserved.
//

import MediQuo
import MediQuoCore

@UIApplicationMain
class AppDelegate: ApplicationServiceDelegate {
    
    override var services: [ApplicationServicePlugin] {
        return [NotificationApplicationDelegate(),
                FirebaseApplicationDelegate()]
    }
    
    public override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if let clientName: String = MediQuo.getClientName(),
            let clientSecret: String = MediQuo.getClientSecret() {
            let configuration = MediQuo.Configuration(id: clientName, secret: clientSecret, enableVideoCall: true, environment: .development)
            let uuid: UUID? = MediQuo.initialize(with: configuration, options: launchOptions) {  result in
                guard let value = result.value else {
                    NSLog("[AppDelegate] Installation failed: '\(String(describing: result.error))'")
                    return
                }
                NSLog("[AppDelegate] Mediquo framework initialization succeeded with identifier: '\(value.installationId)'")
            }
            NSLog("[AppDelegate] Synchronous installation identifier: '\(uuid?.uuidString ?? "no uuid")'")
        }
        
        _ = super.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
}
