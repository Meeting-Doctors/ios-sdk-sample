//
//  MediquoSwiftExampleAppPlugin.swift
//  Mediquo Swift Example App
//
//  Created by Xavi Roig Aznar on 30/8/21.
//  Copyright © 2021 Edgar Paz Moreno. All rights reserved.
//

import UIKit
import MDChatSDK

class MediquoSwiftExampleAppPlugin: NSObject {

    static let style:  MDChatStyleType = {
        var style: MDChatStyleType = MDChatStyle()
        style.navigationBarColor = UIColor(from: 0x00BAF3)
        style.inboxCellStyle = .meetingDoctors(overlay: .clear,
                                        badge: UIColor(from: 0x00BAF3),
                                        speciality: UIColor(from: 0x00BAF3),
                                        specialityIcon: .clear,
                                        hideSchedule: false)
        style.accentTintColor = UIColor(from: 0x00BAF3)
        style.navigationBarBackIndicatorImage = UIImage(named: "Back")
        style.preferredStatusBarStyle = .lightContent
        
        
        style.navigationBarTintColor = .white
        style.navigationBarOpaque = true
        style.titleColor = .white
        
        style.secondaryTintColor = UIColor(from: 0x0059A6)

        style.messageTextOutgoingColor = UIColor(red: 0x4D / 255.0, green: 0x4E / 255.0, blue: 0x52 / 255.0, alpha: 1.0)
        style.messageTextIncomingColor = .white
        style.bubbleBackgroundOutgoingColor = UIColor(from: 0xFFFFFF)
        style.bubbleBackgroundIncomingColor = UIColor(from: 0x00BAF3)
        
        style.showCollegiateNumber = false
        style.chatBackgroundView = ChatBackgroundView()

        // MARK: VideoCall
        
        ///Customizable images
        style.images.meetingDoctorsMedicalHistoryImages.allergiesIcon = UIImage(named: "AllergiesIcon")
        style.images.meetingDoctorsMedicalHistoryImages.derivationsIcon = UIImage(named: "DerivationsIcon")
        style.images.meetingDoctorsMedicalHistoryImages.diseasesIcon = UIImage(named: "DiseasesIcon")
        style.images.meetingDoctorsMedicalHistoryImages.medicationsIcon = UIImage(named: "MedicationsIcon")
        style.images.meetingDoctorsMedicalHistoryImages.myDocumentsIcon = UIImage(named: "MyDocumentsIcon")
        style.images.meetingDoctorsMedicalHistoryImages.recipeIcon = UIImage(named: "RecipeIcon")
        style.images.meetingDoctorsMedicalHistoryImages.videoCallReportIcon = UIImage(named: "VideoCallCamera")
        
        ///Customizable strings
        style.strings.meetingDoctorsMedicalHistoryStrings.recipeBodyMessage = "Texto del cuerpo de la receta médica."
        style.strings.meetingDoctorsMedicalHistoryStrings.recipeDisclaimerDescription = "Texto descriptivo del disclaimer de la receta médica."
        style.strings.meetingDoctorsMedicalHistoryStrings.recipeDisclaimerTitle = "Título del disclaimer de la receta médica."
        style.strings.meetingDoctorsMedicalHistoryStrings.recipeEmptyMessage = "Texto de receta vacía."
        style.strings.meetingDoctorsProfessionalListStrings.listTitleHeader = "Chatea con expertos"
        
        style.conditionsDismiss = {}
        
        let emptyView = UIView()
        emptyView.backgroundColor = .yellow
        let button = UIButton()
        button.setTitle("test meetingdoctors", for: .normal)
        button.setTitleColor(.red, for: .normal)
        
        emptyView.addSubviewFullViewFit(to: button)
        style.emptyView = emptyView
        
        style.preferredStatusBarStyle = .lightContent
        
        return style
    }()
    
}