//
//  FirebaseApplicationDelegate.swift
//  Mediquo Swift Example App
//
//  Created by Xavi Roig Aznar on 16/9/21.
//  Copyright © 2021 Edgar Paz Moreno. All rights reserved.
//

import Firebase
import FirebaseMessaging
import MDChatSDK
import UserNotifications

open class FirebaseApplicationDelegate: NSObject, ApplicationServicePlugin {
    public func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        return true
    }
}


extension FirebaseApplicationDelegate: MessagingDelegate {
    // Refresh_token
    public func messaging(_: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let token = fcmToken {
            print("[FirebaseApplicationDelegate] Firebase registration token: \(token)")

            let dataDict: [String: String] = ["token": token]
            NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
            // Note: This callback is fired at each app startup and whenever a new token is generated.
            MDChat.registerFirebaseForNotifications(token: token) { result in
                result.process(doSuccess: { _ in
                    print("[FirebaseApplicationDelegate] Token registered correctly")
                }, doFailure: { error in
                    print("[FirebaseApplicationDelegate] Error registering token: \(error)")
                })
            }
        } else {
            print("[FirebaseApplicationDelegate] Firebase registration token: Token is nil")
        }
    }

    // [END ios_10_data_message]
}
