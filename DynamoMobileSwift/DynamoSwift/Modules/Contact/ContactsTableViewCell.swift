//
//  ContactsTableViewCell.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 4.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit

typealias ContactCellConfigurator = BaseViewConfigurator<ContactsTableViewCell>

class ContactsTableViewCell: UITableViewCell, Configurable {
    @IBOutlet weak var entityTypeLabel: UILabel!
    @IBOutlet weak var entityNameLabel: UILabel!
    @IBOutlet weak var entityIconLabel: UILabel!
    
    func configureWith(_ data: Contact) {
        entityTypeLabel.text = data.es
        entityNameLabel.text = data.name
        let image = EntityStyleUtil.entityImageFor(type: "Contact", title: data.name)
        entityIconLabel.text = image.char
        entityIconLabel.textColor = image.color
    }
}

enum ItemIcon: String {
    case documentPDF = "Θ"
    case documentWord = "Ξ"
    case documentExcel = "Σ"
    case documentOther = "Φ"
    case documentPPT = "Χ"
    case documentPicture = "Τ"
    
    case entityContact = "Й"
    case entityCompany = "Л"
    case entityProperty = "П"
    case entityPropertyOpportunity = "У"
    case entityDeal = "Ф"
    case entityDealOpportunity = "Ч"
    case entityEvent = "И"
    case entityTask = "К"
    case entityDocument = "З"
    case entityActivity = "Б"
    case entityFund = "Ц"
    case entityInvestorAccount = "Ш"
    case entityAccountBalance = "Щ"
    case entityTransaction = "Ь"
    case entityInvestorOpportunity = "Ъ"
    case entitySecurity = "Ы"
    case entityReport = "Ё"
    
    case entityIdea = "Э"
    
    case entityOther = "Ψ"
    case favorites = "b"
    case nearItem = "N"
    case settings = "h"
    
    case folder = "j"
    case checkMark = "Ю"
}

