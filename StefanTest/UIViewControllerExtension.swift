//
//  UIViewControllerExtension.swift
//  StefanTest
//
//  Created by Stefan Petkovic on 17. 5. 2021..
//

import Foundation
import UIKit

extension UIViewController {
    @objc class var storyboardID : String {
    let vcName = "\(self)"
    return vcName
    }

    static func instantiate<T : UIViewController>(withVCType vcType : T.Type) -> T {
    let vc = self.createStoryboard().instantiateViewController(withIdentifier: self.storyboardID) as! T
    return vc
    }

    @objc static func createStoryboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardID, bundle: Bundle.main)
    }
}
