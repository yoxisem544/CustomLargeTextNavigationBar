//
//  DetectDevice.swift
//  LargeTextNavigation
//
//  Created by David on 2018/5/30.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

extension UIDevice {

  static var type: DeviceType {
    if UIDevice().userInterfaceIdiom == .phone {
      switch UIScreen.main.nativeBounds.height {
      case 1136: // iPhone 5 or 5S or 5C
        return .iPhoneSE
      case 1334: // iPhone 6/6S/7/8
        return .iPhone8
      case 1920, 2208: // iPhone 6+/6S+/7+/8+
        return .iPhone8Plus
      case 2436: // iPhone X
        return .iPhoneX
      default:
        return .unknown
      }
    }
    return .unknown
  }

}

public enum DeviceType {
  case iPhoneX, iPhone8Plus, iPhone8, iPhoneSE, unknown
}
