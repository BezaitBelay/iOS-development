//
//  ReservationTableViewCell.swift
//  CinemaApp
//
//  Created by Dynamo Software on 4.05.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class ReservationTableViewCell: UITableViewCell {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var cinemaName: UILabel!
    @IBOutlet weak var movieTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(with reservation: Reservation) {
        movieName.text = reservation.movieName
        cinemaName.text = reservation.cinemaName
        movieTime.text = reservation.movieShowTime
    }
}
