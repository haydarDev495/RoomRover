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

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: -
// MARK: Configure
private extension MyLaunchVC {
    
    func configure() {
        getReq()
        self.configureNavigationConroller()
    }
    
    func getReq() {
        guard let url = URL(string: "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3") else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let decode = JSONDecoder()
                decode.keyDecodingStrategy = .convertFromSnakeCase
                MyLaunchVC.mainModel = try decode.decode(HotelData.self, from: data)
            } catch let error {
                debugPrint(error.localizedDescription)
            }

        }.resume()
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
