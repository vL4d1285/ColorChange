//
//  ViewController.swift
//  ColorChange
//
//  Created by Vlad Ryabtsev on 21.12.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    // MARK: - Public Properties
    var delegate: SettingsViewControllerDelegate!
    var currentColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.borderWidth = 0.3
        colorView.layer.borderColor = UIColor.gray.cgColor
        colorView.backgroundColor = currentColor
        
        setSliders()
        setLabelsValue(for: redLabel, greenLabel, blueLabel)
        setTextFieldsValue(for: redTextField, greenTextField, blueTextField)
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
    }
    
    // MARK: - IB Actions
    @IBAction func rgbSlider(_ sender: UISlider) {
        
        switch sender {
        case redSlider:
            setLabelsValue(for: redLabel)
            setTextFieldsValue(for: redTextField)
        case greenSlider :
            setLabelsValue(for: greenLabel)
            setTextFieldsValue(for: greenTextField)
        default:
            setLabelsValue(for: blueLabel)
            setTextFieldsValue(for: blueTextField)
        }
        setColor()
    }
    
    @IBAction func doneButtonAction() {
        delegate.setBackgroundColor(colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
}

// MARK: - Private Methods
extension SettingsViewController {
    
    private func setColor () {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    private func setLabelsValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel: label.text = string(from: redSlider)
            case greenLabel: label.text = string(from: greenSlider)
            default: label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setTextFieldsValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField: textField.text = string(from: redSlider)
            case greenTextField: textField.text = string(from: greenSlider)
            default: textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func setSliders() {
        let ciColor = CIColor(color: currentColor)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    private func string (from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, massage: String) {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let floatValue = Float(newValue) else {
            showAlert(
                title: "Wrong format!",
                massage: "The entered value must be in the format 0.00")
            return
        }
        
        if textField == redTextField {
            redSlider.setValue(floatValue, animated: true)
            setLabelsValue(for: redLabel)
        } else if textField == greenTextField {
            greenSlider.setValue(floatValue, animated: true)
            setLabelsValue(for: greenLabel)
        } else {
            greenSlider.setValue(floatValue, animated: true)
            setLabelsValue(for: blueLabel)
        }
        setColor()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
}






