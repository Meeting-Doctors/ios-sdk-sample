// Copyright © 2022 MeetingDoctors S.L. All rights reserved.

import UIKit
import MeetingDoctorsSDK

class MDSwiftExampleAppPlugin: NSObject {

    static let style: MeetingDoctorsStyleType = {
        var style: MeetingDoctorsStyle = MeetingDoctorsStyle()
        style.navigationBarColor = UIColor(from: 0x00BAF3)
        style.inboxCellStyle = .meetingDoctors(overlay: .clear,
                                        badge: UIColor(from: 0x00BAF3),
                                        speciality: UIColor(from: 0x00BAF3),
                                        specialityIcon: .clear,
                                        hideSchedule: false)
        style.accentTintColor = UIColor(from: 0x00BAF3)
        style.navigationBarBackIndicatorImage = UIImage(named: "Back")
        style.preferredStatusBarStyle = .lightContent
        style.showMeetingDoctorsBackgroundImage = true
        style.navigationBarTintColor = .white
        style.navigationBarOpaque = true
        style.titleColor = .white
        style.inboxTitle = "Professional List"

        style.showMeetingDoctorsBackgroundImage = false
        style.secondaryTintColor = UIColor(from: 0x0059A6)

        style.messageTextOutgoingColor = UIColor(red: 0x4D / 255.0, green: 0x4E / 255.0, blue: 0x52 / 255.0, alpha: 1.0)
        style.messageTextIncomingColor = .white
        style.bubbleBackgroundOutgoingColor = UIColor(from: 0xEEEEEE)
        style.bubbleBackgroundIncomingColor = UIColor(from: 0x00BAF3)
        
        style.showCollegiateNumber = true

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
        
        style.conditionsDismiss = {}
        
        let emptyView = UIView()
        emptyView.backgroundColor = .yellow
        let button = UIButton()
        button.setTitle("test meetingdoctors", for: .normal)
        button.setTitleColor(.red, for: .normal)
        
        emptyView.addSubviewFullViewFit(to: button)
        style.emptyView = emptyView
        style.medicalHistoryOptions = [.allergy(nil), .disease(nil), .medication(nil), .myDocuments, .videoCallReport(nil), .prescription]
        
        style.preferredStatusBarStyle = .lightContent
        
        return style
    }()
    
}
