//
//  MenuTypeSelectorViewController.swift
//  Mediquo Swift Example App
//
//  Created by Xavi Roig Aznar on 13/8/21.
//  Copyright © 2021 Edgar Paz Moreno. All rights reserved.
//

import UIKit
import MDChatSDK
import Firebase
import AppTrackingTransparency

class MenuTypeSelectorViewController: UIViewController {
    
    private var isAuthenticated: Bool = false
    
    var pendingDeeplinkOption: MDChatDeeplinkOption = .unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindNotifications()

        self.configureStyle()
        
    }
    
    //MARK: - Notification Center Events
    func bindNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.authenticationSucceded(notification:)), name: Notification.Name.MeetingDoctors.Authentication.Succeed, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(userUpdated(notification:)), name: Notification.Name.MeetingDoctors.Authentication.UserStatusChanged, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(styleChanged(notification:)), name: Notification.Name.MeetingDoctors.Style.StyleChanged, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(userUpdated(notification:)), name: Notification.Name.MeetingDoctors.Authentication.UserBannedChanged, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(socketMessageRead(notification:)), name: Notification.Name.MeetingDoctors.Socket.MessageRead, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.messageReceived(notification:)), name: Notification.Name.MeetingDoctors.Socket.MessageReceived, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(watchDogAct), name: Notification.Name.MeetingDoctors.Socket.WatchDogAct, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.unreadMessagesChanged(notification:)), name: Notification.Name.MeetingDoctors.Message.UnreadChanged, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.messageSent(notification:)), name: Notification.Name.MeetingDoctors.Message.Sent, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.messageRead(notification:)), name: Notification.Name.MeetingDoctors.Message.Read, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.chatEntered), name: Notification.Name.MeetingDoctors.Messenger.ChatEntered, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.chatLeft), name: Notification.Name.MeetingDoctors.Messenger.ChatLeft, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.prepareNpsButton), name: Notification.Name.MeetingDoctors.NPS.NPSSendSucceed, object: nil)
    }
    
    @objc func authenticationSucceded(notification: Notification) {
        guard let account: AccountModel = notification.userInfo?[Notification.Key.MeetingDoctors.Authentication] as? AccountModel else {
            NSLog("Account model could not be obtained from successful authentication notification event")
            return
        }
        
        NSLog("You have the account model available to use")
        
    }
    
    @objc func userUpdated(notification: Notification) {
        guard let account: AccountModel = notification.userInfo?[Notification.Key.MeetingDoctors.Authentication] as? AccountModel else {
            NSLog("Account model could not be obtained from successful authentication notification event")
            return
        }
        
        NSLog("You have the account model available to use")
    }
    
    @objc func styleChanged(notification: Notification) {
        guard let style: MDChatStyle = notification.userInfo?[Notification.Key.MeetingDoctors.Style] as? MDChatStyle else {
            NSLog("Style could not be obtained from successful style changed notification event")
            return
        }
        NSLog("You have the style object available to use")
    }
    
    @objc func socketMessageRead(notification: Notification) {
        guard let message: MessageSchema = notification.userInfo?[Notification.Key.MeetingDoctors.Socket.MessageRead] as? MessageSchema else {
            NSLog("Message model could not be obtained from successful message read notification event")
            return
        }
        NSLog("You have the message model available to use")
    }
    
    @objc func messageReceived(notification: Notification) {
        guard let message: MessageSchema = notification.userInfo?[Notification.Key.MeetingDoctors.Socket.MessageReceived] as? MessageSchema else {
            NSLog("Message model could not be obtained from successful message received notification event")
            return
        }
        NSLog("You have the message model available to use")
    }
    
    @objc func watchDogAct() {
        NSLog("You are observing the watchDogAct event")
    }
    
    @objc func unreadMessagesChanged(notification: Notification) {
        guard let unreadMessages: Int = notification.userInfo?[Notification.Key.MeetingDoctors.Message.UnreadChanged] as? Int else {
            NSLog("Number of unread message could not be obtained from successful unreadMessagesChanged notification event")
            return
        }
        NSLog("You have \(unreadMessages) unread messages")
    }
    
    @objc func messageSent(notification: Notification) {
        guard let message: MDChatMessageType = notification.userInfo?[Notification.Key.MeetingDoctors.Message.Sent] as? MDChatMessageType else {
            NSLog("Message sent could not be obtained from successful message notification event")
            return
        }
        NSLog("Message sent for speciality: \(message.contactSpeciality)")
    }
    
    @objc func messageRead(notification: Notification) {
        guard let message: MDChatMessageType = notification.userInfo?[Notification.Key.MeetingDoctors.Message.Read] as? MDChatMessageType else {
            NSLog("Message read could not be obtained from successful message notification event")
            return
        }
        NSLog("Message read for speciality: \(message.contactSpeciality)")
    }
    
    @objc func chatEntered() {
        NSLog("You are observing the chat entered event")
    }
    
    @objc func chatLeft() {
        NSLog("You are observing the chat left event")
    }
    
    @objc func prepareNpsButton() {
        NSLog("You are observing the NPS send succeed left event")
    }

    @IBAction func navControllerBtnPressed(_ sender: Any) {
        doLogin { (succeed) in
            DispatchQueue.main.async {
                if succeed, let viewController = MenuOptionSelectorTableViewController.storyboardInstance() {
                    let navigationController = UINavigationController(rootViewController: viewController)
                    navigationController.modalPresentationStyle = .overFullScreen
                    self.present(navigationController, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    @IBAction func tabBarControllerBtnPressed(_ sender: Any) {
        doLogin { (succeed) in
            DispatchQueue.main.async {
                if succeed, let viewController = TabBarMenuViewController.storyboardInstance() {
                    let navigationController = UINavigationController(rootViewController: viewController)
                    navigationController.modalPresentationStyle = .overFullScreen
                    self.present(navigationController, animated: true, completion: nil)
                }
            }
        }
    }
    
    private var mediquoDivider: MDChatDivider<UIView>? {
        var divider: MDChatDivider<UIView>
        let rect: CGRect = CGRect(origin: .zero, size: CGSize(width: 375, height: 350))
        let dividerView: DividerContentView = DividerContentView(frame: rect)
        divider = MDChatDivider(view: dividerView)

        return divider.add(configuration: { (cell, _) -> Void in
            cell.selectionStyle = .none
        }).add(selector: { (_, _, speciality, authorized, _) -> Bool in
            NSLog("[MediQuoLoader] Inbox item '\(speciality)' selected and authorized '\(authorized)'")

            return authorized
        })
    }

    private var mediquoTopDivider: MDChatDivider<UIView>? {
        var divider: MDChatDivider<UIView>
    
        let rect: CGRect = CGRect(origin: .zero, size: CGSize(width: 375, height: 350))
        let dividerView = DividerTopContentView(frame: rect)
        divider = MDChatDivider(view: dividerView)
    
        return divider.add(configuration: { [weak self] (cell, view) -> Void in
            cell.selectionStyle = .none
            (view as? DividerTopContentView)?.buttonAction = {
                DispatchQueue.main.async {
                    let alert: UIAlertController = UIAlertController(title: "Videollamada", message: "Activar videollamada", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
                    alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: { (_: UIAlertAction) in
                        
                        
                    }))
                    if let viewController = UIApplication().keyWindow?.rootViewController {
                        viewController.present(alert, animated: true, completion: nil)
                    }
                }
            }
        })
    }
    
    private func configureStyle() {
        MDChat.style = MediquoSwiftExampleAppPlugin.style
        MDChat.style?.divider = self.mediquoDivider
        
        if let professionalListTopDividerView = self.mediquoTopDivider {
            MDChat.style?.topDividers?.append(professionalListTopDividerView)
        }
        MDChat.updateStyle()
    }

    private func buildFingerPrintButtonItem() -> UIBarButtonItem {
        let image = UIImage(named: "Fingerprint")
        let style: UIBarButtonItem.Style = .plain
        let target = self
        let action = #selector(authenticationState)
        return UIBarButtonItem(image: image, style: style, target: target, action: action)
    }

    private func unreadMessageCount() {
        MDChat.unreadMessageCount {
            if let count = $0.value {
                UIApplication.shared.applicationIconBadgeNumber = count
                NSLog("[LaunchScreenViewController] Pending messages to read '\(count)'")
            }
        }
    }

    private func present() {
        let messengerResult = MDChat.messengerViewController()
        if let controller: UINavigationController = messengerResult.value {
            controller.modalPresentationStyle = .overFullScreen
            self.present(controller, animated: true)
        } else {
            NSLog("[ViewController] Failed to instantiate messenger with error '\(String(describing: messengerResult.error))'")
        }
    }

    @objc private func authenticationState() {
        changeColorFingerPrintByAuthState()
        changeStatus()
    }
    
    private func changeColorFingerPrintByAuthState() {
        if let style = MDChat.style, let buttonItem = style.rootLeftBarButtonItem {
            buttonItem.tintColor = isAuthenticated ? .red : view.tintColor
        }
    }
    
    private func changeStatus() {
        if !isAuthenticated {
            doLogin()
        } else {
            doLogout()
        }
    }
    
    private func doLogin(completion: ((Bool) -> Void)? = nil) {
        let userToken: String = MDChat.getUserToken()
        MDChat.authenticate(token: userToken) { [weak self] (result: MDChatResult<Void>) in
            
            let success = result.isSuccess
            
            if result.isSuccess {
                self?.isAuthenticated = success
                
                Messaging.messaging().token { token, error in
                    if let token = token {
                        MDChat.registerFirebaseForNotifications(token: token) { result in
                            result.process(doSuccess: { _ in
                                NSLog("[FirebaseApplicationPlugin] Token registered correctly")
                                completion?(success)
                            }, doFailure: { error in
                                NSLog("[FirebaseApplicationPlugin] Error registering token: \(error)")
                                completion?(success)
                            })
                        }
                    } else if let error = error {
                        NSLog("[FirebaseApplicationPlugin] Error getting token from firebase: \(error)")
                        completion?(success)
                    }
                }
            } else {
                completion?(success)
            }
        }
    }

    private func doLogout() {
        MDChat.shutdown { _ in self.isAuthenticated = false }
    }
    
    //NEWLY ADDED PERMISSIONS FOR iOS 14
    func oldRequestPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    // Tracking authorization dialog was shown
                    // and we are authorized
                    print("Authorized")
                case .denied:
                    // Tracking authorization dialog was
                    // shown and permission is denied
                    print("Denied")
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    print("Not Determined")
                case .restricted:
                    print("Restricted")
                @unknown default:
                    print("Unknown")
                }
            }
        }
    }

    func requestPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        // Authorized
//                        let idfa = ASIdentifierManager.shared().advertisingIdentifier
//                        print(idfa.uuidString)
                    print("Authorized")
                    case .denied,
                         .notDetermined,
                         .restricted:
                        break
                    @unknown default:
                        break
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func gotoAppPrivacySettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(url) else {
                assertionFailure("Not able to open App privacy settings")
                return
        }

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension MenuTypeSelectorViewController: MDChatDeeplinkViewControllerProtocol {
    public func deeplink(_ deeplinkOption:  MDChatDeeplinkOption, animated _: Bool) -> Bool {
        if let bottomBarViewController = self.presentedViewController as? MenuTypeSelectorViewController {
            // deeplinkFromInside
            return bottomBarViewController.deeplink(deeplinkOption, animated: false)
        } else {
            // deeplinkFromOutside
            self.pendingDeeplinkOption = deeplinkOption
            return true
        }
        return true
    }
}
