//
//  BookingTVCThree.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 17.09.23.
//

import UIKit

class BookingTVCThree: UITableViewCell {

    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var emailView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    @IBAction func numberAction(_ sender: UITextField) {
        sender.text = "+7 (***) ***-**-**"
    }
}

// MARK: -
// MARK: Configure
private extension BookingTVCThree {
    func configure() {
        configureTextFiled()
    }
    
    func configureTextFiled() {
        numberTextField.delegate = self
        emailTextField.delegate = self
        
        numberTextField.keyboardType = .phonePad
        emailTextField.keyboardType = .emailAddress
    }
}

extension BookingTVCThree: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {[weak self] in
            guard let sSelf = self else { return }
            if textField == sSelf.emailTextField {
                if let text = textField.text {
                    if sSelf.isValidEmail(email: text) {
                        sSelf.emailView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1.00)
                    } else {
                        sSelf.emailView.backgroundColor = UIColor(red: 0.92, green: 0.34, blue: 0.34, alpha: 0.15)
                    }
                }
            }
            sSelf.updateConstraints()
            sSelf.layoutIfNeeded()
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        if textField == numberTextField {
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            numberTextField.text = "\(formatter(mask: "+* (***) *** ** **", phoneNumber: newString))"
            return false
        } else {
            emailTextField.text = text
            return true
        }
    }
    
    func formatter(mask: String, phoneNumber: String) -> String {
        let number = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var numberIndex = number.startIndex

        for character in mask {
            if character == "*" {
                if numberIndex < number.endIndex {
                    result.append(number[numberIndex])
                    numberIndex = number.index(after: numberIndex)
                } else {
                    result.append("*")
                }
            } else if character.isNumber {
                if numberIndex < number.endIndex {
                    result.append(number[numberIndex])
                    numberIndex = number.index(after: numberIndex)
                }
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