extension ItemIcon {
    // swiftlint:disable all
    static func entityIcon(type: String?, label: String?, title: String?) -> (char: String, color: UIColor) {
        let imageChar: ItemIcon
        let color: UIColor
        switch type {
        case "Property":
            imageChar = .entityProperty
            color = #colorLiteral(red: 1, green: 0.8, blue: 0.4, alpha: 1)
        case "PropertyOpportunity":
            imageChar = .entityPropertyOpportunity
            color = #colorLiteral(red: 0.9984819293, green: 0.8010034561, blue: 0.400400579, alpha: 1)
        case "Contact":
            imageChar = .entityContact
            color = #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1)
        case "Investor":
            imageChar = .entityCompany
            color = #colorLiteral(red: 0.2, green: 0.4, blue: 0.8, alpha: 1)
        case "Deal":
            imageChar = .entityDeal
            color = #colorLiteral(red: 0.9984819293, green: 0.8010034561, blue: 0.400400579, alpha: 1)
        case "DealOpportunity":
            imageChar = .entityDealOpportunity
            color = #colorLiteral(red: 0.9984819293, green: 0.8010034561, blue: 0.400400579, alpha: 1)
        case "Event":
            imageChar = .entityEvent
            color = #colorLiteral(red: 0.6009272933, green: 0.7989198565, blue: 0.9982574582, alpha: 1)
        case "Task":
            imageChar = .entityTask
            color = #colorLiteral(red: 0.6009272933, green: 0.7989198565, blue: 0.9982574582, alpha: 1)
        case "Document":
            imageChar = .entityDocument
            color = #colorLiteral(red: 0.6009272933, green: 0.7989198565, blue: 0.9982574582, alpha: 1)
        case "Activity":
            imageChar = .entityActivity
            color = #colorLiteral(red: 0.6009272933, green: 0.7989198565, blue: 0.9982574582, alpha: 1)
        case "Fund":
            imageChar = .entityFund
            color = #colorLiteral(red: 1, green: 0.5990101695, blue: 0.6006528735, alpha: 1)
        case "InvestorAccount":
            imageChar = .entityInvestorAccount
            color = #colorLiteral(red: 1, green: 0.5990101695, blue: 0.6006528735, alpha: 1)
        case "AccountBalance":
            imageChar = .entityAccountBalance
            color = #colorLiteral(red: 1, green: 0.5990101695, blue: 0.6006528735, alpha: 1)
        case "Transaction":
            imageChar = .entityTransaction
            color = #colorLiteral(red: 1, green: 0.5990101695, blue: 0.6006528735, alpha: 1)
        case "InvestorOpportunity":
            imageChar = .entityInvestorOpportunity
            color = #colorLiteral(red: 1, green: 0.5990101695, blue: 0.6006528735, alpha: 1)
        case "Security":
            imageChar = .entitySecurity
            color = #colorLiteral(red: 1, green: 0.5990101695, blue: 0.6006528735, alpha: 1)
        case "DynamoReport":
            imageChar = .entityReport
            color = #colorLiteral(red: 1, green: 0.5990101695, blue: 0.6006528735, alpha: 1)
        case "Idea":
            imageChar = .entityIdea
            color = #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1)
        case "favorites":
            imageChar = .favorites
            color = #colorLiteral(red: 0.9411764706, green: 0.9607843137, blue: 0.9803921569, alpha: 1)
        case "nearItems":
            imageChar = .nearItem
            color = #colorLiteral(red: 0.7999292612, green: 0.8000452518, blue: 0.7999039292, alpha: 1)
        case "settings":
            imageChar = .settings
            color = #colorLiteral(red: 0.9411764706, green: 0.9607843137, blue: 0.9803921569, alpha: 1)
        default:
            let firstLetter = label == nil
                ? String(title?.uppercased().first ?? "Ψ")
                : String(label?.uppercased().first ?? "Ψ")
            
            guard let imageKey = EntityStyleUtil.iconKeys[firstLetter] else {
                return (ItemIcon.entityOther.rawValue, #colorLiteral(red: 0.6, green: 0.8, blue: 0.4, alpha: 1))
            }
            
            return(imageKey, #colorLiteral(red: 0.6, green: 0.8, blue: 0.4, alpha: 1))
        }
        
        return (imageChar.rawValue, color)
    }
    
    static var folderIcon: (char: String, color: UIColor) {
        return (ItemIcon.folder.rawValue, #colorLiteral(red: 0.9411764706, green: 0.9607843137, blue: 0.9803921569, alpha: 1))
    }
    
    static func documentIcon(type: String?) -> (char: String, color: UIColor) {
        let imageChar: ItemIcon
        let color: UIColor
        switch type {
        case "pdf":
            imageChar = .documentPDF
            color = #colorLiteral(red: 1, green: 0.6, blue: 0.6, alpha: 1)
        case "doc", "docx":
            imageChar = .documentWord
            color = #colorLiteral(red: 0.6, green: 0.8, blue: 1, alpha: 1)
        case "xls", "xlsx":
            imageChar = .documentExcel
            color = #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1)
        case "png", "PNG", "jpg", "jpeg":
            imageChar = .documentPicture
            color = #colorLiteral(red: 1, green: 0.8, blue: 0.4, alpha: 1)
        case "pptx":
            imageChar = .documentPPT
            color = #colorLiteral(red: 0.8, green: 0, blue: 0, alpha: 1)
        default:
            imageChar = .documentOther
            color = #colorLiteral(red: 0.8, green: 0.8, blue: 1, alpha: 1)
        }
        
        return (imageChar.rawValue, color)
    }
}

class EntityStyleUtil {
    static let iconKeys = [
        "A": "б",
        "B": "в",
        "C": "г",
        "D": "д",
        "E": "ё",
        "F": "ж",
        "G": "з",
        "H": "и",
        "I": "й",
        "J": "к",
        "K": "л",
        "L": "м",
        "M": "н",
        "N": "п",
        "O": "т",
        "P": "ф",
        "Q": "ч",
        "R": "ц",
        "S": "ш",
        "T": "щ",
        "U": "ь",
        "V": "ъ",
        "W": "ы",
        "X": "э",
        "Y": "ю",
        "Z": "я",
        "0": "0",
        "1": "1",
        "2": "2",
        "3": "3",
        "4": "4",
        "5": "5",
        "6": "6",
        "7": "7",
        "8": "8",
        "9": "9"
    ]
    
    static func entityImageFor(type: String?, title: String = "") -> (char: String, color: UIColor) {
        let entityLabel = EntitiesManager.shared.getEntityLabelFor(name: type)
        let item = ItemIcon.entityIcon(type: type, label: entityLabel, title: title)
        let char = item.char
        let color = item.color
        return (char, color)
    }
}
