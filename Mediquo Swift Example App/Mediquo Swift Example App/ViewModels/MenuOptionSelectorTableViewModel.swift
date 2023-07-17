//
//  MenuOptionSelectorTableViewModel.swift
//  Mediquo Swift Example App
//
//  Created by Xavi Roig Aznar on 20/8/21.
//  Copyright © 2021 Edgar Paz Moreno. All rights reserved.
//

import UIKit
import MDChatSDK

class MenuOptionSelectorTableViewModel {

    
    var cellViewModels = [MenuOptionCellViewModel]()
    
    var presentedViewController: UIViewController?
    
    func registerCellViewModels(onVC: UIViewController? = nil) {
        cellViewModels.append(MenuOptionCellViewModel(titleLabel: "Professional List", action: {
            self.professionalListCellAction(onVC: onVC)
        }, tag: .professionalList))
        cellViewModels.append(MenuOptionCellViewModel(titleLabel: "Medical History", action: {
            self.presentMedicalHistory(onVC: onVC)
        }, tag: .medicalHistory))
    }
    
    private func professionalListCellAction(onVC: UIViewController? = nil) {
        self.unreadMessageCount()
        self.presentProfessionalList(onVC: onVC)
    }
    
    private func unreadMessageCount() {
        MDChat.unreadMessageCount {
            if let count = $0.value {
                UIApplication.shared.applicationIconBadgeNumber = count
                NSLog("[LaunchScreenViewController] Pending messages to read '\(count)'")
            }
        }
    }
    
    private func presentProfessionalList(onVC presenter: UIViewController? = nil) {
        guard let presenter = presenter else { return }
        
        
        
        let messengerResult = MDChat.messengerViewController()
        if let controller: UINavigationController = messengerResult.value {
            presentedViewController = controller
            controller.modalPresentationStyle = .overFullScreen
            presenter.present(controller, animated: true)
        } else {
            NSLog("[ViewController] Failed to instantiate messenger with error '\(String(describing: messengerResult.error))'")
        }
    }
    
    private func presentMedicalHistory(onVC presenter: UIViewController? = nil) {
        do {
            let hxView = try MDChat.medicalHistoryViewController().unwrap()
            
            hxView.navigationItem.leftBarButtonItem = MDChat.style?.rootLeftBarButtonItem
            hxView.navigationController?.navigationBar.isOpaque = true
            let hxMQView = UINavigationController(rootViewController: hxView)
            hxMQView.extendedLayoutIncludesOpaqueBars = true // set true if tabbar is opaque
            hxMQView.modalPresentationStyle = .overFullScreen
            
            presentedViewController = hxMQView
            
            presenter?.present(hxMQView, animated: true, completion: nil)
        } catch {
            NSLog("[MediQuoLoader] Failed to instantiate messenger with error '\(error)'")
        }
    }
    
    
}

enum MenuOption {
    case professionalList
    case videoCall
    case medicalHistory
}

class MenuOptionCellViewModel {
    var titleLabel: String
    var action: ()-> Void
    var tag: MenuOption
    
    init(titleLabel: String, action: @escaping(()-> Void), tag: MenuOption) {
        self.titleLabel = titleLabel
        self.action = action
        self.tag = tag
    }
}
