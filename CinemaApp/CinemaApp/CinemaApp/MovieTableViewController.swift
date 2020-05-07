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
    
//    weak var delegate: SelectMovieTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cinema = cinema {
            self.navigationItem.title = cinema.title
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.showTime
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        tableView.deselectRow(at: indexPath, animated: true)
////        movie = movies[indexPath.row]
////        delegate?.didSelect(movie!)
//        //tableView.reloadData()
//
//        performSegue(withIdentifier: "MakeReservation", sender: tableView.indexPath)
//
//    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MakeReservation" {
            let destination = segue.destination as! ReservationTableViewController
            let indexPath = tableView.indexPathForSelectedRow!
            destination.movie = movies[indexPath.row]
            destination.cinema = cinema
        }

    }
    
}

//protocol SelectMovieTableViewControllerDelegate: class {
//    func didSelect(_ movie: Movie)
//}
