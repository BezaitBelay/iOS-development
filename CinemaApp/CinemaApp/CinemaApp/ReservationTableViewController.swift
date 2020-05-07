//
//  ReservationTableViewController.swift
//  CinemaApp
//
//  Created by Dynamo Software on 2.05.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class ReservationTableViewController: UITableViewController,UITextViewDelegate {
    
    var movie: Movie?
    var cinema: Cinema?
    var reservation: Reservation?
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var ticketsCountTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFields()
        ticketsCountTextField.becomeFirstResponder()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        self.ticketsCountTextField.delegate = self
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = text.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return text == numberFiltered
    }
    
    // MARK: - Table view data source
    
    func updateFields() {
        if let movie = self.movie {
            movieNameLabel.text = movie.title
            ticketsCountTextField.text = ""
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ReserveUnwind" else {return}
        
        let movieName = movieNameLabel.text ?? ""
        let ticketsQuantity = Int(ticketsCountTextField.text ?? "0")
        let cinemaName = cinema?.title ?? ""
        let movieTime = movie?.showTime ?? ""
        
        reservation = Reservation(cinemaName: cinemaName, ticketsCount:ticketsQuantity!, movieName: movieName, movieShowTime: movieTime)
    }
    
    
}
