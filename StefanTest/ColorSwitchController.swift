//
//  ColorSwitchController.swift
//  StefanTest
//
//  Created by Stefan Petkovic on 17. 5. 2021..
//

import Foundation
import UIKit

protocol ColorSwitchDelegate: AnyObject {
    func didSelectColor(color: UIColor)
}

class ColorSwitchController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var colorsStackView: UIStackView!

    // MARK: - Variables

    var disabledColor: UIColor!
    var colorsArray: [UIColor]!

    weak var delegate: ColorSwitchDelegate?

    // MARK: - Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        for color in colorsArray {
            let colorView = ColorView()
            colorView.viewColor = color
            colorView.delegate = self

            color == disabledColor ? colorView.disableViewComponent() : colorView.enableViewComponent()
            colorsStackView.addArrangedSubview(colorView)
        }
    }
}

extension ColorSwitchController: ColorViewDelegate {
    func colorViewPressed(with color: UIColor) {
        delegate?.didSelectColor(color: color)
        self.dismiss(animated: true, completion: nil)
    }
}
