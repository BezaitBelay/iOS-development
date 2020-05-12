//
//  CinemaTableViewCell.swift
//  CinemaApp
//
//  Created by Dynamo Software on 29.04.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

protocol CinemaTableViewCellDelegate: class {
    func didTapFrom(cell: CinemaTableViewCell)
}

class CinemaTableViewCell: UITableViewCell {

    @IBOutlet weak var cinemaImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var workingHoursLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    weak var delegate: CinemaTableViewCellDelegate?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with cinema: Cinema) {
        cinemaImage.image = cinema.mainImages
        titleLabel.text = cinema.title
        workingHoursLabel.text = cinema.workingHours
    }
    
    @IBAction func didTapOn(_ sender: Any) {
        delegate?.didTapFrom(cell: self)
    }
}

