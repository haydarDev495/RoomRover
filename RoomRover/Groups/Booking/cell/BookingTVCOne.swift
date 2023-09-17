//
//  BookingTVCOne.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 16.09.23.
//

import UIKit


class BookingTVCOne: UITableViewCell {

    // - UI 
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var starLabel: UILabel!
    @IBOutlet var button: UIButton!
    
    func setupUI(model: BookingModel) {
        starLabel.text = "\(model.horating) \(model.ratingName)"
        nameLabel.text = model.hotelName
        button.setTitle(model.hotelAdress, for: .normal)
    }
}
