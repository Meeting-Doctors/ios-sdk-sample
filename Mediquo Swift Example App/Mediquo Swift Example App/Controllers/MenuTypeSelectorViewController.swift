//
//  MenuTypeSelectorViewController.swift
//  Mediquo Swift Example App
//
//  Created by Xavi Roig Aznar on 13/8/21.
//  Copyright © 2021 Edgar Paz Moreno. All rights reserved.
//

import UIKit
import MediQuo
import AppTrackingTransparency

class MenuTypeSelectorViewController: UIViewController {

    private var isAuthenticated: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureStyle()
        
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
    
    private func configureStyle() {
        MediQuo.style = MediquoSwiftExampleAppPlugin.style
    }

    private func buildFingerPrintButtonItem() -> UIBarButtonItem {
        let image = R.image.fingerprint()
        let style: UIBarButtonItem.Style = .plain
        let target = self
        let action = #selector(authenticationState)
        return UIBarButtonItem(image: image, style: style, target: target, action: action)
    }

    private func unreadMessageCount() {
        MediQuo.unreadMessageCount {
            if let count = $0.value {
                UIApplication.shared.applicationIconBadgeNumber = count
                NSLog("[LaunchScreenViewController] Pending messages to read '\(count)'")
            }
        }
    }

    private func present() {
        let messengerResult = MediQuo.messengerViewController()
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
        if let style = MediQuo.style, let buttonItem = style.rootLeftBarButtonItem {
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
        let userToken: String = MediQuo.getUserToken()
        MediQuo.authenticate(token: userToken) {
            let success = $0.isSuccess
            self.isAuthenticated = success
            if let completion = completion { completion(success) }
        }
    }

    private func doLogout() {
        MediQuo.shutdown { _ in self.isAuthenticated = false }
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
