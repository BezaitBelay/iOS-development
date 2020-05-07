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
        // Do any additional setup after loading the view.
    }
    

    func updateFields() {
        guard let currentCinema = cinema else {return}
            image1.image  = currentCinema.images[0]
            image2.image = currentCinema.images[1]
            addressLabel.text = "Address: \n" + currentCinema.address
            workingTimeLabel.text = "Working hours: \n" + currentCinema.workingHours
            telephoneLabel.text = "Phone number: \n " + currentCinema.phoneNumber
            parkingPlacesLabel.text = "Available parking places: \n" + String(currentCinema.parkingPlaces)
        navigationItem.title = currentCinema.title
        navigationItem.backBarButtonItem?.title = "Back"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
