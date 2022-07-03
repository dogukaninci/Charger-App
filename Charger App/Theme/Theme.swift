//
//  Theme.swift
//  Charger App
//
//  Created by Doğukan Inci on 30.06.2022.
//

import UIKit

class Theme {
    static func fontNormal(size: CGFloat) -> UIFont{
        return UIFont.systemFont(ofSize: size)
    }
    static func fontBold(size: CGFloat) -> UIFont{
        return UIFont.boldSystemFont(ofSize: size)
    }
    static func colorWhite() -> UIColor {
        return .white
    }
    static func colorGrayscale() -> UIColor {
        return UIColor(red: 183/255, green: 189/255, blue: 203/255, alpha: 1.0)
    }
    static func colorCharcoalGrey() -> UIColor {
        return UIColor(red: 67/255, green:73/255, blue: 85/255, alpha: 1.0)
    }
    static func darkColor() -> UIColor {
        return UIColor(red: 26/255, green: 30/255, blue: 37/255, alpha: 1.0)
    }
    static func navBarColor() -> UIColor {
        return UIColor(red: 67/255, green: 73/255, blue: 85/255, alpha: 1.0)
    }
    static func colorSecurityOn() -> UIColor {
        return UIColor(red: 255/255, green: 44/255, blue: 85/255, alpha: 1.0)
    }
    static func colorPrimary() -> UIColor {
        return UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1.0)
    }
}
