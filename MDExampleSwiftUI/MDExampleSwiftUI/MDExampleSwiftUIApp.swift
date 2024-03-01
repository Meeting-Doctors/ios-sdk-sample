//  Copyright © 2023 MeetingDoctors S.L. All rights reserved.

import SwiftUI

@main
struct MDExampleSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainMasterView()
        }
    }
}
