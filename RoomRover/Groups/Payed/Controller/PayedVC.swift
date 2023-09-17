//
//  PayedVC.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 13.09.23.
//

import UIKit

class PayedVC: UIViewController {

    // - UI 
    @IBOutlet var successOrderLabel: UILabel!
    
    // - Data
    private var random = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    @IBAction func closeButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func superButtonAction() {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: -
// MARK: Configure
private extension PayedVC {
    
    func configure() {
        configureText()
    }
    
    func configureText() {

        successOrderLabel.text = "Подтверждение заказа №\(Int.random(in: 00000..<99999)) может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление."
    }
}
