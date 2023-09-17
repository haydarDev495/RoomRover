//
//  RoomLayoutManager.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 14.09.23.
//

import UIKit

class RoomLayoutManager {
    private var vc: RoomVC
    
    init(vc: RoomVC) {
        self.vc = vc
        configure()
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
            sSelf.vc.userInterfaceView.alpha = 1
        }
        
        vc.tableView.reloadData()
    }
}

// MARK: -
// MARK: Configure
private extension RoomLayoutManager {
    
    func configure() {
        
    }
}
