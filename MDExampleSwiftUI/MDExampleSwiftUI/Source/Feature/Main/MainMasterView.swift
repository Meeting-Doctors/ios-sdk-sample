//  Copyright © 2024 MeetingDoctors S.L. All rights reserved.

import SwiftUI

struct MainMasterView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("main_master_section_components_title")) {
                    NavigationLink("main_master_buttons") {
                        
                    }
                    
                    NavigationLink("main_master_labels") {
                       
                    }
                }
                
                Section(header: Text("main_master_section_about_title")) {
                    HStack {
                        Text("main_master_section_about_text")
                        Spacer()
                        Text("\(Bundle.main.appVersionLong) (\(Bundle.main.appBuild))")
                    }
                }
            }
            .navigationTitle("main_master_title")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainMasterView_Previews: PreviewProvider {
    static var previews: some View {
        MainMasterView()
    }
}

