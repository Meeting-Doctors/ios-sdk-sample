//
//  Copyright © 2017 Edgar Paz Moreno. All rights reserved.
//

import MDChatSDK
import AppTrackingTransparency
import AdSupport
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var welcomeTitleLabel: UILabel!
    @IBOutlet weak var openChatButton: UIButton!

    private var isAuthenticated: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareUI()
        requestPermission()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if var style = MDChat.style {
            style.rootLeftBarButtonItem = buildFingerPrintButtonItem()
            MDChat.style = style
        }
    }

    @IBAction func openChatAction(_ sender: UIButton) {
        doLogin(completion: { isSuccess in
            if isSuccess {
                self.unreadMessageCount()
                self.present()
            }
        })
    }

    private func prepareUI() {
        setTexts()
        configureStyle()
    }
    
    private func setTexts() {
        self.welcomeTitleLabel.text = "Bienvenido a la demo de Mediquo.\nPulsa el botón para continuar"
        self.openChatButton.setTitle("Abrir el chat", for: .normal)
    }
    
    private func configureStyle() {
        if var style = MDChat.style {
            style.navigationBarColor = UIColor(red: 84 / 255, green: 24 / 255, blue: 172 / 255, alpha: 1)
            style.accentTintColor = UIColor(red: 0, green: 244 / 255, blue: 187 / 255, alpha: 1)
            style.preferredStatusBarStyle = .lightContent
            style.navigationBarTintColor = .white
            style.navigationBarOpaque = true
            style.titleColor = .white
            MDChat.style = style
        }
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
        MDChat.authenticate(token: userToken) {
            let success = $0.isSuccess
            self.isAuthenticated = success
            if let completion = completion { completion(success) }
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
                    
                    // Now that we are authorized we can get the IDFA
                    print(ASIdentifierManager.shared().advertisingIdentifier)
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
                        let idfa = ASIdentifierManager.shared().advertisingIdentifier
                        print(idfa.uuidString)
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
