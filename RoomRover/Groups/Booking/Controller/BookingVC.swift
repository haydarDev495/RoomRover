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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                        guard let sSelf = self else { return }
                        sSelf.layout.setupUI(model: model, animate: false)
                    }
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


/*
 //
 //  BookingVC.swift
 //  RoomRover
 //
 //  Created by Haydar Bekmuradov on 14.09.23.
 //

 import UIKit
 //import libPhoneNumber_iOS

 class BookingVC: UIViewController {

     // - UI
     @IBOutlet var starLabel: UILabel!
     @IBOutlet var hotelNameLabel: UILabel!
     @IBOutlet var scrollView: UIScrollView!
     @IBOutlet var starView: UIView!
     @IBOutlet var choiseRoom: UIButton!
     @IBOutlet var activityIndicator: UIActivityIndicatorView!
     @IBOutlet var blueButtonText: UIButton!
     
     @IBOutlet var emailTextField: UITextField!
     @IBOutlet var cityFrom: UILabel!
     @IBOutlet var countyFor: UILabel!
     @IBOutlet var date: UILabel!
     @IBOutlet var night: UILabel!
     @IBOutlet var hotelName: UILabel!
     @IBOutlet var hotelDescrip: UILabel!
     @IBOutlet var allInClusive: UILabel!
     
     @IBOutlet var allPrice: UILabel!
     @IBOutlet var servicePrice: UILabel!
     @IBOutlet var oilPrice: UILabel!
     @IBOutlet var tourPrice: UILabel!
     @IBOutlet var firstView: UIView!
     @IBOutlet var phoneNumberTextField: UITextField!
     
     @IBOutlet var firstViewButton: UIButton!
     @IBOutlet var secondViewButton: UIButton!
     
     @IBOutlet var infoView: UIView!
     
     @IBOutlet var addTouristView: UIView!
     
     // - Constraint
     @IBOutlet var viewHeightConstraint: NSLayoutConstraint!
     @IBOutlet var firstViewHeightConstraint: NSLayoutConstraint!
     @IBOutlet var secondViewHeightConstraint: NSLayoutConstraint!
     
     // - Data
     var model: BookingModel?
     
     private var firstViewIsHidden = false
     private var secondViewIsHidden = true

     // - Manager
     private var layout: BookingLayout!
     private var coordinator: CoordinatorManager!
     
     // -

     override func viewDidLoad() {
         super.viewDidLoad()
         configure()
     }
     
     @IBAction func closeButtAct() {
         navigationController?.popViewController(animated: true)
     }
     
     @IBAction func priceButtonAction() {
         coordinator.showPayedVC()
     }
     
     @IBAction func addTouristButAct() {
         let view = UIView(frame: CGRect(x: 0, y: Int(addTouristView.frame.origin.y), width: Int(addTouristView.frame.width), height: 430))
         view.backgroundColor = .red
         viewHeightConstraint.constant += 438
         infoView.addSubview(view)
     }
     
     @IBAction func showTouristButAct(_ sender: UIButton) {
         
         if sender.tag == 0 {
             firstViewIsHidden = !firstViewIsHidden
             firstViewHeightConstraint.constant = firstViewIsHidden ? 58 : 430
             firstViewButton.setImage(UIImage(named: firstViewIsHidden ? "arrowDown" : "arrowUp"), for: .normal)
             if firstViewIsHidden {
                 viewHeightConstraint.constant -= 372
             } else {
                 viewHeightConstraint.constant += 372
             }

         } else if sender.tag == 1 {
             secondViewIsHidden = !secondViewIsHidden
             secondViewHeightConstraint.constant = secondViewIsHidden ? 58 : 430
             secondViewButton.setImage(UIImage(named: secondViewIsHidden ? "arrowDown" : "arrowUp"), for: .normal)

             if secondViewIsHidden {
                 viewHeightConstraint.constant -= 372
             } else {
                 viewHeightConstraint.constant += 372
             }
         }
         
         UIView.animate(withDuration: 0.33) {
             self.view.layoutIfNeeded()
         }

     }
 }

 // MARK: -
 // MARK: Configure
 private extension BookingVC {
     
     func configure() {
         configureLayout()
         configureCoordinator()
         configureTextFiled()
         getData()
     }
     
     func configureLayout() {
         layout = BookingLayout(vc: self)
     }
     
     func configureCoordinator() {
         coordinator = CoordinatorManager(viewController: self)
     }
     
     func configureTextFiled() {
         phoneNumberTextField.delegate = self
         emailTextField.delegate = self
         phoneNumberTextField.keyboardType = .numberPad
         phoneNumberTextField.placeholder = "+7 (___) ___-__-__"
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

 extension BookingVC: UITextFieldDelegate {
     
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
         return false
     }

     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
     }

     func textFieldDidEndEditing(_ textField: UITextField) {
         UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {[weak self] in
             guard let sSelf = self else { return }
             
             if textField == sSelf.emailTextField {
                 if let text = textField.text {
                     if sSelf.isValidEmail(email: text) {
                         print("Адрес электронной почты действителен. \(text)")
                     } else {
                         print("Адрес электронной почты недействителен. \(text)")
                     }
                 }
             }
             sSelf.view.updateConstraints()
             sSelf.view.layoutIfNeeded()
         }
     }
     
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         guard let text = textField.text else { return false }
         if textField == phoneNumberTextField {
             let newString = (text as NSString).replacingCharacters(in: range, with: string)
             phoneNumberTextField.text = formatter(mask: "+X (XXX) XXX XX XX", phoneNumber: newString)
             return false
         } else {
             emailTextField.text = text
             return true
         }
     }
     
     func formatter (mask: String, phoneNumber: String) -> String {
         let number = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
         var result:String = ""
         var index = number.startIndex
         
         for character in mask where index < number.endIndex {
             if character == "X" {
                 result.append(number [index])
                 index = number.index(after: index)
             } else {
                 result.append(character)
             }
         }
         return result
     }
     
     func isValidEmail(email: String) -> Bool {
         let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
         let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
         return emailPredicate.evaluate(with: email)
     }
 }

 */

