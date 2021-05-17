//
//  ColorView.swift
//  StefanTest
//
//  Created by Stefan Petkovic on 17. 5. 2021..
//

import Foundation
import UIKit

protocol ColorViewDelegate: AnyObject {
    func colorViewPressed(with color: UIColor)
}

class ColorView: CustomView {

    // MARK: - Outlets

    var viewColor: UIColor! {
        didSet {
            configureView()
        }
    }

    weak var delegate: ColorViewDelegate?

    // MARK: - View Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }

    private func configureView() {
        contentView.backgroundColor = viewColor
    }

    // MARK: - Actions

    @IBAction func colorViewPressed(_ sender: UIButton) {
        delegate?.colorViewPressed(with: viewColor)
    }
}
