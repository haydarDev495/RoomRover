//
//  BookingTVCFour.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 17.09.23.
//

import UIKit


class BookingTVCFour: UITableViewCell {

    // - UI
    @IBOutlet var label: UILabel!
    @IBOutlet var showHideButton: UIButton!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var birthdayTextField: UITextField!
    @IBOutlet var countryTextField: UITextField!
    @IBOutlet var passNumberTextField: UITextField!
    @IBOutlet var passportEndTextField: UITextField!
    
    @IBOutlet var pasEndView: UIView!
    @IBOutlet var pasNumView: UIView!
    @IBOutlet var countryView: UIView!
    @IBOutlet var dateView: UIView!
    @IBOutlet var lastNameView: UIView!
    @IBOutlet var nameView: UIView!
    
    // - Data
    private var name = false
    private var last = false
    private var birthday = false
    private var country = false
    private var passportNumber = false
    private var passportEnd = false
    private var mainValue = false
    
    var index = 0
    
    // - delegate
    weak var delegate: CellType1Delegate?
    weak var payedDelegate: PayedButtonDelegate?
    
    private let grayColor = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1.00)
    private let redColor = UIColor(red: 0.92, green: 0.34, blue: 0.34, alpha: 0.15)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    @IBAction func showHideButtonAction(_ sender: UIButton) {
        delegate?.didTapButton(in: self)
    }
    
    func sss(text: Int, value: Bool) {
        let number = numberToWords(text)
        label.text = "\(number) турист"
        showHideButton.setImage(UIImage(named: value ? "arrowUp" : "arrowDown"), for: .normal)
    }
    
    func checkView() {
        nameView.backgroundColor = name ? grayColor : redColor
        lastNameView.backgroundColor = last ? grayColor : redColor
        dateView.backgroundColor = country ? grayColor : redColor
        countryView.backgroundColor = birthday ? grayColor : redColor
        pasNumView.backgroundColor = passportNumber ? grayColor : redColor
        pasEndView.backgroundColor = passportEnd ? grayColor : redColor
    }
}

// MARK: -
// MARK: Configure
private extension BookingTVCFour {
    
    func configure() {
        configureTextFiled()
    }
    
    func configureTextFiled() {
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        birthdayTextField.delegate = self
        countryTextField.delegate = self
        passNumberTextField.delegate = self
        passportEndTextField.delegate = self
    }
    
    func numberToWords(_ number: Int) -> String {
        if number == 0 {
            return "Первый"
        } else if number == 1 {
            return "Второй"
        } else if number == 2 {
            return "Третий"
        } else if number == 3 {
            return "Четвертый"
        } else if number == 4 {
            return "Пятый"
        } else if number == 5 {
            return "Шестой"
        } else if number == 6 {
            return "Седьмой"
        } else if number == 7 {
            return "Восьмой"
        } else if number == 8 {
            return "Девятый"
        } else if number == 9 {
            return "Десятый"
        }
        return "\(number)"
    }
}


extension BookingTVCFour: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {[weak self] in
            guard let sSelf = self, let text = textField.text else { return }
            if textField.tag == 0 {
                if !text.isEmpty {
                    sSelf.name = true
                } else {
                    sSelf.name = false
                }
            } else if textField.tag == 1 {
                if !text.isEmpty {
                    sSelf.last = true
                } else {
                    sSelf.last = false
                }
            } else if textField.tag == 2 {
                if !text.isEmpty {
                    sSelf.birthday = true
                } else {
                    sSelf.birthday = false
                }
            } else if textField.tag == 3 {
                if !text.isEmpty {
                    sSelf.country = true
                } else {
                    sSelf.country = false
                }
            } else if textField.tag == 4 {
                if !text.isEmpty {
                    sSelf.passportNumber = true
                } else {
                    sSelf.passportNumber = false
                }
            } else if textField.tag == 5 {
                if !text.isEmpty {
                    sSelf.passportEnd = true
                } else {
                    sSelf.passportEnd = false
                }
            }

            if sSelf.name && sSelf.last && sSelf.birthday && sSelf.country && sSelf.passportNumber && sSelf.passportEnd {
                sSelf.mainValue = true
            } else {
                sSelf.mainValue = false
            }
            
            sSelf.payedDelegate?.pay(value: sSelf.mainValue, index: 0)
            sSelf.updateConstraints()
            sSelf.layoutIfNeeded()
        }
    }
}

protocol CellType1Delegate: AnyObject {
    func didTapButton(in cell: BookingTVCFour)
}

struct FourtCellModel {
    var name: String
    var last: String
    var date: String
    var country: String
    var passportNumber: String
    var passportEnd: String
}

protocol PayedButtonDelegate: AnyObject {
    func pay(value: Bool, index: Int)
}
