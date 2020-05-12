//
//  MovieTableViewController.swift
//  CinemaApp
//
//  Created by Dynamo Software on 2.05.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    var cinema: Cinema?
    var movies = [
        Movie(title: "Tomb Rider", showTime:"11:00"),
        Movie(title: "The Bourne Legacy", showTime: "12:00"),
        Movie(title: "Ice Age 4", showTime: "10:00"),
        Movie(title: "Three billboards outside Ebbing, Missouri", showTime: "13:00")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let cinema = cinema else {return}
        
        navigationItem.title = cinema.title
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell
        let movie = movies[indexPath.row]
        cell?.update(with: movie)
        
        return cell ?? UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MakeReservation" {
            guard let destination = segue.destination as? ReservationViewController else {return}
            
            let indexPath = tableView.indexPathForSelectedRow!
            destination.movie = movies[indexPath.row]
            destination.cinema = cinema
        }
    }
}

