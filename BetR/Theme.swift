//
//  Theme.swift
//  Pet Finder
//
//  Created by Jechol Lee on 6/13/16.
//  Copyright © 2016 Ray Wenderlich. All rights reserved.
//

import UIKit

let SelectedThemeKey = "SelectedTheme"

enum Theme: Int {
    case normal, dark, graphical
    
    var mainColor: UIColor {
        switch self {
        case .normal:
            return UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 95.0/255.0, alpha: 1.0)
        case .dark:
            return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        case .graphical:
            return UIColor(red: 10.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 1.0)
        }
        
    }
    
    var barStyle: UIBarStyle {
        switch self {
        case .normal, .graphical:
            return .default
        case .dark:
            return .black
        }
    }
    
    
    var backgroundColor: UIColor {
        switch self {
        case .normal, .graphical:
            return UIColor(white: 0.9, alpha: 1.0)
        case .dark:
            return UIColor(white: 0.8, alpha: 1.0)
        }
    }
    
    var secondaryColor: UIColor {
        switch self {
        case .normal:
            return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        case .dark:
            return UIColor(red: 34.0/255.0, green: 128.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        case .graphical:
            return UIColor(red: 140.0/255.0, green: 50.0/255.0, blue: 48.0/255.0, alpha: 1.0)
        }
    }
}

struct ThemeManager {
    
    static func currentTheme() -> Theme {
        UserDefaults.standard.value(forKeyPath: SelectedThemeKey)
        if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey) as AnyObject).integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .normal
        }
    }
    
    static func applyTheme(theme: Theme) {
        // 1
        //    UserDefaults.standard.setValue(theme.rawValue, forKey: SelectedThemeKey)
        UserDefaults.standard.set(theme.rawValue, forKey: SelectedThemeKey)
        UserDefaults.standard.synchronize()
        
        // 2
        let sharedApplication = UIApplication.shared
        //sharedApplication.delegate?.window??.tintColor = UIColor.gray
        UINavigationBar.appearance().barStyle = UIBarStyle.blackTranslucent
        UINavigationBar.appearance().tintColor = UIColor(red: 115, green: 224, blue: 179)

    }
}
