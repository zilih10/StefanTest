//
//  UIViewExtensions.swift
//  StefanTest
//
//  Created by Stefan Petkovic on 17. 5. 2021..
//

import Foundation
import UIKit

extension UIView {
    @objc var viewName : String {
        return "\(self)"
    }

    @objc func addConstraints(withView tempView : UIView) {
        self.addSubview(tempView)
        tempView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: tempView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: tempView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: tempView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: tempView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0))
    }

    @objc func enableViewComponent() {
        self.alpha = 1.0
        self.isUserInteractionEnabled = true
    }

    @objc func disableViewComponent() {
        self.alpha = 0.25
        self.isUserInteractionEnabled = false
    }
}
