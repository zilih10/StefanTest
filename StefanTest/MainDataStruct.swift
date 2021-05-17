//
//  MainDataStruct.swift
//  StefanTest
//
//  Created by Stefan Petkovic on 18. 5. 2021..
//

import Foundation
import UIKit

struct MainDataStruct {
    enum Constants {
        static let titleLabelKey: String = "title"
        static let colorsKey: String = "colors"
        static let backgroundColorsKey: String = "background_colors"
        static let titleColorsKey: String = "text_colors"
    }
    
    var title: String
    var colors: (backgroundColors: [UIColor], titleColors: [UIColor])

    init() {
        self.title = ""
        self.colors = (backgroundColors: [], titleColors: [])
    }

    static func deserialize(from data: Data) -> MainDataStruct {
        var objc = self.init()

        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        if let mainDataJson = json as? [String: Any] {

            if let title = mainDataJson[Constants.titleLabelKey] as? String {
                objc.title = title
            }

            if let colors = mainDataJson[Constants.colorsKey] as? [String: Any] {
                var titleColors: [UIColor] = []
                var backgroundColors: [UIColor] = []

                if let backgroundColorsString = colors[Constants.backgroundColorsKey] as? [String] {
                    for colorCode in backgroundColorsString {
                        backgroundColors.append(UIColor(hex: colorCode))
                    }
                }

                if let titleColorsStrings = colors[Constants.titleColorsKey] as? [String] {
                    for colorCode in titleColorsStrings {
                        titleColors.append(UIColor(hex: colorCode))
                    }
                }

                objc.colors = (backgroundColors: backgroundColors, titleColors: titleColors)
            }
        }

        return objc
    }

    func getRandomTitleColor() -> UIColor {
        return colors.titleColors.randomElement()!
    }

    func getRandomBackgroundColor() -> UIColor {
        return colors.backgroundColors.randomElement()!
    }
}
