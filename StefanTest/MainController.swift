//
//  MainController.swift
//  StefanTest
//
//  Created by Stefan Petkovic on 17. 5. 2021..
//

import UIKit

class MainController: UIViewController {

    enum ChangeColorMode: Int {
        case backgroundColorMode = 0
        case titleColorMode
    }

    enum Constants {
        static let JSONColorsURL: String = "https://d2t41j3b4bctaz.cloudfront.net/interview.json"
    }

    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var changeTitleColorButton: UIButton!
    @IBOutlet weak var changeBackgroundColorButton: UIButton!

    // MARK: - Variables

    var changeColorMode: ChangeColorMode!

    var titleColor: UIColor! = .red { didSet { titleLabel.textColor = titleColor }}
    var backgroundColor: UIColor! = .blue { didSet { self.view.backgroundColor = backgroundColor }}

    var mainDataStruct: MainDataStruct!

    // MARK: - Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        collectData()
    }

    func collectData() {
        guard let url = URL(string: Constants.JSONColorsURL) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            self?.mainDataStruct = MainDataStruct.deserialize(from: data)

            DispatchQueue.main.async { [weak self] in
                self?.titleColor = self?.mainDataStruct.getRandomTitleColor()
                self?.backgroundColor = self?.mainDataStruct.getRandomBackgroundColor()
            }

        }

        task.resume()
    }

    private func presentColorSwitch() {
        let colorSwitchVC = ColorSwitchController.instantiate(withVCType: ColorSwitchController.self)
        colorSwitchVC.modalPresentationStyle = .overFullScreen
        colorSwitchVC.colorsArray = changeColorMode == .backgroundColorMode ? mainDataStruct.colors.backgroundColors : mainDataStruct.colors.titleColors
        colorSwitchVC.delegate = self
        colorSwitchVC.disabledColor = changeColorMode == .backgroundColorMode ? titleColor : backgroundColor
        
        present(colorSwitchVC, animated: true, completion: nil)
    }

    private func configure(for mode: ChangeColorMode, with color: UIColor) {
        if mode == .backgroundColorMode {
            backgroundColor = color
        } else {
            titleColor = color
        }
    }

    // MARK: Actions

    @IBAction func buttonPressed(_ sender: UIButton) {
        changeColorMode = sender == changeTitleColorButton ? .titleColorMode : .backgroundColorMode

        presentColorSwitch()
    }
}

extension MainController: ColorSwitchDelegate {
    func didSelectColor(color: UIColor) {
        configure(for: changeColorMode, with: color)
    }
}
