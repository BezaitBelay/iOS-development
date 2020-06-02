//
//  Bundle+VersionNumber.swift
//  MLiTP
//
//  Created by Martin Vasilev on 23.08.18.
//  Copyright © 2018 Upnetix. All rights reserved.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    var versionAndBuildNumber: String {
        guard let version = releaseVersionNumber, let build = buildVersionNumber else { return "" }
        return "\(version).\(build)"
    }
}
