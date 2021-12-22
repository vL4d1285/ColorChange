//
//  ViewController.swift
//  ColorChange
//
//  Created by Vlad Ryabtsev on 21.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    private var currentColor: CIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColor()
        
        colorView.layer.borderWidth = 0.3
        colorView.layer.borderColor = UIColor.gray.cgColor
        
        setValue(for: redLabel, greenLabel, blueLabel)
    }
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        setColor()
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
        case greenSlider :
            greenLabel.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
        }
    }
        
    private func setColor () {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = string(from: redSlider)
            case greenLabel:
                greenLabel.text = string(from: greenSlider)
            default:
                blueLabel.text = string(from: blueSlider)
            }
        }
    }
    
    private func string (from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

