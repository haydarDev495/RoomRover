//
//  BookingLayout.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 14.09.23.
//

import UIKit

class BookingLayout {
    
    private var vc: BookingVC
    
    init(vc: BookingVC) {
        self.vc = vc
        configure()
    }
    
    func setupUI(model: BookingModel, animate: Bool) {
//        vc.starLabel.text = "\(model.horating) \(model.ratingName)"
//        vc.hotelNameLabel.text = model.hotelName
//        vc.blueButtonText.setTitle(model.hotelAdress, for: .normal)
//        vc.cityFrom.text = model.departure
//        vc.countyFor.text = model.arrivalCountry
//        vc.date.text = "\(model.tourDateStart) - \(model.tourDateStop)"
//        vc.night.text = "\(model.numberOfNights)"
//        vc.hotelName.text = model.hotelName
//        vc.hotelDescrip.text = model.hotelAdress
//        vc.tourPrice.text = "\(model.tourPrice) ₽"
//        vc.oilPrice.text = "\(model.fuelCharge) ₽"
//        vc.servicePrice.text = "\(model.serviceCharge) ₽"
        
        let allPrice = "\(model.tourPrice + model.fuelCharge + model.serviceCharge) ₽"
//        vc.allPrice.text = "\(allPrice)"
        vc.choiseRoom.setTitle("Оплатить \(allPrice)", for: .normal)
        showAllView(animate: animate)
    }
}

// MARK: -
// MARK: Configure
private extension BookingLayout {
    
    func configure() {
        
    }
    
    func showAllView(animate: Bool) {
        if animate {
            vc.activityIndicator.isHidden = true
            vc.activityIndicator.stopAnimating()
        } else {
            vc.activityIndicator.stopAnimating()
        }
        
        UIView.transition(with: vc.view, duration: animate ? 0.0 : 0.3, options: .transitionCrossDissolve) { [weak self] in
            guard let sSelf = self else  { return }
            sSelf.vc.tableView.reloadData()
            sSelf.vc.tableView.alpha = 1
        }
    }
}
