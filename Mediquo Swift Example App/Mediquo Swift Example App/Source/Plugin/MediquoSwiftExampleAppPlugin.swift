//
//  MediquoSwiftExampleAppPlugin.swift
//  Mediquo Swift Example App
//
//  Created by Xavi Roig Aznar on 30/8/21.
//  Copyright © 2021 Edgar Paz Moreno. All rights reserved.
//

import UIKit
import MediQuo

class MediquoSwiftExampleAppPlugin: NSObject {

    static let style: MediQuoStyleType = {
        var style: MediQuoStyle = MediQuoStyle()
        style.navigationBarColor = UIColor(red: 84 / 255, green: 24 / 255, blue: 172 / 255, alpha: 1)
        style.inboxCellStyle = .mediquo(overlay: UIColor(red: 146 / 255, green: 122 / 255, blue: 198 / 255, alpha: 64 / 255),
                                        badge: UIColor(red: 66 / 255, green: 206 / 255, blue: 206 / 255, alpha: 1),
                                        speciality: UIColor(red: 84 / 255, green: 24 / 255, blue: 172 / 255, alpha: 1),
                                        specialityIcon: .white,
                                        hideSchedule: false)
        style.accentTintColor = UIColor(red: 0, green: 244 / 255, blue: 187 / 255, alpha: 1)
        style.navigationBarBackIndicatorImage = R.image.back()
        style.preferredStatusBarStyle = .lightContent
        style.titleFont = UIFont.systemFont(ofSize: 17)
        style.showMediQuoBackgroundImage = true
        style.navigationBarTintColor = .white
        style.navigationBarOpaque = true
        style.titleColor = .white

        // style.showMediQuoBackgroundImage = false
        style.secondaryTintColor = UIColor(red: 76 / 255, green: 214 / 255, blue: 215 / 255, alpha: 1)

        style.showCollegiateNumber = true

        // MARK: VideoCall

        style.videoCallIconDoctorNotAssignedImage = R.image.videoCallDoctorNotAssigned()
        style.videoCallBackgroundImage = R.image.icon()
        style.videoCallTopBackgroundColor = UIColor(red: 73 / 255, green: 19 / 255, blue: 164 / 255, alpha: 1)
        style.videoCallBottomBackgroundColor = UIColor(red: 215 / 255, green: 209 / 255, blue: 226 / 255, alpha: 1)
        style.videoCallTopBackgroundImageTintColor = UIColor(red: 97 / 255, green: 51 / 255, blue: 176 / 255, alpha: 1)
        style.videoCallBottomBackgroundImageTintColor = UIColor(red: 232 / 255, green: 229 / 255, blue: 238 / 255, alpha: 1)
        style.videoCallAcceptButtonBackgroundColor = UIColor(red: 56 / 255, green: 201 / 255, blue: 201 / 255, alpha: 1.0)
        style.videoCallCancelButtonBackgroundColor = UIColor(red: 248 / 255, green: 0 / 255, blue: 80 / 255, alpha: 1.0)
        style.videoCallCancelButtonTextColor = .white
        style.videoCallAcceptButtonTextColor = .white
        style.videoCallTitleTextColor = .white
        style.videoCallNextAppointmentTextColor = UIColor(red: 54 / 255, green: 54 / 255, blue: 54 / 255, alpha: 1)
        style.videoCallProfessionalNameTextColor = UIColor(red: 73 / 255, green: 19 / 255, blue: 164 / 255, alpha: 1)
        style.videoCallProfessionalSpecialityTextColor = UIColor(red: 64 / 255, green: 64 / 255, blue: 64 / 255, alpha: 1)
        style.videoCallIconDoctorNotAssignedImageTintColor = UIColor(red: 73 / 255, green: 19 / 255, blue: 164 / 255, alpha: 1)
        style.videoCallIconDoctorBackgroundColor = style.videoCallBottomBackgroundColor ?? .white

        let emptyView = UIView()
        emptyView.backgroundColor = .yellow
        let button = UIButton()
        button.setTitle("test meetingdoctors", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(for: .touchUpInside) { _ in
            print("touched")
        }
        emptyView.addSubviewFullViewFit(to: button)
        style.emptyView = emptyView
        style.medicalHistoryOptions = [.allergy(nil), .disease(nil), .medication(nil), .myDocuments, .videoCallReport(nil)]

        return style
    }()
    
}
