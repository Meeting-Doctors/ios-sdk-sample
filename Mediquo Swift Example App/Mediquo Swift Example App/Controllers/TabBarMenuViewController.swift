//
//  TabBarMenuViewController.swift
//  Mediquo Swift Example App
//
//  Created by Xavi Roig Aznar on 30/8/21.
//  Copyright © 2021 Edgar Paz Moreno. All rights reserved.
//

import UIKit
import MeetingDoctorsSDK
import MeetingDoctorsController
import MeetingDoctorsCore
import MeetingDoctorsSchema

class TabBarMenuViewController: UITabBarController {

    private var chatViewController: UIViewController!
    private var videoCallViewController: UIViewController!
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
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let messengerResult = MediQuo.messengerViewController()
        if let controller: UINavigationController = messengerResult.value {
            self.chatViewController = controller
            self.chatViewController.tabBarItem.image = R.image.chat()?.imageByMakingWhiteBackgroundTransparent()
            self.viewControllers?.insert(self.chatViewController, at: 0)
        } else {
            NSLog("[BottomBarViewController] Failed to instantiate messenger with error '\(String(describing: messengerResult.error))'")
        }
        
        let navController = UINavigationController(rootViewController: VideoCallViewController())
        navController.title = "VideoCall"
        navController.tabBarItem.image = R.image.videocallCamera()?.image(alpha: 1)
        self.viewControllers?.insert(navController, at: 1)
        
        do {
            let hxView = try MediQuo.medicalHistoryViewController().unwrap()
            
            hxView.navigationItem.leftBarButtonItem = MediQuo.style?.rootLeftBarButtonItem
            hxView.navigationController?.navigationBar.isOpaque = true
            let hxMQView = UINavigationController(rootViewController: hxView)
            hxMQView.extendedLayoutIncludesOpaqueBars = false // set true if tabbar is opaque
            
            self.medicalHistoryViewController = hxMQView
            self.medicalHistoryViewController.title = "Medical History"
            self.medicalHistoryViewController.tabBarItem.image = R.image.medicalHistory()
            self.viewControllers?.insert(self.medicalHistoryViewController, at: 2)
            
        } catch {
            NSLog("[MediQuoLoader] Failed to instantiate messenger with error '\(error)'")
        }
         
    }
    
    private func setBadgeNumber(badgeCount: Int, tabBarItem: UITabBarItem?) {
        var badge: String?
        if badgeCount > 0 {
            badge = String(badgeCount)
        }
        tabBarItem?.badgeValue = badge
    }
    
    private func configMediQuoStyle() {

        MediQuo.style?.rootLeftBarButtonItem = UIBarButtonItem(image: R.image.back(), style: .plain, target: self, action: #selector(self.backBtnPressed))
        
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
        
        let messengerResult = MediQuo.messengerViewController()
        if let controller: UINavigationController = messengerResult.value {
            controller.modalPresentationStyle = .overFullScreen
            presenter.present(controller, animated: true)
        } else {
            NSLog("[ViewController] Failed to instantiate messenger with error '\(String(describing: messengerResult.error))'")
        }
    }

}
