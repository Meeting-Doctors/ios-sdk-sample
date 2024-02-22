//  Copyright © 2023 MeetingDoctors S.L. All rights reserved.

import Foundation

extension Bundle {
    public var appName: String {
        self.getInfo("CFBundleName")
    }
    
    public var displayName: String {
        self.getInfo("CFBundleDisplayName")
    }
    
    public var language: String {
        self.getInfo("CFBundleDevelopmentRegion")
    }
    
    public var identifier: String {
        self.getInfo("CFBundleIdentifier")
    }
    public var copyright: String {
        self.getInfo("NSHumanReadableCopyright").replacingOccurrences(of: "\\\\n", with: "\n")
    }
    
    public var appBuild: String {
        self.getInfo("CFBundleVersion")
    }
    
    public var appVersionLong: String {
        self.getInfo("CFBundleShortVersionString")
    }
    
    public var appVersionShort: String {
        self.getInfo("CFBundleShortVersion")
    }
    
    fileprivate func getInfo(_ str: String) -> String {
        infoDictionary?[str] as? String ?? "⚠️"
    }
}
