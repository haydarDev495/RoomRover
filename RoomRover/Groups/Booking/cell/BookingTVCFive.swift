//
//  BookingTVCFive.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 17.09.23.
//

import UIKit


class BookingTVCFive: UITableViewCell {

    // - UI
    @IBOutlet var addTouristButt: UIButton!
    
    // - delegate
    weak var delegate: BookingTVCFiveDelegate?
    
    @IBAction func addTouristViewButAct(_ sender: UIButton) {
        delegate?.addView(index: sender.tag)
    }
}

protocol BookingTVCFiveDelegate: AnyObject {
    func addView(index: Int)
}
