//  Copyright © 2023 MeetingDoctors S.L. All rights reserved.

import SwiftUI
import UIKit
import MeetingDoctorsSDK

struct MedicalHistoryRepresentable: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIViewController {
        let rootViewController = MedicalHistoryViewController()
        rootViewController.presentationMode = self.presentationMode
        let navigationController = MDNavigationController(rootViewController: rootViewController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

class MedicalHistoryViewController: UIViewController {
    
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
        let medicalHistory = MeetingDoctors.medicalHistoryViewController()
        if let viewController: UIViewController = medicalHistory.value {
            self.addContentController(viewController,
                                      to: self.view)
        } else {
            NSLog("Failed to instantiate historial with error \(String(describing:  medicalHistory.error))")
        }
    }
    
    @objc private func closeAction() {
        self.presentationMode?.wrappedValue.dismiss()
    }
    
}
