//
//  CinemaTableViewController.swift
//  CinemaApp
//
//  Created by Dynamo Software on 29.04.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class CinemaTableViewController: UITableViewController {
    
    var cinemas = [Cinema(mainImages: UIImage.self(named:"arena1"), secondImage: UIImage.self(named: "arena2"),title: "Kino Arena",address: "bul. Tsarigradsko Shose 115, Sofia", workingHours: "mon-fri: \n13:00 - 23:00 \nsat-sun: \n11:00-24:00",phoneNumber: "0898460557", parkingPlaces: 100),
                   Cinema(mainImages: UIImage.self(named:"cinema1"), secondImage: UIImage.self(named: "cinema2"), title: "Cinema city", address: "bul. Aleksander Stamboliiski 101, Sofia", workingHours: "mon-sun: \n12:00 - 24:00", phoneNumber: "029292929", parkingPlaces: 300),
                   Cinema(mainImages: UIImage.self(named:"odeon1"), secondImage: UIImage.self(named: "odeon2"), title: "Kino Odeon", address: "bul. Patriarh Evtimii 1, Sofia", workingHours: "mon-fri: \n14:00 - 23:00 \nsat-sun: \n12:00-24:00", phoneNumber: "029892469", parkingPlaces: 0)]
    var reservations = [Reservation]()
    var selectedCinema: Cinema?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return cinemas.count
        case 1:
            return reservations.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var initCell = UITableViewCell()
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CinemaCell", for: indexPath) as! CinemaTableViewCell
            let cinema = cinemas[indexPath.row]
            cell.update(with: cinema)
            cell.delegate = self
            initCell = cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell", for: indexPath) as! ReservationTableViewCell
            let reservation = (reservations[indexPath.row])
            cell.update(with: reservation)
            initCell = cell
        }
        
        return initCell
    }
    
    @IBAction func unwindToCinemaTable(segue: UIStoryboardSegue) {
        guard segue.identifier == "ReserveUnwind" else { return }
        let source = segue.source as! ReservationViewController
        
        if let reservation = source.reservation {
            reservations.append(reservation)
            let newIndexPath = IndexPath(row: reservations.count-1 , section: 1)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cinema = selectedCinema else {return}
        
        if segue.identifier == "ShowMovie" {
            let destionation = segue.destination as? MovieTableViewController
            destionation?.cinema = cinema
        }
        
        if segue.identifier == "InfoSegue" {
            let destination = segue.destination as? InfoViewController
            destination?.cinema = cinema
        }
    }
}

// MARK: - CinemaTableViewCellDelegate
extension CinemaTableViewController: CinemaTableViewCellDelegate {
    func didTapFrom(cell: CinemaTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        
        let cinema = cinemas[indexPath.row]
        selectedCinema = cinema
    }
}

