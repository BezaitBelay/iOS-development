//
//  InfoViewController.swift
//  CinemaApp
//
//  Created by Dynamo Software on 4.05.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    var cinema: Cinema?
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var workingTimeLabel: UILabel!
    @IBOutlet weak var telephoneLabel: UILabel!
    @IBOutlet weak var parkingPlacesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFields()
    }
    
    private func updateFields() {
        guard let currentCinema = cinema else {return}
            image1.image  = currentCinema.mainImages
            image2.image = currentCinema.secondImage
            addressLabel.text = "Address: \n" + currentCinema.address
            workingTimeLabel.text = "Working hours: \n" + currentCinema.workingHours
            telephoneLabel.text = "Phone number: \n " + currentCinema.phoneNumber
            parkingPlacesLabel.text = "Available parking places: \n" + String(currentCinema.parkingPlaces)
        navigationItem.title = currentCinema.title
        navigationItem.backBarButtonItem?.title = "Back"
    }
}
