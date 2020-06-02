//
//  ContactsT.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 1.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell, Configurable {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var imageOverlayLabel: UILabel!
    @IBOutlet weak var titleLabelCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var separatowView: UIView!
    
    private var imageLabelText = ""
    private var imageLabelTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    private var imageContainerColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    
    func configureWith(_ data: ContactsCellModel) {
//        imageLabelText = data.imageName
//        imageLabelTextColor = data.imageColor
//        imageContainerColor = data.itemColor
        
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle
//        imageOverlayLabel.text = data.imageName
//        imageContainerView.backgroundColor = data.itemColor
        titleLabelCenterYConstraint.constant = data.titleLabelCenterConstraintConst
//        imageOverlayLabel.textColor = data.imageColor
        separatowView.isHidden = !data.shouldShowSeparator
        
        if data.isPicker {
            setSelected(data.isSelected)
            arrowImage.isHidden = true
        }
        isSelected = data.isSelected
    }
    
    func setSelected(_ selected: Bool) {
        backgroundColor = selected ? #colorLiteral(red: 0.9333333333, green: 0.937254902, blue: 0.9450980392, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        imageOverlayLabel.text = /*selected ? ItemIcon.checkMark.rawValue :*/ imageLabelText
        imageOverlayLabel.textColor = selected ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : imageLabelTextColor
        imageOverlayLabel.backgroundColor = selected ? #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) : imageContainerColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        guard selected else { return }
        
        imageContainerView.backgroundColor = imageContainerColor
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        guard highlighted else { return }
        
        imageContainerView.backgroundColor = imageContainerColor
    }
}

typealias GenericCellConfigurator = BaseViewConfigurator<ContactsTableViewCell>

class ContactsCellModel {
    let title: String
    var subtitle: String
//    var imageName: String
//    var itemColor: UIColor
    var overlay: String = ""
    var titleLabelCenterConstraintConst: CGFloat
    var isPicker = false
    var isSelected = false
//    var imageColor: UIColor
   // var entityData: BaseEntityModel?
    var shouldShowSeparator = false
    private var itemType: String?
    private var isFolder: Bool
    
    init(title: String = "",
         subtitle: String = "",
         shouldCenteringLabels: Bool = false,
         isPicker: Bool = false,
         isSelected: Bool = false,
         isFolder: Bool = false,
//         imageColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
         itemType: String? = nil,
       //  entityData: BaseEntityModel? = nil,
         shouldShowSeparator: Bool = false) {
        
        self.title = title
        self.subtitle = subtitle
        self.isSelected = isSelected
        self.isPicker = isPicker
//        self.imageColor = isFolder ? #colorLiteral(red: 0.7999292612, green: 0.8000452518, blue: 0.7999039292, alpha: 1) : imageColor
        self.itemType = itemType
        self.isFolder = isFolder
        self.shouldShowSeparator = shouldShowSeparator
        self.titleLabelCenterConstraintConst = ContactsCellModel.calculateTitleLabelCenterConstraintConst(title: title,
                                                                                                             subtitle: subtitle,
                                                                                                             shouldCenteringLabels: shouldCenteringLabels)
//        self.entityData = entityData
        //let type = itemType ?? entityData?.es
        
        //let image = EntityStyleUtil.entityImageFor(type: type, isFolder: isFolder, title: title)
       // imageName = image.char
     //   itemColor = image.color
    }
    
    static func calculateTitleLabelCenterConstraintConst(title: String,
                                                         subtitle: String,
                                                         shouldCenteringLabels: Bool) -> CGFloat {
        let value: CGFloat
        if shouldCenteringLabels {
            value = title.isEmpty ? -15 : (subtitle.isEmpty ? 0 : -10)
        } else {
            value = -10
        }
        return value
    }
}
