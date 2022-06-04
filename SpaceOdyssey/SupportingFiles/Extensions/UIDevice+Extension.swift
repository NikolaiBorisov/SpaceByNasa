//
//  UIDevice+Extension.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 12.12.2021.
//

import Foundation

import UIKit

extension UIDevice {
    static var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

extension UIDevice {
    static var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    public enum ScreenType: String {
        case iPhone8
        case iPhone8Plus
        case iPhoneX
        case iPhoneXSMax
        case iPhone11
        case iPhone11Pro
        case iPhoneSE
        case iPhone12
        case iPhone12Pro
        case iPhone12Mini
        case unknown
    }
    
    static var screenType: ScreenType {
        guard iPhone else { return .unknown }
        
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return .iPhoneSE
        case 1334:
            return .iPhone8
        case 2208:
            return .iPhone8Plus
        case 2436:
            return .iPhoneX
        case 2521:
            return .iPhone12
        case 2532:
            return .iPhone11Pro
        case 2688:
            return .iPhoneXSMax
        case 2778:
            return .iPhone12Pro
        case 1792:
            return .iPhone11
        default:
            return .unknown
        }
    }
    
    static var isSmallDevice: Bool {
        switch UIDevice.screenType {
        case .iPhone8, .iPhone8Plus, .iPhoneSE:
            return true
        default:
            return false
        }
    }
    
}
