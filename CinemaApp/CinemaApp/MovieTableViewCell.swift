//
//  MovieTableViewCell.swift
//  CinemaApp
//
//  Created by Dynamo Software on 12.05.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with movie: Movie) {
        mainTextLabel.text = movie.title
        detailLabel.text = movie.showTime
    }

}
