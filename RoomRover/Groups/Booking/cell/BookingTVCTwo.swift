//
//  BookingTVCTwo.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 17.09.23.
//

import UIKit

class BookingTVCTwo: UITableViewCell {

    // - UI
    @IBOutlet var flyFrom: UILabel!
    @IBOutlet var countyCity: UILabel!
    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var countOfNights: UILabel!
    @IBOutlet var hotel: UILabel!
    @IBOutlet var room: UILabel!
    @IBOutlet var food: UILabel!
    
    func setupUI(model: BookingModel) {
        flyFrom.text = model.departure
        countyCity.text = model.arrivalCountry
        dataLabel.text = "\(model.tourDateStart) - \(model.tourDateStop)"
        countOfNights.text = "\(model.numberOfNights) ночей"
        hotel.text = model.hotelName
        room.text = model.room
        food.text = model.nutrition
    }
    
}
