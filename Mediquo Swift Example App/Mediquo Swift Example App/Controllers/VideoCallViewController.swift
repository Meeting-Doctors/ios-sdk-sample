//
//  VideoCallViewController.swift
//  Mediquo Swift Example App
//
//  Created by Xavi Roig Aznar on 31/8/21.
//  Copyright © 2021 Edgar Paz Moreno. All rights reserved.
//

import UIKit
import MediQuo

class VideoCallViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .gray
        
        startVideoCall()
        
    }
    
    
    private func startVideoCall() {
        self.checkVideoCallPermissions {
            DispatchQueue.main.async {
                MediQuo.deeplink(.videoCall, origin: self, animated: true) { result in
                    result.process(doSuccess: { response in
                        NSLog("[MediQuoLoader] Video call started")
                    }, doFailure: { error in
                        NSLog("[MediQuoLoader] Video call error \(error)")
                    })
                }
            }
        }
    }
}
