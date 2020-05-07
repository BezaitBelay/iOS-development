//
//  CinemaTableViewController.swift
//  CinemaApp
//
//  Created by Dynamo Software on 29.04.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class CinemaTableViewController: UITableViewController {
    
    
    
    var cinemas = [Cinema(images: [UIImage.self(named:"arena1"), UIImage.self(named: "arena2")],title: "Kino Arena",address: "bul. Tsarigradsko Shose 115, Sofia", workingHours: "mon-fri: \n13:00 - 23:00 \nsat-sun: \n11:00-24:00",phoneNumber: "0898460557", parkingPlaces: 100),
                   Cinema(images: [UIImage.self(named:"cinema1"), UIImage.self(named: "cinema2")], title: "Cinema city", address: "bul. Aleksander Stamboliiski 101, Sofia", workingHours: "mon-sun: \n12:00 - 24:00", phoneNumber: "029292929", parkingPlaces: 300),
                   Cinema(images: [UIImage.self(named:"odeon1"), UIImage.self(named: "odeon2")], title: "Kino Odeon", address: "bul. Patriarh Evtimii 1, Sofia", workingHours: "mon-fri: \n14:00 - 23:00 \nsat-sun: \n12:00-24:00", phoneNumber: "029892469", parkingPlaces: 0)]
    
    
    var reservations = [Reservation]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CinemaCell", for: indexPath) as! CinemaTableViewCell
            let cinema = cinemas[indexPath.row]
            cell.update(with: cinema)
            
            
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell", for: indexPath) as! ReservationTableViewCell
            let reservation = (reservations[indexPath.row])
            cell.update(with: reservation)
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindToCinemaTable(segue: UIStoryboardSegue) {
        guard segue.identifier == "ReserveUnwind" else { return }
        let source = segue.source as! ReservationTableViewController
        
        if let reservation = source.reservation {
            reservations.append(reservation)
            print(reservations[0].cinemaName)
            let newIndexPath = IndexPath(row: reservations.count-1 , section: 1)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        }
        
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender as! UIButton?
        {
            let cinemaCell = sender.superview?.superview?.superview as? CinemaTableViewCell
            let cinema = cinemas.filter({$0.title == cinemaCell?.titleLabel.text})
            if segue.identifier == "ShowMovie" {
                let destionation = segue.destination as? MovieTableViewController
                destionation?.cinema = cinema.first
            }
            
            if segue.identifier == "InfoSegue" {
                let destination = segue.destination as? InfoViewController
                destination?.cinema = cinema.first
            }
        }
    }
    
    
}


