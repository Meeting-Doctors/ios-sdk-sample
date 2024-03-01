//  Copyright © 2024 MeetingDoctors S.L. All rights reserved.

import SwiftUI

struct MainMasterView: View {
    
    @State private var isPresentingMedicalHistory = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Title")) {
                    NavigationLink("Professional List") {
                        ProfessionalListRepresentable()
                            .edgesIgnoringSafeArea(.all)
                            .navigationBarHidden(true)
                    }
                    NavigationLink("Medical History") {
                        MedicalHistoryRepresentable()
                            .edgesIgnoringSafeArea(.all)
                            .navigationBarHidden(true)
                    }
                }
                
                Section(header: Text("Title")) {
                    HStack {
                        Text("Section")
                        Spacer()
                        Text("\(Bundle.main.appVersionLong) (\(Bundle.main.appBuild))")
                    }
                }
            }
            .navigationTitle("Main")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainMasterView_Previews: PreviewProvider {
    static var previews: some View {
        MainMasterView()
    }
}

