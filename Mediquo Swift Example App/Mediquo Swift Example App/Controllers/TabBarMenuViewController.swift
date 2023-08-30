//
//  TabBarMenuViewController.swift
//  Mediquo Swift Example App
//
//  Created by Xavi Roig Aznar on 30/8/21.
//  Copyright © 2021 Edgar Paz Moreno. All rights reserved.
//

import UIKit
import MDChatSDK

class TabBarMenuViewController: UITabBarController {

    private var chatViewController: UIViewController!
    private var chatHighlightedViewController: UIViewController!
    private var medicalHistoryViewController: UIViewController!
    
    static func storyboardInstance()-> TabBarMenuViewController? {
        
        if let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarMenuViewController") as? TabBarMenuViewController {
            return viewController
        }
        
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configMediQuoStyle()
        
        self.viewControllers = []
        
        let image = UIImage(named: "iconMenuChat")
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let messengerResult = MDChat.messengerViewController(withTitle: "Default List")
        if let controller: UINavigationController = messengerResult.value {
            self.chatViewController = controller
            self.viewControllers?.insert(self.chatViewController, at: 0)
            self.viewControllers?[0].tabBarItem = UITabBarItem(title: "Consultas", image: image, selectedImage: image)
        } else {
            NSLog("[BottomBarViewController] Failed to instantiate messenger with error '\(String(describing: messengerResult.error))'")
        }
        
        let filter = MDChatFilter(profiles: [.nutrition], excludeRoles: true)
        let messengerHighlightedResult = MDChat.messengerViewController(withTitle:"Highlighted List", highlightedSpecialities: filter)

        if let controller: UINavigationController = messengerHighlightedResult.value {
            self.chatHighlightedViewController = controller
            self.viewControllers?.insert(self.chatHighlightedViewController, at: 1)
            self.viewControllers?[1].tabBarItem = UITabBarItem(title: "Consultas Highlighted", image: image, selectedImage: image)
        } else {
            NSLog("[BottomBarViewController] Failed to instantiate messenger with error '\(String(describing: messengerHighlightedResult.error))'")
        }
        
        
        do {
            let hxView = try MDChat.medicalHistoryViewController().unwrap()
            
            hxView.navigationItem.leftBarButtonItem = MDChat.style?.rootLeftBarButtonItem
            hxView.navigationController?.navigationBar.isOpaque = true
            let hxMQView = UINavigationController(rootViewController: hxView)
            hxMQView.extendedLayoutIncludesOpaqueBars = false // set true if tabbar is opaque
            
            self.medicalHistoryViewController = hxMQView
            self.medicalHistoryViewController.title = "Medical History"
            self.medicalHistoryViewController.tabBarItem.image = UIImage(named: "MedicalHistory")
            self.viewControllers?.insert(self.medicalHistoryViewController, at: 2)
            
        } catch {
            NSLog("[MediQuoLoader] Failed to instantiate messenger with error '\(error)'")
        }
        
        self.bindNotifications()
         
    }
    
    private func setBadgeNumber(badgeCount: Int, tabBarItem: UITabBarItem?) {
        var badge: String?
        if badgeCount > 0 {
            badge = String(badgeCount)
        }
        tabBarItem?.badgeValue = badge
    }
    
    private func configMediQuoStyle() {

        MDChat.style?.rootLeftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(self.backBtnPressed))
        
    }
    
    func regularNavigationBar() {
        
        if let navCont = self.viewControllers?.first as? UINavigationController, let controller = navCont.viewControllers.first {
            controller.navigationController?.navigationBar.barStyle = .black
            controller.navigationController?.navigationBar.isTranslucent = false
            controller.navigationController?.navigationBar.barTintColor = .green
            controller.navigationController?.navigationBar.tintColor = .white
        }
    }
    
    @objc func backBtnPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func presentProfessionalList(onVC presenter: UIViewController? = nil) {
        guard let presenter = presenter else { return }
        
        let messengerResult = MDChat.messengerViewController()
        if let controller: UINavigationController = messengerResult.value {
            controller.modalPresentationStyle = .overFullScreen
            presenter.present(controller, animated: true)
        } else {
            NSLog("[ViewController] Failed to instantiate messenger with error '\(String(describing: messengerResult.error))'")
        }
    }
    
    private func bindNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.termsDeclined(notification:)), name: Notification.Name.MeetingDoctors.TermsAndConditions.Declined, object: nil)
    }
    
    @objc func termsDeclined(notification: Notification) {
        guard let viewController = notification.userInfo?[Notification.Key.MeetingDoctors.TermsAndConditions.Declined] as? UIViewController else {
            NSLog("[TabBarMenuViewController] Message sent could not be obtained from successful message notification event")
            return
        }

        NSLog("[TabBarMenuViewController] Terms Declined: \(viewController)")

        viewController.dismiss(animated: false)
    }

}
