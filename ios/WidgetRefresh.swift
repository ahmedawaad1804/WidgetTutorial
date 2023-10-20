//
//  File.swift
//  WidgetTutorial
//
//  Created by Ahmed Awaad on 20/10/2023.
//

import Foundation
import WidgetKit

@objc(WidgetRefresh) class WidgetRefresh: NSObject {
  
  @objc public func refreshWidget() {
    if #available(iOS 14.0, *) {
      WidgetCenter.shared.reloadAllTimelines()
    } else {
      // Fallback on earlier versions
    }
    
    
  }

}
