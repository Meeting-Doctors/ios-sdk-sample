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
        style.navigationBarBackIndicatorImage = R.image.back()
        style.preferredStatusBarStyle = .lightContent
        style.titleFont = UIFont.systemFont(ofSize: 17)
        style.showMeetingDoctorsBackgroundImage = true
        style.navigationBarTintColor = .white
        style.navigationBarOpaque = true
        style.titleColor = .white
        style.inboxTitle = "Professional List"
        style.inboxBackgroundColor = .clear

        style.showMeetingDoctorsBackgroundImage = false
        style.secondaryTintColor = UIColor(from: 0x0059A6)

        style.messageTextOutgoingColor = UIColor(red: 0x4D / 255.0, green: 0x4E / 255.0, blue: 0x52 / 255.0, alpha: 1.0)
        style.messageTextIncomingColor = .white
        style.bubbleBackgroundOutgoingColor = UIColor(from: 0xEEEEEE)
        style.bubbleBackgroundIncomingColor = UIColor(from: 0x00BAF3)
        
        style.showCollegiateNumber = true

        // MARK: VideoCall

        style.videoCallIconDoctorNotAssignedImage = R.image.videoCallDoctorNotAssigned()
        style.videoCallBackgroundImage = R.image.icon()?.imageByMakingWhiteBackgroundTransparent()
        style.videoCallTopBackgroundColor = UIColor(from: 0x00BAF3)
        style.videoCallBottomBackgroundColor = UIColor(from: 0x00BAF3).withAlphaComponent(0.4)
        style.videoCallTopBackgroundImageTintColor = nil
        style.videoCallBottomBackgroundImageTintColor = nil
        style.videoCallAcceptButtonBackgroundColor = UIColor(red: 3 / 255, green: 243 / 255, blue: 180 / 255, alpha: 1.0)
        style.videoCallCancelButtonBackgroundColor = UIColor(red: 239 / 255, green: 35 / 255, blue: 54 / 255, alpha: 1.0)
        style.videoCallCancelButtonTextColor = .white
        style.videoCallAcceptButtonTextColor = .white
        style.videoCallTitleTextColor = .white
        style.videoCallNextAppointmentTextColor = UIColor(from: 0x00BAF3)
        style.videoCallProfessionalNameTextColor = .black
        style.videoCallProfessionalSpecialityTextColor = UIColor(from: 0x00BAF3)
        style.videoCallIconDoctorNotAssignedImageTintColor = UIColor(from: 0x00BAF3)
        style.videoCallIconDoctorBackgroundColor = .white

        ///Customizable images
        style.images.meetingDoctorsMedicalHistoryImages.allergiesIcon = R.image.allergiesIcon()
        style.images.meetingDoctorsMedicalHistoryImages.derivationsIcon = R.image.derivationsIcon()
        style.images.meetingDoctorsMedicalHistoryImages.diseasesIcon = R.image.diseasesIcon()
        style.images.meetingDoctorsMedicalHistoryImages.medicationsIcon = R.image.medicationsIcon()
        style.images.meetingDoctorsMedicalHistoryImages.myDocumentsIcon = R.image.myDocumentsIcon()
        style.images.meetingDoctorsMedicalHistoryImages.recipeIcon = R.image.recipeIcon()
        style.images.meetingDoctorsMedicalHistoryImages.videoCallReportIcon = R.image.videocallCamera()
        
        ///Customizable strings
        style.strings.meetingDoctorsMedicalHistoryStrings.recipeBodyMessage = "Texto del cuerpo de la receta médica."
        style.strings.meetingDoctorsMedicalHistoryStrings.recipeDisclaimerDescription = "Texto descriptivo del disclaimer de la receta médica."
        style.strings.meetingDoctorsMedicalHistoryStrings.recipeDisclaimerTitle = "Título del disclaimer de la receta médica."
        style.strings.meetingDoctorsMedicalHistoryStrings.recipeEmptyMessage = "Texto de receta vacía."
        
        style.strings.meetingDoctorsVideoCallStrings.videoCallPrepareCallingDoctorCurrentStatusCall = "Preparando videollamada."
        style.strings.meetingDoctorsVideoCallStrings.videoCallPrepareCallingDoctorNextAppointment = "Siguiente cita."
        style.strings.meetingDoctorsVideoCallStrings.videoCallWaitingDoctorCurrentStatusCall = "Esperando al médico..."
        style.strings.meetingDoctorsVideoCallStrings.videoCallWaitingDoctorNextAppointment = "Esperando al siguiente médico."
        
        
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
