//
//  CoordinatorManager.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 12.09.23.
//

import UIKit

class CoordinatorManager {
    
    private unowned var viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showRoomVC(name: String) {
        let vc = UIStoryboard(name: "Room", bundle: nil).instantiateInitialViewController() as! RoomVC
        vc.titleName = name
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showPayedVC() {
        let vc = UIStoryboard(name: "Payed", bundle: nil).instantiateInitialViewController() as! PayedVC
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func showBookingVC() {
        let vc = UIStoryboard(name: "Booking", bundle: nil).instantiateInitialViewController() as! BookingVC
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