/*
 
 // - Views
 private let scrollView = UIScrollView()
 private let contentView = UIView()
 private let aboutHotelView = UIView()
 private let infoView = UIView()
 private let aboutBuyerView = UIView()
 private let firstTouristView = UIView()
 private let secondTouristView = UIView()
 private let addTouristView = UIView()
 private let priceView = UIView()
 
 // - Buttons
 private let addtouristButton = UIButton()
 
 private let stackView = UIStackView()
 
 func configureScrollView() {
     scrollView.translatesAutoresizingMaskIntoConstraints = false
     scrollView.showsVerticalScrollIndicator = true
     scrollView.alwaysBounceVertical = true
     scrollView.backgroundColor = .blue
 }
 
 func configureContentView() {
     contentView.translatesAutoresizingMaskIntoConstraints = false
     contentView.backgroundColor = .green
 }
 
 func prepareScrollView() {
     view.addSubview(scrollView)
     scrollView.addSubview(contentView)
     
     NSLayoutConstraint.activate([
         scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 65),
         scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
         
         contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
         contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
         contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
         contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
         contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
     ])
 }
 
 func configureTestView() {
     aboutHotelView.backgroundColor = .gray
     aboutHotelView.translatesAutoresizingMaskIntoConstraints = false

     infoView.backgroundColor = .orange
     infoView.translatesAutoresizingMaskIntoConstraints = false
     
     aboutBuyerView.backgroundColor = .black
     aboutBuyerView.translatesAutoresizingMaskIntoConstraints = false
     
     firstTouristView.backgroundColor = .brown
     firstTouristView.translatesAutoresizingMaskIntoConstraints = false
     
     secondTouristView.backgroundColor = .red
     secondTouristView.translatesAutoresizingMaskIntoConstraints = false
     
     addTouristView.backgroundColor = .yellow
     addTouristView.translatesAutoresizingMaskIntoConstraints = false

     priceView.backgroundColor = .orange
     priceView.translatesAutoresizingMaskIntoConstraints = false
     
     // - Stack
     stackView.axis = .vertical
     stackView.backgroundColor = .red
     stackView.alignment = .fill
     stackView.distribution = .fillEqually
     stackView.spacing = 8
     stackView.translatesAutoresizingMaskIntoConstraints = false
 }
 
 func addContentToScrollView() {
     
     contentView.addSubview(aboutHotelView)
     contentView.addSubview(infoView)
     contentView.addSubview(aboutBuyerView)
     contentView.addSubview(firstTouristView)
     contentView.addSubview(secondTouristView)
     contentView.addSubview(stackView)
     contentView.addSubview(addTouristView)
     contentView.addSubview(priceView)
     
     NSLayoutConstraint.activate([
         aboutHotelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
         aboutHotelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
         aboutHotelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
         aboutHotelView.heightAnchor.constraint(equalToConstant: 120),
         
         infoView.topAnchor.constraint(equalTo: aboutHotelView.bottomAnchor, constant: 8),
         infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
         infoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
         infoView.heightAnchor.constraint(equalToConstant: 280),
         
         aboutBuyerView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 8),
         aboutBuyerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
         aboutBuyerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
         aboutBuyerView.heightAnchor.constraint(equalToConstant: 232),
         
         firstTouristView.topAnchor.constraint(equalTo: aboutBuyerView.bottomAnchor, constant: 8),
         firstTouristView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
         firstTouristView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
         firstTouristView.heightAnchor.constraint(equalToConstant: 430),
         
         secondTouristView.topAnchor.constraint(equalTo: firstTouristView.bottomAnchor, constant: 8),
         secondTouristView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
         secondTouristView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
         secondTouristView.heightAnchor.constraint(equalToConstant: 58),
         
         stackView.topAnchor.constraint(equalTo: secondTouristView.bottomAnchor, constant: 8),
         stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
         stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),

         addTouristView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
         addTouristView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
         addTouristView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
         addTouristView.heightAnchor.constraint(equalToConstant: 58),
         
         priceView.topAnchor.constraint(equalTo: addTouristView.bottomAnchor, constant: 8),
         priceView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
         priceView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
         priceView.heightAnchor.constraint(equalToConstant: 156),
         priceView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
     ])
 }
 
 func addContentToaddtouristView() {
     addtouristButton.backgroundColor = UIColor(red: 0.051, green: 0.447, blue: 1, alpha: 1)
     addtouristButton.setImage(UIImage(named: "add"), for: .normal)
     addtouristButton.translatesAutoresizingMaskIntoConstraints = false
     addtouristButton.layer.cornerRadius = 6
     addtouristButton.addTarget(self, action: #selector(addtouristButAct), for: .touchUpInside)
     addTouristView.addSubview(addtouristButton)
     
     NSLayoutConstraint.activate([
         addtouristButton.centerYAnchor.constraint(equalTo: addTouristView.centerYAnchor),
         addtouristButton.trailingAnchor.constraint(equalTo: addTouristView.trailingAnchor, constant: -16),
         addtouristButton.heightAnchor.constraint(equalToConstant: 32),
         addtouristButton.widthAnchor.constraint(equalToConstant: 32),
     ])
 }

 @objc func addtouristButAct() {
     
     let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
     button.tag = stackView.arrangedSubviews.count
     button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
     button.backgroundColor = .red
     
     let view = MyClass()
     view.backgroundColor = .gray
     view.addSubview(button)
     stackView.addArrangedSubview(view)
     
     view.heightAnchor.constraint(equalToConstant: 430).isActive = true
     view.widthAnchor.constraint(equalToConstant: 375).isActive = true
 }
 
 @objc func buttonTapped(_ sender: UIButton) {
     // Обработка нажатия на кнопку
     print("Нажата кнопка с идентификатором \(sender.tag)")
     
     if sender.tag == 0 {
         
     }
 }
 */

