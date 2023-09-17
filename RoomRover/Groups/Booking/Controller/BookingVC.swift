//
//  BookingVC.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 14.09.23.
//

import UIKit

class BookingVC: UIViewController {

    // - UI
    @IBOutlet var tableView: UITableView!
    @IBOutlet var choiseRoom: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // - Data
    private var cellHeights: [CGFloat] = [128, 288, 240, 438, 66, 164]
    private var imageButton: [Bool] = [true, false]
    private var type = CellType.allCases
    private var putToIndex = 4
    var model: BookingModel?
    private var mainValue = false
    private var myIndex = 3

    // - Manager
    private var layout: BookingLayout!
    private var coordinator: CoordinatorManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func closeButtAct() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func priceButtonAction() {
        if mainValue {
            coordinator.showPayedVC()
        } else {
            if let cell = tableView.cellForRow(at: IndexPath(row: myIndex, section: 0)) as? BookingTVCFour {
                cell.checkView()
            }
        }
    }
}

// MARK: -
// MARK: Configure
private extension BookingVC {
    
    func configure() {
        configureData()
        configureLayout()
        configureCoordinator()
        configureTableView()
        getData()
    }
    
    func configureData() {
        type.insert(.four, at: putToIndex)
        cellHeights.insert(66, at: putToIndex)
        putToIndex += 1
    }
    
    func configureLayout() {
        layout = BookingLayout(vc: self)
    }
    
    func configureCoordinator() {
        coordinator = CoordinatorManager(viewController: self)
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func getData() {
        if let model = MyLaunchVC.bookingModel {
            self.model = model
            layout.setupUI(model: model, animate: true)
        } else {
            GetRequests.shared.getBookingData { [weak self] bookingModel in
                guard let sSelf = self else { return }
                sSelf.model = bookingModel
                if let model = bookingModel {
                    sSelf.layout.setupUI(model: model, animate: false)
                }
            }
        }
    }
}

// - MARK: -
// - MARK: Delegagte TableView
extension BookingVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return type.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch type[indexPath.row] {
        case .one:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTVCOne", for: indexPath) as! BookingTVCOne
            if let model = model {
                cell.setupUI(model: model)
            }
            return cell
        case .two:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTVCTwo", for: indexPath) as! BookingTVCTwo
            if let model = model {
                cell.setupUI(model: model)
            }
            return cell
        case .three:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTVCThree", for: indexPath) as! BookingTVCThree
            return cell
        case .four:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTVCFour", for: indexPath) as! BookingTVCFour
            cell.delegate = self
            cell.payedDelegate = self
            cell.index = indexPath.row
            cell.sss(text: indexPath.row - 3, value: imageButton[indexPath.row - 3])
            return cell
        case .five:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTVCFive", for: indexPath) as! BookingTVCFive
            cell.delegate = self
            return cell
        case .six:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTVCSix", for: indexPath) as! BookingTVCSix
            if let model = model {
                cell.setupUI(model: model)
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
}

extension BookingVC: BookingTVCFiveDelegate, CellType1Delegate , PayedButtonDelegate{
    func pay(value: Bool, index: Int) {
        self.mainValue = value
    }
    
    func didTapButton(in cell: BookingTVCFour) {
        if let indexPath = tableView.indexPath(for: cell) {
            let currentHeight = cellHeights[indexPath.row]
            let newHeight: CGFloat = (currentHeight == 66) ? 438 : 66
            imageButton[indexPath.row - 3] = currentHeight == 66
            cellHeights[indexPath.row] = newHeight
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    func addView(index: Int) {
        type.insert(.four, at: putToIndex)
        cellHeights.insert(438, at: putToIndex)
        imageButton.append(true)
        putToIndex += 1
        tableView.reloadData()
    }
}

enum CellType: String, CaseIterable {
    case one = "BookingTVCOne"
    case two = "BookingTVCTwo"
    case three = "BookingTVCThree"
    case four = "BookingTVCFour"
    case five = "BookingTVCFive"
    case six = "BookingTVCSix"
}
