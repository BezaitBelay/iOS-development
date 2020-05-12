//
//  ReservationTableViewController.swift
//  CinemaApp
//
//  Created by Dynamo Software on 2.05.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class ReservationViewController: UIViewController {
    
    var movie: Movie?
    var cinema: Cinema?
    var reservation: Reservation?
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var ticketsCountTextField: UITextField!
    @IBOutlet weak var reserveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFields()
        ticketsCountTextField.becomeFirstResponder()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        self.ticketsCountTextField.delegate = self
    }
    
    private func updateFields() {
        if let movie = self.movie {
            movieNameLabel.text = movie.title
            ticketsCountTextField.text = ""
        }
        navigationItem.title = "Buy Tickets"
        reserveButton.layer.cornerRadius = 5
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ReserveUnwind" else {return}
        
        let movieName = movieNameLabel.text ?? ""
        let ticketsQuantity = Int(ticketsCountTextField.text ?? "0") ?? 0
        let cinemaName = cinema?.title ?? ""
        let movieTime = movie?.showTime ?? ""
        reservation = Reservation(cinemaName: cinemaName, ticketsCount:ticketsQuantity, movieName: movieName, movieShowTime: movieTime)
    }
}

// MARK: - UITextFieldDelegate
extension ReservationViewController :UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
}
