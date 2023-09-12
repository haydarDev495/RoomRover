//
//  HotelLayoutManager.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 12.09.23.
//

import UIKit

class HotelLayoutManager {
    private var vc: HotelVC
    
    init(vc: HotelVC) {
        self.vc = vc
    }
    
    func setupUI(model: HotelData, animate: Bool) {
        vc.starLabel.text = "\(model.rating) \(model.ratingName)"
        vc.hotelNameLabel.text = model.name
        vc.blueButton.setTitle(model.adress, for: .normal)
        vc.priceLabel.text = "от \(model.minimalPrice) ₽"
        vc.grayPriceLabel.text = model.priceForIt
        vc.firstGrayLabel.text = "   \(model.aboutTheHotel.peculiarities[0])   "
        vc.secondGrayLabel.text = "   \(model.aboutTheHotel.peculiarities[1])   "
        vc.thirdGrayLabel.text = "   \(model.aboutTheHotel.peculiarities[2])   "
        vc.fourthGrayLabel.text = "   \(model.aboutTheHotel.peculiarities[3])   "
        vc.hotelDescription.text = model.aboutTheHotel.description
        showAllView(animate: animate)
    }
}

// MARK: -
// MARK: Configure
private extension HotelLayoutManager {
    
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
            sSelf.vc.collectionView.alpha = 1
            sSelf.vc.starView.alpha = 1
            sSelf.vc.hotelNameLabel.alpha = 1
            sSelf.vc.blueButton.alpha = 1
            sSelf.vc.priceLabel.alpha = 1
            sSelf.vc.grayPriceLabel.alpha = 1
            
            sSelf.vc.firstGrayLabel.alpha = 1
            sSelf.vc.secondGrayLabel.alpha = 1
            sSelf.vc.thirdGrayLabel.alpha = 1
            sSelf.vc.fourthGrayLabel.alpha = 1
            sSelf.vc.aboutHotel.alpha = 1
            sSelf.vc.stackView.alpha = 1
            sSelf.vc.hotelDescription.alpha = 1
            sSelf.vc.pageControlView.alpha = 1 
        }
    }
}
