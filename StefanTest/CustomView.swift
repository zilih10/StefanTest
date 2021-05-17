//
//  CustomView.swift
//  StefanTest
//
//  Created by Stefan Petkovic on 17. 5. 2021..
//

import Foundation
import UIKit

class CustomView: UIView {

    // MARK: - Outlets

    @IBOutlet var contentView: UIView!

    // MARK: - View Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNIB()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNIB()
    }

    private func loadNIB() {
        Bundle.main.loadNibNamed("\(type(of: self))", owner: self, options: nil)
        self.addConstraints(withView: self.contentView)

        self.sendSubviewToBack(self.contentView)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
