//
//  MainViewController.swift
//  ColorChange
//
//  Created by Vlad Ryabtsev on 28.12.2021.
//

import UIKit
 
protocol SettingsViewControllerDelegate {
    func setBackgroundColor (_ color: UIColor)
}

class MainViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.currentColor = view.backgroundColor
        settingsVC.delegate = self
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
