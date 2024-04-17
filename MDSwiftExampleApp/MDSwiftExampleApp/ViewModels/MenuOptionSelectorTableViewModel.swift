// Copyright © 2022 MeetingDoctors S.L. All rights reserved.

import UIKit
import MeetingDoctorsSDK

class MenuOptionSelectorTableViewModel {

    
    var cellViewModels = [MenuOptionCellViewModel]()
    
    var presentedViewController: UIViewController?
    
    func registerCellViewModels(onVC: UIViewController? = nil) {
        cellViewModels.append(MenuOptionCellViewModel(titleLabel: "Professional List", action: {
            self.professionalListCellAction(onVC: onVC)
        }, tag: .professionalList))
        cellViewModels.append(MenuOptionCellViewModel(titleLabel: "Professional List without nab bar", action: {
            self.professionalListWithoutCellAction(onVC: onVC)
        }, tag: .professionalListWithoutNavBar))
        cellViewModels.append(MenuOptionCellViewModel(titleLabel: "Videocall", action: {
            self.startVideoCall(onVC: onVC)
        }, tag: .videoCall))
        cellViewModels.append(MenuOptionCellViewModel(titleLabel: "Medical History", action: {
            self.presentMedicalHistory(onVC: onVC)
        }, tag: .medicalHistory))
    }
    
    private func professionalListCellAction(onVC: UIViewController? = nil) {
        self.unreadMessageCount()
        self.presentProfessionalList(onVC: onVC)
    }
    
    private func professionalListWithoutCellAction(onVC: UIViewController? = nil) {
        self.unreadMessageCount()
        self.professionalListWithout(onVC: onVC)
    }
    
    private func unreadMessageCount() {
        MeetingDoctors.unreadMessageCount {
            if let count = $0.value {
                UIApplication.shared.applicationIconBadgeNumber = count
                NSLog("[LaunchScreenViewController] Pending messages to read '\(count)'")
            }
        }
    }
    
    private func presentProfessionalList(onVC presenter: UIViewController? = nil) {
        guard let presenter = presenter else { return }
        
        
        
        let messengerResult = MeetingDoctors.messengerViewController()
        if let controller: UINavigationController = messengerResult.value {
            presentedViewController = controller
            controller.modalPresentationStyle = .overFullScreen
            presenter.present(controller, animated: true)
        } else {
            NSLog("[ViewController] Failed to instantiate messenger with error '\(String(describing: messengerResult.error))'")
        }
    }
    
    private func professionalListWithout(onVC presenter: UIViewController? = nil) {
        guard let presenter = presenter,
        let viewController = ChatAssembler().viewController() else { return }
        presenter.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func startVideoCall(onVC origin: UIViewController? = nil) {
        origin?.checkVideoCallPermissions {
            DispatchQueue.main.async {
                MeetingDoctors.deeplink(.videoCall, origin: origin, animated: true) { result in
                    result.process(doSuccess: { _ in
                        NSLog("[MeetingDoctorsLoader] Video call started")
                    }, doFailure: { error in
                        NSLog("[MeetingDoctorsLoader] Video call error \(error)")
                    })
                }
            }
        }
    }
    
    private func presentMedicalHistory(onVC presenter: UIViewController? = nil) {
        do {
            let hxView = try MeetingDoctors.medicalHistoryViewController().unwrap()
            
            hxView.navigationItem.leftBarButtonItem = MeetingDoctors.style?.rootLeftBarButtonItem
            hxView.navigationController?.navigationBar.isOpaque = true
            let hxMQView = UINavigationController(rootViewController: hxView)
            hxMQView.extendedLayoutIncludesOpaqueBars = true // set true if tabbar is opaque
            hxMQView.modalPresentationStyle = .overFullScreen
            
            presentedViewController = hxView
            presenter?.navigationController?.pushViewController(hxView, animated: true)
        } catch {
            NSLog("[MeetingDoctorsLoader] Failed to instantiate messenger with error '\(error)'")
        }
    }
    
    
}

enum MenuOption {
    case professionalList
    case professionalListWithoutNavBar
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
