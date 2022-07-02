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
    static func colorMain() -> UIColor {
        return .white
    }
    static func colorAux() -> UIColor {
        return .lightGray
    }
    static func colorThird() -> UIColor {
        return .black
    }
    static func navBarColor() -> UIColor {
        return UIColor(red: 67/255, green: 73/255, blue: 85/255, alpha: 1.0)
    }
}
