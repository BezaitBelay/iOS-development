//
//  Contact.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 3.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

struct EntityData: Codable {
    let success: Bool
    let links: Links?
    let data: [Contact]
    let error: String?
}

struct EntityDetailData: Codable {
    let success: Bool
    let links: Links?
    let data: [String: String]?
    let error: String?
}

enum ContactDetailSorting: String {
    case fullName = "fullname"
    case primarycontactemail = "primarycontactemail"
    case companyName = "companyname"
    case jobtitle = "jobtitle"
    case primarycontactphone = "primarycontactphone"
    case comments = "comments"
    case contactInfoCompanyLink = "contactinfo_companylink"
    
    var position: Int {
        switch self {
        case .fullName: return 0
        case .primarycontactemail: return 1
        case .companyName: return 2
        case .jobtitle: return 3
        case .primarycontactphone: return 4
        case .comments: return 5
        case .contactInfoCompanyLink: return 6
        }
    }
    
    var label: String {
        switch self {
        case .fullName: return "Full name"
        case .primarycontactemail: return "Email"
        case .companyName: return "Company name"
        case .jobtitle: return "Job title"
        case .primarycontactphone: return "Business phone"
        case .comments: return "Comments"
        case .contactInfoCompanyLink: return "Website"
        }
    }
}

struct Contact: Codable {
    var id: String
    var es: String
    var name: String
    //    var fullName: String?
    //    var email: String?
    //    var companyName: String?
    //    var jobTitle: String?
    //    var phone: String?
    //    var comments: String?
    //    var webSite: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case es = "_es"
        case name = "Identifier"
        //        case fullName = "FullName"
        //        case email = "Primarycontactemail"
        //        case companyName = " Companyname"
        //        case jobTitle = "Jobtitle"
        //        case phone = "Primarycontactphone"
        //        case comments = "Comments"
        //        case webSite = "ContactInfo_CompanyLink"
    }
}

struct Links: Codable {
    let link: String
    let nextLink: String?
    
    enum CodingKeys: String, CodingKey {
        case link = "self"
        case nextLink = "next"
    }
}
