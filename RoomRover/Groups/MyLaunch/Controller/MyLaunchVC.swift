//
//  MyLaunchVC.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 11.09.23.
//

import UIKit

class MyLaunchVC: UIViewController {

    // - Data
    static var mainModel: HotelData?
    static var roomModel: RoomViewModel?
    static var bookingModel: BookingModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: -
// MARK: Configure
private extension MyLaunchVC {
    
    func configure() {
        getHotelData()
        configureNavigationConroller()
    }
    
    func getHotelData() {
        GetRequests.shared.getHotelData { hotelModel in
            MyLaunchVC.mainModel = hotelModel
        }
        
        GetRequests.shared.getRoomData { roomModel in
            MyLaunchVC.roomModel = roomModel
        }
        
//        GetRequests.shared.getBookingData { bookingModel in
//            MyLaunchVC.bookingModel = bookingModel
//        }
    }
    
    func configureNavigationConroller() {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let vc = UIStoryboard(name: "Hotel", bundle: nil).instantiateInitialViewController() as! HotelVC
            let nc = UINavigationController(rootViewController: vc)
            nc.setNavigationBarHidden(true, animated: false)
            appDelegate.window?.rootViewController = nc
            UIView.transition(with: appDelegate.window ?? UIWindow(), duration: 0.5, options: .transitionCrossDissolve) {
                appDelegate.window?.makeKeyAndVisible()
            }
        }
    }
}
