import UIKit

class ReservationTableViewCell: UITableViewCell {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var cinemaName: UILabel!
    @IBOutlet weak var movieTime: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(with reservation: Reservation) {
        movieName.text = reservation.movieName
        cinemaName.text = reservation.cinemaName
        movieTime.text = reservation.movieShowTime
    }
}
