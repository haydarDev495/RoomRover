//
//  HotelCVC.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 12.09.23.
//

import UIKit
import Kingfisher

class HotelCVC: UICollectionViewCell {
    
    // - UI
    @IBOutlet var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func setupImage(data: String) {
        guard let url = URL(string: data) else { return }
        image.kf.indicatorType = .activity
        image.kf.indicator?.startAnimatingView()
        image.kf.indicator?.view.tintColor = .white
        image.kf.setImage(with: url) { [weak self] (success) in
            guard let sSelf = self else { return }
            switch success {
            case .success(_):
                sSelf.image.kf.indicator?.stopAnimatingView()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}

// MARK: -
// MARK: Configure
private extension HotelCVC {
    func configure() {
        image.layer.cornerRadius = 15
    }
}
