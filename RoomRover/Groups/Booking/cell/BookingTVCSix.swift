//
//  BookingTVCSix.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 17.09.23.
//

import UIKit


class BookingTVCSix: UITableViewCell {

    // - UI
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var serviceLabel: UILabel!
    @IBOutlet var oilLabel: UILabel!
    @IBOutlet var tourLabel: UILabel!
    
    func setupUI(model: BookingModel) {
        tourLabel.text = "\(model.tourPrice) ₽"
        oilLabel.text = "\(model.fuelCharge) ₽"
        serviceLabel.text = "\(model.serviceCharge) ₽"
        priceLabel.text = "\(model.tourPrice + model.fuelCharge + model.serviceCharge) ₽"
    }
}