/*
 // - Views
 private let scrollView = UIScrollView()
 private let contentView = UIView()
 private let aboutHotelView = UIView()
 private let infoView = UIView()
 private let aboutBuyerView = UIView()
 private let firstTouristView = UIView()
 private let secondTouristView = UIView()
 private let addTouristView = UIView()
 private let priceView = UIView()
 
 // - Buttons
 private let addtouristButton = UIButton()
 private let stackView = UIStackView()
 
 // - Data
 private var heightConstraints = [NSLayoutConstraint]()
 
 func configureScrollView() {
     scrollView.translatesAutoresizingMaskIntoConstraints = false
     scrollView.showsVerticalScrollIndicator = true
     scrollView.alwaysBounceVertical = true
     scrollView.backgroundColor = .blue
 }
 
 func configureContentView() {
     contentView.translatesAutoresizingMaskIntoConstraints = false
     contentView.backgroundColor = .green
 }
 
 func prepareScrollView() {
     view.addSubview(scrollView)
     scrollView.addSubview(contentView)
     
     NSLayoutConstraint.activate([
         scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 65),
         scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
         
         contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
         contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
         contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
         contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
         contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
     ])
 }
 
 func configureTestView() {
     aboutHotelView.backgroundColor = .gray
     aboutHotelView.translatesAutoresizingMaskIntoConstraints = false

     infoView.backgroundColor = .orange
     infoView.translatesAutoresizingMaskIntoConstraints = false
     
     aboutBuyerView.backgroundColor = .black
     aboutBuyerView.translatesAutoresizingMaskIntoConstraints = false
     
     firstTouristView.backgroundColor = .brown
     firstTouristView.translatesAutoresizingMaskIntoConstraints = false
     
     secondTouristView.backgroundColor = .red
     secondTouristView.translatesAutoresizingMaskIntoConstraints = false
     
     addTouristView.backgroundColor = .yellow
     addTouristView.translatesAutoresizingMaskIntoConstraints = false

     priceView.backgroundColor = .orange
     priceView.translatesAutoresizingMaskIntoConstraints = false
     
     // - Stack
     stackView.axis = .vertical
     stackView.backgroundColor = .red
     stackView.alignment = .fill
     stackView.distribution = .fillEqually
     stackView.spacing = 8
     stackView.translatesAutoresizingMaskIntoConstraints = false
 }
 
 func addContentToScrollView() {
     
     contentView.addSubview(aboutHotelView)
     contentView.addSubview(infoView)
     contentView.addSubview(aboutBuyerView)
     contentView.addSubview(firstTouristView)
     contentView.addSubview(secondTouristView)
     contentView.addSubview(stackView)
     contentView.addSubview(addTouristView)
     contentView.addSubview(priceView)
     
     NSLayoutConstraint.activate([
         aboutHotelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
         aboutHotelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
         aboutHotelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
         aboutHotelView.heightAnchor.constraint(equalToConstant: 120),
         
         infoView.topAnchor.constraint(equalTo: aboutHotelView.bottomAnchor, constant: 8),
         infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
         infoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
         infoView.heightAnchor.constraint(equalToConstant: 280),
         
         aboutBuyerView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 8),
         aboutBuyerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
         aboutBuyerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
         aboutBuyerView.heightAnchor.constraint(equalToConstant: 232),
         
         firstTouristView.topAnchor.constraint(equalTo: aboutBuyerView.bottomAnchor, constant: 8),
         firstTouristView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
         firstTouristView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
         firstTouristView.heightAnchor.constraint(equalToConstant: 430),
         
         secondTouristView.topAnchor.constraint(equalTo: firstTouristView.bottomAnchor, constant: 8),
         secondTouristView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
         secondTouristView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
         secondTouristView.heightAnchor.constraint(equalToConstant: 58),
         
         stackView.topAnchor.constraint(equalTo: secondTouristView.bottomAnchor, constant: 8),
         stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
         stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),

         addTouristView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
         addTouristView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
         addTouristView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
         addTouristView.heightAnchor.constraint(equalToConstant: 58),
         
         priceView.topAnchor.constraint(equalTo: addTouristView.bottomAnchor, constant: 8),
         priceView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
         priceView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
         priceView.heightAnchor.constraint(equalToConstant: 156),
         priceView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
     ])
 }
 
 func addContentToaddtouristView() {
     addtouristButton.backgroundColor = UIColor(red: 0.051, green: 0.447, blue: 1, alpha: 1)
     addtouristButton.setImage(UIImage(named: "add"), for: .normal)
     addtouristButton.translatesAutoresizingMaskIntoConstraints = false
     addtouristButton.layer.cornerRadius = 6
     addtouristButton.addTarget(self, action: #selector(addtouristButAct), for: .touchUpInside)
     addTouristView.addSubview(addtouristButton)
     
     NSLayoutConstraint.activate([
         addtouristButton.centerYAnchor.constraint(equalTo: addTouristView.centerYAnchor),
         addtouristButton.trailingAnchor.constraint(equalTo: addTouristView.trailingAnchor, constant: -16),
         addtouristButton.heightAnchor.constraint(equalToConstant: 32),
         addtouristButton.widthAnchor.constraint(equalToConstant: 32),
     ])
 }

 @objc func addtouristButAct() {
     
     let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
     button.tag = stackView.arrangedSubviews.count
     button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
     button.backgroundColor = .red
     
     let view = UIView()
     view.backgroundColor = .gray
     view.addSubview(button)
     stackView.addArrangedSubview(view)
     
     let heightConstraint = view.heightAnchor.constraint(equalToConstant: 430)
     heightConstraint.isActive = true
     heightConstraints.append(heightConstraint) // Добавляем ограничение в массив
     view.widthAnchor.constraint(equalToConstant: 375).isActive = true
 }
 
 @objc func buttonTapped(_ sender: UIButton) {
     // Обработка нажатия на кнопку
     print("Нажата кнопка с идентификатором \(sender.tag)")
     
     if sender.tag < heightConstraints.count {
         let heightConstraint = heightConstraints[sender.tag]
         
         if heightConstraint.constant == 58 {
             heightConstraint.constant = 420
         } else {
             heightConstraint.constant = 58
         }
         
         // Анимируйте изменение высоты (при необходимости)
         UIView.animate(withDuration: 0.3) {
             self.view.layoutIfNeeded()
         }
     }
 }
 */
