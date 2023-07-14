//
//  NotificationApplicationDelegate.swift
//  Mediquo Swift Example App
//
//  Created by Xavi Roig Aznar on 16/9/21.
//  Copyright © 2021 Edgar Paz Moreno. All rights reserved.
//

import MeetingDoctorsSDK
import MeetingDoctorsCore
import MeetingDoctorsSchema
import UserNotifications

class NotificationApplicationDelegate: NSObject, ApplicationServicePlugin {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {}

    func application(_: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {}

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        MeetingDoctors.didReceiveRemoteNotification(application, with: userInfo) {
            (result: MeetingDoctorsResult<UIBackgroundFetchResult>) in
            print("[NotificationApplicationDelegate] Case 1")
            do {
                completionHandler(try result.unwrap())
            } catch {
                completionHandler(.failed)
            }
        }
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension NotificationApplicationDelegate: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_ userNotificationCenter: UNUserNotificationCenter,
                                       willPresent notification: UNNotification,
                                       withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        MeetingDoctors.userNotificationCenter(userNotificationCenter, willPresent: notification) { result in
            print("[NotificationApplicationDelegate] Case 2")
            do {
                completionHandler(try result.unwrap())
            } catch {
                completionHandler([])
            }
        }
        
    }

    public func userNotificationCenter(_ userNotificationCenter: UNUserNotificationCenter,
                                       didReceive response: UNNotificationResponse,
                                       withCompletionHandler completionHandler: @escaping () -> Void) {
        print("[NotificationApplicationDelegate] didReceive response")
        
        print("[NotificationApplicationDelegate] mustAttendPush")
        MeetingDoctors.userNotificationCenter(userNotificationCenter, didReceive: response) { result in
            print("[NotificationApplicationDelegate] Case 3")
            result.process(doSuccess: { _ in
                completionHandler()
            }, doFailure: { error in
                if let mediQuoError = error as? MeetingDoctorsError,
                    case let .messenger(reason) = mediQuoError,
                    case let .cantNavigateTopViewControllerIsNotMessengerViewController(deeplinkOption) = reason,
                    let launchScreen: MenuTypeSelectorViewController = UIApplication.shared.keyWindow?.rootViewController as? MenuTypeSelectorViewController {
                    _ = launchScreen.deeplink(.messenger(option: deeplinkOption), animated: false)
                    completionHandler()
                } else if let mediQuoError = error as? MeetingDoctorsError,
                    case let .videoCall(reason) = mediQuoError,
                        case .cantNavigateExternalOriginIsRequired = reason,
                    let launchScreen: MenuTypeSelectorViewController = UIApplication.shared.keyWindow?.rootViewController as? MenuTypeSelectorViewController {
                    _ = launchScreen.deeplink(.videoCall, animated: false)
                    completionHandler()
                } else {
                    NSLog("[MediQuoApplicationPlugin] Error user notification center: \(error)")
                    completionHandler()
                }
            })
        }
        
    }
}


