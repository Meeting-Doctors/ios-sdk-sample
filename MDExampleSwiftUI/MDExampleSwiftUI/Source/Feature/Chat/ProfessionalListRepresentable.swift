//  Copyright © 2023 MeetingDoctors S.L. All rights reserved.

import SwiftUI
import UIKit
import MeetingDoctorsSDK

struct ProfessionalListRepresentable: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIViewController {
        let rootViewController = ProfessionalListController()
        rootViewController.presentationMode = self.presentationMode
        let navigationController = MDNavigationController(rootViewController: rootViewController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

class ProfessionalListController: UIViewController {
    
    var presentationMode: Binding<PresentationMode>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.present()
    }
    
    private func setupUI() {
        let rightBarButtonItem = UIBarButtonItem(title: "Close",
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(closeAction))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func present() {
        let professionalList = MeetingDoctors.professionalListViewController()
        if let viewController: UIViewController = professionalList.value {
            self.addContentController(viewController,
                                      to: self.view)
        } else {
            NSLog("Failed to instantiate historial with error \(String(describing:  professionalList.error))")
        }
    }
    
    @objc private func closeAction() {
        self.presentationMode?.wrappedValue.dismiss()
    }
}

