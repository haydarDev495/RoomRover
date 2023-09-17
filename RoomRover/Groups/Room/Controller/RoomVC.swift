//
//  RoomVC.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 12.09.23.
//

import UIKit

class RoomVC: UIViewController {

    // - UI
    @IBOutlet var userInterfaceView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // - Data
    private var roomModel: RoomViewModel?
    var titleName = ""
    
    // - Manager
    private var layout: RoomLayoutManager!
    private var coordinator: CoordinatorManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    @IBAction func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: -
// MARK: Configure
private extension RoomVC {
    
    func configure() {
        configureLayout()
        configureCoordinator( )
        configureData()
        configureTableView()
    }
    
    func configureLayout() {
        layout = RoomLayoutManager(vc: self)
    }
    
    func configureCoordinator() {
        coordinator = CoordinatorManager(viewController: self)
    }
    
    func configureData() {
        titleLabel.text = titleName
        
        if let model = MyLaunchVC.roomModel {
            self.roomModel = model
            layout.showAllView(animate: true)
        } else {
            GetRequests.shared.getRoomData { [weak self] roomModel in
                guard let sSelf = self else { return }
                sSelf.roomModel = roomModel
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                    guard let sSelf = self else { return }
                    sSelf.layout.showAllView(animate: false)
                }
            }
        }
    }

    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: -
// MARK: UITableViewDataSource
extension RoomVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 547
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        roomModel?.rooms.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTVC", for: indexPath) as! RoomTVC
        cell.delegate = self
        if let model = roomModel {
            cell.setupUI(model: model.rooms[indexPath.item])
        }
        return cell
    }
}

extension RoomVC: OpenBookingVCDelegate {
    
    func open() {
        coordinator.showBookingVC()
    }
}
